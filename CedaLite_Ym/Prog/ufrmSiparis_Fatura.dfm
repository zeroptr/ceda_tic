object frmSiparis_Fatura: TfrmSiparis_Fatura
  Left = 167
  Top = 235
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Sipari'#351' Faturala'#351't'#305'rma'
  ClientHeight = 442
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
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
    Width = 146
    Height = 13
    Caption = 'Cariye Ait Siparisler ve detaylar'#305
  end
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 72
    Width = 766
    Height = 136
    CustomGlyphsSupplied = []
    DataSource = dtsSiparis
    OnDblClick = IB_Grid1DblClick
    ReadOnly = True
    TabOrder = 0
    OnExit = IB_Grid1Exit
    OnKeyDown = IB_Grid1KeyDown
    RowSelect = True
  end
  object IB_Grid2: TIB_Grid
    Left = 0
    Top = 208
    Width = 760
    Height = 202
    CustomGlyphsSupplied = []
    DataSource = dstSiparis_D
    Align = alBottom
    OnDblClick = IB_Grid2DblClick
    ReadOnly = True
    TabOrder = 1
    OnExit = IB_Grid2Exit
    OnKeyDown = IB_Grid2KeyDown
    RowSelect = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 410
    Width = 760
    Height = 32
    Align = alBottom
    TabOrder = 2
    object SpeedButton1: TSpeedButton
      Left = 8
      Top = 3
      Width = 153
      Height = 25
      Caption = 'Se'#231'ilen Sipari'#351'leri Faturala'#351't'#305'r'
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
  object Memo1: TMemo
    Left = 328
    Top = -24
    Width = 401
    Height = 81
    Lines.Strings = (
      
        'ana ve deyatya t'#252'm'#252'n'#252' se'#231' butonuve tersi chak baox ile se'#231'tirme ' +
        'kald'#305'rma '
      'yap'#305'labilir')
    TabOrder = 3
    Visible = False
  end
  object qrySiparis: TIB_Query
    ColumnAttributes.Strings = (
      'SECIM=BOOLEAN=1,0')
    DatabaseName = 'c:\CedaLite\Db\Cevresel_2006.FDB'
    FieldsDisplayFormat.Strings = (
      'BRUT_TOP=#,##.00'
      'NET_TOP=#,##'
      'GENEL_TOP=#,##'
      'KDV_TOP=#,##.'
      'KDV1=#,##'
      'KDV2=#,##'
      'KDV3=#,##'
      'KDV4=#,##'
      'KDV5=#,##'
      'OTV=#,##'
      'KALEM_ISKONTO_TOPLAM_VPB=#,##.00'
      'ISKONTO_TUTAR_VPB=#,##.00'
      'ISKONTO_TOPLAM_VPB=#,##.00')
    FieldsDisplayLabel.Strings = (
      'KASA_AD=Kasa Ad'#305
      'CARI_AD=Cari Ad'#305
      'DEPO_AD=Depo Ad'#305
      'PLASIYER_AD=Plasiyer Ad'#305
      'PROJE_KOD=Proje Kodu'
      'PROJE_AD=Proje Ad'#305
      'YEV_ACIKLAMA=Yevmiye ACK'
      'VADE_GUN=Teslim G'#252'n'#252
      'VADE_TARIH=TeslimTarihi'
      'FAT_IRS_TIP=Sipari'#351' Tipi'
      'DOV_BAZ_TAR=D'#246'v.Baz.Tarihi'
      'KASA_KOD=Kasa Kodu'
      'DEPO_KOD=Depo Kodu'
      'PLASIYER_KOD=Plasiyer Kodu'
      'ACIKLAMA=A'#231#305'klama'
      'TARIH='#304#351'lem Tarihi'
      'CARI_KOD=Cari Kodu'
      'KDV1_ORAN=Tutar'
      'KDV2_ORAN=Tutar'
      'KDV3_ORAN=Tutar'
      'KDV4_ORAN=Tutar'
      'KDV5_ORAN=Tutar'
      'ISKONTO_TUTAR_VPB='#304'skonto Tutar'#305
      'ISKONTO_ORAN='#304'skonto Oran'#305
      'SECIM=Se'#231'im'
      'BELGE_NO=Belge no'
      'FAT_IRS_SERI=Seri no')
    FieldsDisplayWidth.Strings = (
      'BELGE_NO=122'
      'CARI_KOD=65')
    FieldsIndex.Strings = (
      'FAT_IRS_SEP'
      'FAT_IRS_ID'
      'FAT_IRS_SID'
      'SECIM'
      'CARI_KOD'
      'CARI_AD'
      'YEV_ACIKLAMA'
      'FAT_IRS_SERI'
      'BELGE_NO'
      'TARIH'
      'REF_BELGE_TUR'
      'REF_BELGE_ID'
      'REF_BELGE_SID'
      'ACIKLAMA'
      'VADE_GUN'
      'BRUT_TOP'
      'NET_TOP'
      'GENEL_TOP'
      'KDV_TOP'
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
      'PROJE_AD')
    FieldsVisible.Strings = (
      'FAT_IRS_SEP=FALSE'
      'FAT_IRS_ID=FALSE'
      'FAT_IRS_SID=FALSE'
      'REF_BELGE_TUR=FALSE'
      'REF_BELGE_ID=FALSE'
      'REF_BELGE_SID=FALSE'
      'KDV1=FALSE'
      'KDV2=FALSE'
      'KDV3=FALSE'
      'KDV4=FALSE'
      'KDV5=FALSE'
      'OTV=FALSE'
      'KDV1_ORAN=FALSE'
      'KDV2_ORAN=FALSE'
      'KDV3_ORAN=FALSE'
      'KDV4_ORAN=FALSE'
      'KDV5_ORAN=FALSE'
      'YAZILDI=FALSE'
      'IPTAL=FALSE'
      'TIP=FALSE'
      'KASA_AD=FALSE'
      'CARI_AD=TRUE'
      'DEPO_AD=FALSE'
      'PLASIYER_AD=FALSE'
      'PROJE_KOD=FALSE'
      'PROJE_AD=FALSE'
      'KOD1=FALSE'
      'KOD2=FALSE'
      'KOD3=FALSE'
      'KOD4=FALSE'
      'BRUT_TOP=FALSE'
      'NET_TOP=FALSE'
      'GENEL_TOP=FALSE'
      'KDV_TOP=FALSE'
      'PLASIYER_KOD=FALSE'
      'DEPO_KOD=FALSE'
      'KALEM_ISKONTO_TOPLAM_VPB=FALSE'
      'ISKONTO_TIP=FALSE'
      'ISKONTO_ORAN=FALSE'
      'ISKONTO_TUTAR_VPB=FALSE'
      'ISKONTO_TOPLAM_VPB=FALSE'
      'MUHTELIF=FALSE'
      'MASRAF_MERK=FALSE'
      'SAAT=FALSE'
      'KASA_KOD=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    SQL.Strings = (
      'SELECT distinct SIPARIS.FAT_IRS_SEP     '
      '     , SIPARIS.FAT_IRS_ID'
      '     , SIPARIS.FAT_IRS_SID'
      '     , SIPARIS.CARI_KOD'
      '     , SIPARIS.FAT_IRS_SERI'
      '     , SIPARIS.BELGE_NO'
      '     , SIPARIS.TARIH'
      '     , SIPARIS.REF_BELGE_TUR'
      '     , SIPARIS.REF_BELGE_ID'
      '     , SIPARIS.REF_BELGE_SID'
      '     , SIPARIS.ACIKLAMA'
      '     , SIPARIS.BRUT_TOP'
      '     , SIPARIS.NET_TOP'
      '     , SIPARIS.GENEL_TOP'
      '     , SIPARIS.KDV_TOP'
      '     , SIPARIS.TIP'
      '     , SIPARIS.YAZILDI'
      '     , SIPARIS.IPTAL'
      '     , SIPARIS.PLASIYER_KOD  '
      '     , SIPARIS.DEPO_KOD'
      '     , SIPARIS.SAAT'
      '     , SIPARIS.KALEM_ISKONTO_TOPLAM_VPB'
      '     , SIPARIS.ISKONTO_TIP'
      '     , SIPARIS.ISKONTO_ORAN'
      '     , SIPARIS.ISKONTO_TUTAR_VPB'
      '     , SIPARIS.ISKONTO_TOPLAM_VPB'
      '     , SIPARIS.KDV1'
      '     , SIPARIS.KDV2'
      '     , SIPARIS.KDV3'
      '     , SIPARIS.KDV4'
      '     , SIPARIS.KDV5'
      '     , SIPARIS.OTV'
      '     , SIPARIS.VADE_GUN'
      '     , SIPARIS.VADE_TARIH'
      '     , SIPARIS.FAT_IRS_TIP'
      '     , SIPARIS.KDV1_ORAN'
      '     , SIPARIS.KDV2_ORAN'
      '     , SIPARIS.KDV3_ORAN'
      '     , SIPARIS.KDV4_ORAN'
      '     , SIPARIS.KDV5_ORAN'
      '     , SIPARIS.DOV_BAZ_TAR'
      '     , SIPARIS.MUHTELIF'
      '     , SIPARIS.KASA_KOD'
      '     , SIPARIS.MASRAF_MERK'
      '     , SIPARIS.KOD1'
      '     , SIPARIS.KOD2'
      '     , SIPARIS.KOD3'
      '     , SIPARIS.KOD4      '
      
        '     , (Select KASA.ACIKLAMA From KASA where KASA.KASA_KOD=SIPAR' +
        'IS.KASA_KOD) as KASA_AD'
      
        '     , (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=SIPARI' +
        'S.CARI_KOD) As CARI_AD   '
      
        '     , (Select DEPO.ADI From DEPO Where DEPO.DEPO_KOD=SIPARIS.DE' +
        'PO_KOD ) As DEPO_AD'
      
        '     , (Select PLASIYER.ADISOY from PLASIYER Where PLASIYER.PLAS' +
        'IYER_KOD=SIPARIS.PLASIYER_KOD) AS PLASIYER_AD'
      '     , SIPARIS.PROJE_KOD'
      
        '     , (Select PROJE.PROJE_AD From PROJE Where PROJE.PROJE_KOD=S' +
        'IPARIS.PROJE_KOD) As PROJE_AD'
      '     , SIPARIS.YEV_ACIKLAMA'
      '     , SIPARIS.SECIM'
      'FROM SIPARIS'
      
        'INNER JOIN SIPARIS_D ON (SIPARIS_D.FATURA_ID=SIPARIS.FAT_IRS_ID ' +
        'And SIPARIS_D.FATURA_SID=SIPARIS.FAT_IRS_SID'
      'and SIPARIS_D.AKTARILAN_MIKTAR<SIPARIS_D.MIKTAR)'
      ''
      
        'WHERE SIPARIS.FAT_IRS_SEP=:PRM_FAT_IRS_SEP AND SIPARIS.CARI_KOD=' +
        ':PRM_CARI_KOD AND SIPARIS.TIP=:TIP')
    ColorScheme = False
    DefaultValues.Strings = (
      'KDV1=0'
      'KDV2=0'
      'KDV3=0'
      'KDV4=0'
      'KDV5=0'
      'OTV=0'
      'YAZILDI=0'
      'IPTAL=0'
      'REF_BELGE_ID=0')
    DeleteSQL.Strings = (
      'DELETE FROM SIPARIS'
      'WHERE'
      '   FAT_IRS_ID = :OLD_FAT_IRS_ID AND'
      '   FAT_IRS_SEP = :OLD_FAT_IRS_SEP AND'
      '   FAT_IRS_SID = :OLD_FAT_IRS_SID')
    EditSQL.Strings = (
      'UPDATE SIPARIS SET'
      '   FAT_IRS_ID = :FAT_IRS_ID, /*PK*/'
      '   FAT_IRS_SEP = :FAT_IRS_SEP, /*PK*/'
      '   FAT_IRS_SID = :FAT_IRS_SID, /*PK*/'
      '   SECIM = :SECIM,'
      '   CARI_KOD = :CARI_KOD,'
      '   YEV_ACIKLAMA = :YEV_ACIKLAMA,'
      '   FAT_IRS_SERI = :FAT_IRS_SERI,'
      '   BELGE_NO = :BELGE_NO,'
      '   TARIH = :TARIH,'
      '   REF_BELGE_TUR = :REF_BELGE_TUR,'
      '   REF_BELGE_ID = :REF_BELGE_ID,'
      '   REF_BELGE_SID = :REF_BELGE_SID,'
      '   ACIKLAMA = :ACIKLAMA,'
      '   VADE_GUN = :VADE_GUN,'
      '   BRUT_TOP = :BRUT_TOP,'
      '   NET_TOP = :NET_TOP,'
      '   GENEL_TOP = :GENEL_TOP,'
      '   KDV_TOP = :KDV_TOP,'
      '   TIP = :TIP,'
      '   YAZILDI = :YAZILDI,'
      '   IPTAL = :IPTAL,'
      '   PLASIYER_KOD = :PLASIYER_KOD,'
      '   DEPO_KOD = :DEPO_KOD,'
      '   SAAT = :SAAT,'
      '   KALEM_ISKONTO_TOPLAM_VPB = :KALEM_ISKONTO_TOPLAM_VPB,'
      '   ISKONTO_TIP = :ISKONTO_TIP,'
      '   ISKONTO_ORAN = :ISKONTO_ORAN,'
      '   ISKONTO_TUTAR_VPB = :ISKONTO_TUTAR_VPB,'
      '   ISKONTO_TOPLAM_VPB = :ISKONTO_TOPLAM_VPB,'
      '   KDV1 = :KDV1,'
      '   KDV2 = :KDV2,'
      '   KDV3 = :KDV3,'
      '   KDV4 = :KDV4,'
      '   KDV5 = :KDV5,'
      '   OTV = :OTV,'
      '   VADE_TARIH = :VADE_TARIH,'
      '   FAT_IRS_TIP = :FAT_IRS_TIP,'
      '   KDV1_ORAN = :KDV1_ORAN,'
      '   KDV2_ORAN = :KDV2_ORAN,'
      '   KDV3_ORAN = :KDV3_ORAN,'
      '   KDV4_ORAN = :KDV4_ORAN,'
      '   KDV5_ORAN = :KDV5_ORAN,'
      '   DOV_BAZ_TAR = :DOV_BAZ_TAR,'
      '   MUHTELIF = :MUHTELIF,'
      '   KASA_KOD = :KASA_KOD,'
      '   MASRAF_MERK = :MASRAF_MERK,'
      '   KOD1 = :KOD1,'
      '   KOD2 = :KOD2,'
      '   KOD3 = :KOD3,'
      '   KOD4 = :KOD4,'
      '   PROJE_KOD = :PROJE_KOD'
      'WHERE'
      '   FAT_IRS_ID = :OLD_FAT_IRS_ID AND'
      '   FAT_IRS_SEP = :OLD_FAT_IRS_SEP AND'
      '   FAT_IRS_SID = :OLD_FAT_IRS_SID')
    InsertSQL.Strings = (
      'INSERT INTO SIPARIS('
      '   FAT_IRS_ID, /*PK*/'
      '   FAT_IRS_SEP, /*PK*/'
      '   FAT_IRS_SID, /*PK*/'
      '   SECIM,'
      '   CARI_KOD,'
      '   YEV_ACIKLAMA,'
      '   FAT_IRS_SERI,'
      '   BELGE_NO,'
      '   TARIH,'
      '   REF_BELGE_TUR,'
      '   REF_BELGE_ID,'
      '   REF_BELGE_SID,'
      '   ACIKLAMA,'
      '   VADE_GUN,'
      '   BRUT_TOP,'
      '   NET_TOP,'
      '   GENEL_TOP,'
      '   KDV_TOP,'
      '   TIP,'
      '   YAZILDI,'
      '   IPTAL,'
      '   PLASIYER_KOD,'
      '   DEPO_KOD,'
      '   SAAT,'
      '   KALEM_ISKONTO_TOPLAM_VPB,'
      '   ISKONTO_TIP,'
      '   ISKONTO_ORAN,'
      '   ISKONTO_TUTAR_VPB,'
      '   ISKONTO_TOPLAM_VPB,'
      '   KDV1,'
      '   KDV2,'
      '   KDV3,'
      '   KDV4,'
      '   KDV5,'
      '   OTV,'
      '   VADE_TARIH,'
      '   FAT_IRS_TIP,'
      '   KDV1_ORAN,'
      '   KDV2_ORAN,'
      '   KDV3_ORAN,'
      '   KDV4_ORAN,'
      '   KDV5_ORAN,'
      '   DOV_BAZ_TAR,'
      '   MUHTELIF,'
      '   KASA_KOD,'
      '   MASRAF_MERK,'
      '   KOD1,'
      '   KOD2,'
      '   KOD3,'
      '   KOD4,'
      '   PROJE_KOD)'
      'VALUES ('
      '   :FAT_IRS_ID,'
      '   :FAT_IRS_SEP,'
      '   :FAT_IRS_SID,'
      '   :SECIM,'
      '   :CARI_KOD,'
      '   :YEV_ACIKLAMA,'
      '   :FAT_IRS_SERI,'
      '   :BELGE_NO,'
      '   :TARIH,'
      '   :REF_BELGE_TUR,'
      '   :REF_BELGE_ID,'
      '   :REF_BELGE_SID,'
      '   :ACIKLAMA,'
      '   :VADE_GUN,'
      '   :BRUT_TOP,'
      '   :NET_TOP,'
      '   :GENEL_TOP,'
      '   :KDV_TOP,'
      '   :TIP,'
      '   :YAZILDI,'
      '   :IPTAL,'
      '   :PLASIYER_KOD,'
      '   :DEPO_KOD,'
      '   :SAAT,'
      '   :KALEM_ISKONTO_TOPLAM_VPB,'
      '   :ISKONTO_TIP,'
      '   :ISKONTO_ORAN,'
      '   :ISKONTO_TUTAR_VPB,'
      '   :ISKONTO_TOPLAM_VPB,'
      '   :KDV1,'
      '   :KDV2,'
      '   :KDV3,'
      '   :KDV4,'
      '   :KDV5,'
      '   :OTV,'
      '   :VADE_TARIH,'
      '   :FAT_IRS_TIP,'
      '   :KDV1_ORAN,'
      '   :KDV2_ORAN,'
      '   :KDV3_ORAN,'
      '   :KDV4_ORAN,'
      '   :KDV5_ORAN,'
      '   :DOV_BAZ_TAR,'
      '   :MUHTELIF,'
      '   :KASA_KOD,'
      '   :MASRAF_MERK,'
      '   :KOD1,'
      '   :KOD2,'
      '   :KOD3,'
      '   :KOD4,'
      '   :PROJE_KOD)')
    KeyLinks.Strings = (
      'SIPARIS.FAT_IRS_SEP'
      'SIPARIS.FAT_IRS_ID'
      'SIPARIS.FAT_IRS_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItems.Strings = (
      'Se'#231'im=SIPARIS.SECIM;SIPARIS.SECIM DESC'
      'Cari Kodu=SIPARIS.CARI_KOD;SIPARIS.CARI_KOD DESC'
      'Cari Ad'#305'=SIPARIS.CARI_AD;SIPARIS.CARI_AD DESC'
      'Seri no=SIPARIS.FAT_IRS_SERI;SIPARIS.FAT_IRS_SERI DESC'
      #304#351'lem Tarihi=SIPARIS.TARIH;SIPARIS.TARIH DESC'
      'Plasiyer Kodu=SIPARIS.PLASIYER_KOD;SIPARIS.PLASIYER_KOD DESC'
      'Depo Kodu=SIPARIS.DEPO_KOD;SIPARIS.DEPO_KOD DESC'
      'Kasa Kodu=SIPARIS.KASA_KOD;SIPARIS.KASA_KOD DESC'
      'Kasa Ad'#305'=SIPARIS.KASA_AD;SIPARIS.KASA_AD DESC'
      'Depo Ad'#305'=SIPARIS.DEPO_AD;SIPARIS.DEPO_AD DESC'
      'Plasiyer Ad'#305'=SIPARIS.PLASIYER_AD;SIPARIS.PLASIYER_AD DESC'
      'Proje Kodu=SIPARIS.PROJE_KOD;SIPARIS.PROJE_KOD DESC')
    OrderingLinks.Strings = (
      'SIPARIS.SECIM=ITEM=1'
      'SIPARIS.CARI_KOD=ITEM=2'
      'SIPARIS.CARI_AD=ITEM=3'
      'SIPARIS.FAT_IRS_SERI=ITEM=4'
      'SIPARIS.TARIH=ITEM=5'
      'SIPARIS.PLASIYER_KOD=ITEM=6'
      'SIPARIS.DEPO_KOD=ITEM=7'
      'SIPARIS.KASA_KOD=ITEM=8'
      'SIPARIS.KASA_AD=ITEM=9'
      'SIPARIS.DEPO_AD=ITEM=10'
      'SIPARIS.PLASIYER_AD=ITEM=11'
      'SIPARIS.PROJE_KOD=ITEM=12')
    RequestLive = True
    AfterPost = qrySiparisAfterPost
    AfterScroll = qrySiparisAfterScroll
    BeforePost = qrySiparisBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 156
    Top = 307
    ParamValues = (
      'PRM_FAT_IRS_SEP=0')
  end
  object qrySiparis_D: TIB_Query
    CalculatedFields.Strings = (
      'FARK1=FLOAT')
    ColumnAttributes.Strings = (
      'SECIM=BOOLEAN=1,0')
    DatabaseName = 'c:\CedaLite\Db\Cevresel_2006.FDB'
    FieldsDisplayFormat.Strings = (
      'ISKONTO_ORAN=#,##.00'
      'ISKONTO_TUTAR=#,##.00'
      'ISKONTO_TUTAR_VPB=#,##.00'
      'KDV=#,##.00'
      'KDV_TUTAR=#,##.00'
      'BIRIM_FIY=#,##.00'
      'BIRIM_FIY_VPB=#,##.00'
      'BIRIM_FIY_URN_DOVKOD=#,##.00'
      'DOVKUR=#,##.00'
      'TUTAR=#,##.00'
      'TUTAR_VPB=#,##.00'
      'URUN_DOVKOD=#,##.00'
      'TUTAR_URUN_DOVKOD=#,##.00'
      'MIKTAR=#,##.00'
      'MIKTAR_URN_OB=#,##.00'
      'TARIH=Tarihi'
      'DOV_BAZ_TAR=D'#246'viz Baz Tarihi'
      'BELGE_TUR=Belge T'#252'r'#252)
    FieldsDisplayLabel.Strings = (
      'TUTAR=Tutar'
      'MIKTAR=Miktar'#305
      'BIRIM_FIY=Birim Fiyat'#305
      'ISKONTO_ORAN='#304's.Or.'
      'ISKONTO_TUTAR='#304'skonto Tutar'#305
      'DEPO_AD=Depo Ad'#305
      'ISKONTO_TUTAR_VPB='#304'skonto Tutar Vpb'
      'DEPO_KOD=Depo kodu'
      'TUTAR_VPB=Tutar Vbp'
      'KDV=Kdv'
      'KDV_TUTAR=Kdv Tutar'#305
      'ACIKLAMA=A'#231#305'klama'
      'DOVKOD=D'#246'viz Kodu'
      'DOVKUR=D'#246'viz Kuru'
      'URUN_KOD='#220'r'#252'n kodu'
      'URUN_AD='#220'r'#252'n Ad'#305
      'OLCUBIRIM='#214'l'#231#252' Birim'
      'SECIM=Se'#231'im'
      'FARK=Miktar Fark'#305
      'FARK1=Aktar'#305'lacak'
      'AKTARILAN_MIKTAR=Aktar'#305'lan Miktar')
    FieldsDisplayWidth.Strings = (
      'URUN_KOD=85'
      'OLCUBIRIM=73'
      'MIKTAR=74'
      'TUTAR=86'
      'TUTAR_VPB=59'
      'ACIKLAMA=139'
      'SECIM=43'
      'BIRIM_FIY=79'
      'FARK=74'
      'DOVKOD=60'
      'FARK1=71'
      'AKTARILAN_MIKTAR=80')
    FieldsIndex.Strings = (
      'URUNHAR_ID'
      'URUNHAR_SID'
      'TARIH'
      'FIILI_TAR'
      'DOV_BAZ_TAR'
      'SECIM'
      'URUN_KOD'
      'URUN_AD'
      'ACIKLAMA'
      'TIP'
      'BELGE_TUR'
      'BELGE_ID'
      'BELGE_SID'
      'BELGE_SIRA_NO'
      'OLCUBIRIM_URN_OB'
      'BIRIM_FIY'
      'MIKTAR'
      'AKTARILAN_MIKTAR'
      'FARK1'
      'TUTAR'
      'TUTAR_VPB'
      'OLCUBIRIM'
      'MIKTAR_URN_OB'
      'DOVKOD'
      'DOVKUR'
      'URUN_DOVKOD'
      'TUTAR_URUN_DOVKOD'
      'BIRIM_FIY_VPB'
      'BIRIM_FIY_URN_DOVKOD'
      'ISKONTO_TIP'
      'ISKONTO_ORAN'
      'ISKONTO_TUTAR'
      'ISKONTO_TUTAR_VPB'
      'DEPO_KOD'
      'DEPO_AD'
      'FATURA_ID'
      'FATURA_SID'
      'IRSALIYE_ID'
      'IRSALIYE_SID'
      'MASRAF_MERK'
      'KDV'
      'KDV_TUTAR'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4')
    FieldsVisible.Strings = (
      'URUNHAR_ID=FALSE'
      'URUNHAR_SID=FALSE'
      'TARIH=FALSE'
      'DOV_BAZ_TAR=FALSE'
      'FATURA_ID=FALSE'
      'FATURA_SID=FALSE'
      'IRSALIYE_ID=FALSE'
      'IRSALIYE_SID=FALSE'
      'BELGE_TUR=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE'
      'BELGE_SIRA_NO=FALSE'
      'OLCUBIRIM=TRUE'
      'OLCUBIRIM_URN_OB=FALSE'
      'FIILI_TAR=FALSE'
      'KOD1=FALSE'
      'KOD2=FALSE'
      'KOD3=FALSE'
      'KOD4=FALSE'
      'URUN_AD=FALSE'
      'TUTAR_URUN_DOVKOD=FALSE'
      'URUN_DOVKOD=FALSE'
      'MASRAF_MERK=FALSE'
      'TIP=FALSE'
      'BIRIM_FIY_VPB=FALSE'
      'BIRIM_FIY_URN_DOVKOD=FALSE'
      'MIKTAR_URN_OB=FALSE'
      'ISKONTO_TIP=FALSE'
      'ISKONTO_ORAN=FALSE'
      'ISKONTO_TUTAR=FALSE'
      'ISKONTO_TUTAR_VPB=FALSE'
      'KDV=FALSE'
      'KDV_TUTAR=FALSE'
      'DOVKUR=FALSE'
      'DEPO_KOD=FALSE'
      'DEPO_AD=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    SQL.Strings = (
      'SELECT SIPARIS_D.URUNHAR_ID'
      '     , SIPARIS_D.URUNHAR_SID'
      '     , SIPARIS_D.TARIH'
      '     , SIPARIS_D.FIILI_TAR'
      '     , SIPARIS_D.DOV_BAZ_TAR'
      '     , SIPARIS_D.URUN_KOD'
      
        '     , (SELECT  URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD=SIPAR' +
        'IS_D.URUN_KOD) AS URUN_AD'
      '     , SIPARIS_D.ACIKLAMA'
      '     , SIPARIS_D.TIP'
      '     , SIPARIS_D.BELGE_TUR'
      '     , SIPARIS_D.BELGE_ID'
      '     , SIPARIS_D.BELGE_SID'
      '     , SIPARIS_D.BELGE_SIRA_NO'
      '     , SIPARIS_D.OLCUBIRIM'
      '     , SIPARIS_D.OLCUBIRIM_URN_OB'
      '     , SIPARIS_D.MIKTAR'
      '     , SIPARIS_D.MIKTAR_URN_OB'
      '     , SIPARIS_D.DOVKOD'
      '     , SIPARIS_D.DOVKUR'
      '     , SIPARIS_D.TUTAR'
      '     , SIPARIS_D.TUTAR_VPB'
      '     , SIPARIS_D.URUN_DOVKOD'
      '     , SIPARIS_D.TUTAR_URUN_DOVKOD'
      '     , SIPARIS_D.BIRIM_FIY'
      '     , SIPARIS_D.BIRIM_FIY_VPB'
      '     , SIPARIS_D.BIRIM_FIY_URN_DOVKOD'
      '     , SIPARIS_D.ISKONTO_TIP'
      '     , SIPARIS_D.ISKONTO_ORAN'
      '     , SIPARIS_D.ISKONTO_TUTAR'
      '     , SIPARIS_D.ISKONTO_TUTAR_VPB'
      '     , SIPARIS_D.DEPO_KOD'
      
        '     , (SELECT DEPO.ADI FROM DEPO WHERE DEPO.DEPO_KOD = SIPARIS_' +
        'D.DEPO_KOD) AS DEPO_AD'
      '     , SIPARIS_D.FATURA_ID'
      '     , SIPARIS_D.FATURA_SID'
      '     , SIPARIS_D.IRSALIYE_ID'
      '     , SIPARIS_D.IRSALIYE_SID'
      '     , SIPARIS_D.MASRAF_MERK'
      '     , SIPARIS_D.KDV'
      '     , SIPARIS_D.KDV_TUTAR'
      '     , SIPARIS_D.KOD1'
      '     , SIPARIS_D.KOD2'
      '     , SIPARIS_D.KOD3'
      '     , SIPARIS_D.KOD4'
      '     , SIPARIS_D.SECIM'
      '     , AKTARILAN_MIKTAR'
      'FROM SIPARIS_D'
      
        'WHERE (SIPARIS_D.FATURA_ID=:FATURA_ID And SIPARIS_D.FATURA_SID=:' +
        'FATURA_SID)'
      'and AKTARILAN_MIKTAR<MIKTAR'
      'ORDER BY SIPARIS_D.URUNHAR_ID;')
    OnCalculateField = qrySiparis_DCalculateField
    ColorScheme = False
    DefaultValues.Strings = (
      'URUNHAR_ID=0'
      'BELGE_TUR=0'
      'BELGE_ID=0'
      'BIRIM_FIY=0'
      'MIKTAR=0'
      'MIKTAR_URN_OB=0'
      'DOVKOD=YTL'
      'DOVKUR=0'
      'TUTAR=0'
      'TUTAR_VPB=0'
      'URUN_DOVKOD=YTL'
      'TUTAR_URUN_DOVKOD=0'
      'BIRIM_FIY_VPB=0'
      'BIRIM_FIY_URN_DOVKOD=0'
      'ISKONTO_TUTAR=0'
      'ISKONTO_TUTAR_VPB=0'
      'FATURA_ID=0'
      'IRSALIYE_ID=0'
      'KDV_TUTAR=0')
    DeleteSQL.Strings = (
      'DELETE FROM SIPARIS_D'
      'WHERE'
      '   URUNHAR_ID = :OLD_URUNHAR_ID AND'
      '   URUNHAR_SID = :OLD_URUNHAR_SID')
    EditSQL.Strings = (
      'UPDATE SIPARIS_D SET'
      '   URUNHAR_ID = :URUNHAR_ID, /*PK*/'
      '   URUNHAR_SID = :URUNHAR_SID, /*PK*/'
      '   TARIH = :TARIH,'
      '   FIILI_TAR = :FIILI_TAR,'
      '   DOV_BAZ_TAR = :DOV_BAZ_TAR,'
      '   SECIM = :SECIM,'
      '   URUN_KOD = :URUN_KOD,'
      '   ACIKLAMA = :ACIKLAMA,'
      '   TIP = :TIP,'
      '   BELGE_TUR = :BELGE_TUR,'
      '   BELGE_ID = :BELGE_ID,'
      '   BELGE_SID = :BELGE_SID,'
      '   BELGE_SIRA_NO = :BELGE_SIRA_NO,'
      '   OLCUBIRIM_URN_OB = :OLCUBIRIM_URN_OB,'
      '   BIRIM_FIY = :BIRIM_FIY,'
      '   MIKTAR = :MIKTAR,'
      '   OLCUBIRIM = :OLCUBIRIM,'
      '   MIKTAR_URN_OB = :MIKTAR_URN_OB,'
      '   DOVKOD = :DOVKOD,'
      '   DOVKUR = :DOVKUR,'
      '   TUTAR = :TUTAR,'
      '   TUTAR_VPB = :TUTAR_VPB,'
      '   URUN_DOVKOD = :URUN_DOVKOD,'
      '   TUTAR_URUN_DOVKOD = :TUTAR_URUN_DOVKOD,'
      '   BIRIM_FIY_VPB = :BIRIM_FIY_VPB,'
      '   BIRIM_FIY_URN_DOVKOD = :BIRIM_FIY_URN_DOVKOD,'
      '   ISKONTO_TIP = :ISKONTO_TIP,'
      '   ISKONTO_ORAN = :ISKONTO_ORAN,'
      '   ISKONTO_TUTAR = :ISKONTO_TUTAR,'
      '   ISKONTO_TUTAR_VPB = :ISKONTO_TUTAR_VPB,'
      '   DEPO_KOD = :DEPO_KOD,'
      '   FATURA_ID = :FATURA_ID,'
      '   FATURA_SID = :FATURA_SID,'
      '   IRSALIYE_ID = :IRSALIYE_ID,'
      '   IRSALIYE_SID = :IRSALIYE_SID,'
      '   MASRAF_MERK = :MASRAF_MERK,'
      '   KDV = :KDV,'
      '   KDV_TUTAR = :KDV_TUTAR,'
      '   KOD1 = :KOD1,'
      '   KOD2 = :KOD2,'
      '   KOD3 = :KOD3,'
      '   KOD4 = :KOD4'
      'WHERE'
      '   URUNHAR_ID = :OLD_URUNHAR_ID AND'
      '   URUNHAR_SID = :OLD_URUNHAR_SID')
    InsertSQL.Strings = (
      'INSERT INTO SIPARIS_D('
      '   URUNHAR_ID, /*PK*/'
      '   URUNHAR_SID, /*PK*/'
      '   TARIH,'
      '   FIILI_TAR,'
      '   DOV_BAZ_TAR,'
      '   SECIM,'
      '   URUN_KOD,'
      '   ACIKLAMA,'
      '   TIP,'
      '   BELGE_TUR,'
      '   BELGE_ID,'
      '   BELGE_SID,'
      '   BELGE_SIRA_NO,'
      '   OLCUBIRIM_URN_OB,'
      '   BIRIM_FIY,'
      '   MIKTAR,'
      '   OLCUBIRIM,'
      '   MIKTAR_URN_OB,'
      '   DOVKOD,'
      '   DOVKUR,'
      '   TUTAR,'
      '   TUTAR_VPB,'
      '   URUN_DOVKOD,'
      '   TUTAR_URUN_DOVKOD,'
      '   BIRIM_FIY_VPB,'
      '   BIRIM_FIY_URN_DOVKOD,'
      '   ISKONTO_TIP,'
      '   ISKONTO_ORAN,'
      '   ISKONTO_TUTAR,'
      '   ISKONTO_TUTAR_VPB,'
      '   DEPO_KOD,'
      '   FATURA_ID,'
      '   FATURA_SID,'
      '   IRSALIYE_ID,'
      '   IRSALIYE_SID,'
      '   MASRAF_MERK,'
      '   KDV,'
      '   KDV_TUTAR,'
      '   KOD1,'
      '   KOD2,'
      '   KOD3,'
      '   KOD4)'
      'VALUES ('
      '   :URUNHAR_ID,'
      '   :URUNHAR_SID,'
      '   :TARIH,'
      '   :FIILI_TAR,'
      '   :DOV_BAZ_TAR,'
      '   :SECIM,'
      '   :URUN_KOD,'
      '   :ACIKLAMA,'
      '   :TIP,'
      '   :BELGE_TUR,'
      '   :BELGE_ID,'
      '   :BELGE_SID,'
      '   :BELGE_SIRA_NO,'
      '   :OLCUBIRIM_URN_OB,'
      '   :BIRIM_FIY,'
      '   :MIKTAR,'
      '   :OLCUBIRIM,'
      '   :MIKTAR_URN_OB,'
      '   :DOVKOD,'
      '   :DOVKUR,'
      '   :TUTAR,'
      '   :TUTAR_VPB,'
      '   :URUN_DOVKOD,'
      '   :TUTAR_URUN_DOVKOD,'
      '   :BIRIM_FIY_VPB,'
      '   :BIRIM_FIY_URN_DOVKOD,'
      '   :ISKONTO_TIP,'
      '   :ISKONTO_ORAN,'
      '   :ISKONTO_TUTAR,'
      '   :ISKONTO_TUTAR_VPB,'
      '   :DEPO_KOD,'
      '   :FATURA_ID,'
      '   :FATURA_SID,'
      '   :IRSALIYE_ID,'
      '   :IRSALIYE_SID,'
      '   :MASRAF_MERK,'
      '   :KDV,'
      '   :KDV_TUTAR,'
      '   :KOD1,'
      '   :KOD2,'
      '   :KOD3,'
      '   :KOD4)')
    KeyLinks.Strings = (
      'SIPARIS_D.URUNHAR_ID'
      'SIPARIS_D.URUNHAR_SID')
    MasterSource = dtsSiparis
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItems.Strings = (
      #220'r'#252'n kodu=URUN_KOD;URUN_KOD DESC'
      #220'r'#252'n Ad'#305'=URUN_AD;URUN_AD DESC'
      'A'#231#305'klama=ACIKLAMA;ACIKLAMA DESC'
      'TIP=TIP;TIP DESC'
      #214'l'#231#252' Birim=OLCUBIRIM;OLCUBIRIM DESC'
      'MIKTAR_URN_OB=MIKTAR_URN_OB;MIKTAR_URN_OB DESC'
      'D'#246'viz Kodu=DOVKOD;DOVKOD DESC'
      'D'#246'viz Kuru=DOVKUR;DOVKUR DESC'
      'Depo kodu=DEPO_KOD;DEPO_KOD DESC'
      'Depo Ad'#305'=DEPO_AD;DEPO_AD DESC')
    OrderingLinks.Strings = (
      'URUN_KOD=ITEM=1'
      'URUN_AD=ITEM=2'
      'ACIKLAMA=ITEM=3'
      'TIP=ITEM=4'
      'OLCUBIRIM=ITEM=5'
      'MIKTAR_URN_OB=ITEM=6'
      'DOVKOD=ITEM=7'
      'DOVKUR=ITEM=8'
      'DEPO_KOD=ITEM=9'
      'DEPO_AD=ITEM=10')
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 252
    Top = 307
    ParamValues = (
      'FATURA_ID=0')
  end
  object dtsSiparis: TIB_DataSource
    Dataset = qrySiparis
    Left = 156
    Top = 363
  end
  object dstSiparis_D: TIB_DataSource
    Dataset = qrySiparis_D
    Left = 252
    Top = 355
  end
  object qry_Siparis_Fat: TIB_Query
    DatabaseName = 'c:\CedaLite\Db\Cevresel_2006.FDB'
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    SQL.Strings = (
      'SELECT SIPARIS_D_FAT_ID'
      '     , SIPARIS_ID'
      '     , SIPARISD_ID'
      '     , MIKTAR'
      '     , FATURA_ID'
      '     , FATURAD_ID'
      '     , TAM_AKTARIM'
      '     , NEREDEN'
      'FROM SIPARIS_D_FAT')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 408
    Top = 319
  end
  object IB_DataSource1: TIB_DataSource
    Left = 408
    Top = 368
  end
  object trnFAT_IRS: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 148
    Top = 202
  end
  object qry: TIB_Query
    DatabaseName = 'c:\CedaLite\Db\Cevresel_2006.FDB'
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 480
    Top = 152
  end
end
