object frmOnarim_Fatura_Bir: TfrmOnarim_Fatura_Bir
  Left = 149
  Top = 124
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Onar'#305'm Fi'#351'i Faturala'#351't'#305'rma'
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
    Width = 166
    Height = 13
    Caption = 'Cariye Ait Onar'#305'm Fi'#351'leri ve detaylar'#305
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
    Enabled = False
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
      Width = 225
      Height = 25
      Caption = 'Se'#231'ilen Onar'#305'm Fi'#351'i Hareketlerini Faturala'#351't'#305'r'
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
    object cb_Birlestir: TCheckBox
      Left = 248
      Top = 8
      Width = 169
      Height = 17
      Caption = 'Birle'#351'tirerek Faturala'#351't'#305'r'
      TabOrder = 1
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
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
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
      'FAT_IRS_SERI=Seri no'
      'ONARIM_ID=Fi'#351' No'
      'ARAC_KODU=Ara'#231' Kodu'
      'GIRIS_TARIH=Giri'#351' Tarihi'
      'ARAC_PLAKA=Ara'#231' Plaka'
      'GELIS_NEDENI=Geli'#351' Nedeni'
      'GIRIS_KM=Giri'#351' Km'
      'ONCEKI_KM='#214'nceki Km'
      'ODEME_SEKLI='#214'deme '#350'ekli'
      'YAKIT_SEVIYESI=Yak'#305't Seviyesi'
      'GARANTI_ISLEMI=Garanti '#304#351'lemi'
      'EXSPERTIZ_ISLEMI=Expertiz '#304#351'lemi'
      'SOK_PAR_IADE=S'#246'k'#252'len Par'#231'a '#304'ade'
      'TESLIM_EDEN=Teslim Eden'
      'ALACAK_OLAN=Alacak Olan'
      'TELEFON=Telefon'
      'SIGORTA_KOD=Sigorta Kod'
      'TESLIM_TAR=Teslim Tarihi'
      'TESLIM_SAAT=Teslim Saati'
      'TAHMINI_PARCA_TUTAR=Tahmini Par'#231'a Tutar'
      'TAHMINI_ISCILIK_TUTAR=Tahmini '#304#351#231'ilik Tutar'#305
      'GIRIS_SAAT=Giri'#351' Saati'
      'ONARIM_ISTEKLERI=Onar'#305'm '#304'stekleri'
      'MUSTERI_SIKAYETI=M'#252#351'teri '#350'ikayeti'
      'SERVIS_NOTU=Sevis Notu')
    FieldsDisplayWidth.Strings = (
      'BELGE_NO=122'
      'CARI_KOD=65')
    FieldsIndex.Strings = (
      'SECIM'
      'ONARIM_ID'
      'CARI_KOD'
      'CARI_AD'
      'ARAC_KODU'
      'ARAC_PLAKA'
      'ACIKLAMA'
      'VADE_GUN'
      'BRUT_TOP'
      'NET_TOP'
      'GENEL_TOP'
      'KDV_TOP'
      'YAZILDI'
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
      'KDV1_ORAN'
      'KDV2_ORAN'
      'KDV3_ORAN'
      'KDV4_ORAN'
      'KDV5_ORAN'
      'MASRAF_MERK'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4'
      'DEPO_AD'
      'PROJE_KOD'
      'PROJE_AD'
      'ONARIM_SID'
      'GELIS_NEDENI'
      'GIRIS_KM'
      'ONCEKI_KM'
      'ODEME_SEKLI'
      'YAKIT_SEVIYESI'
      'GARANTI_ISLEMI'
      'EXSPERTIZ_ISLEMI'
      'SOK_PAR_IADE'
      'TESLIM_EDEN'
      'ALACAK_OLAN'
      'TELEFON'
      'SIGORTA_KOD'
      'TESLIM_TAR'
      'TESLIM_SAAT'
      'TAHMINI_PARCA_TUTAR'
      'TAHMINI_ISCILIK_TUTAR'
      'GIRIS_TARIH'
      'GIRIS_SAAT'
      'ONARIM_ISTEKLERI'
      'MUSTERI_SIKAYETI'
      'SERVIS_NOTU'
      'GIRIS_TARIH')
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
      'KASA_KOD=FALSE'
      'ONARIM_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    SQL.Strings = (
      'SELECT distinct '
      '      SRV_ARAC_ONARIM.ONARIM_ID'
      '     , SRV_ARAC_ONARIM.ONARIM_SID'
      '     , SRV_ARAC_ONARIM.ARAC_KODU'
      
        '     ,(SELECT PLAKA FROM SRV_ARAC WHERE SRV_ARAC_ONARIM.ARAC_KOD' +
        'U=SRV_ARAC.ARAC_KOD) AS ARAC_PLAKA'
      '     , SRV_ARAC_ONARIM.GELIS_NEDENI'
      '     , SRV_ARAC_ONARIM.GIRIS_KM'
      '     , SRV_ARAC_ONARIM.ONCEKI_KM'
      '     , SRV_ARAC_ONARIM.ODEME_SEKLI'
      '     , SRV_ARAC_ONARIM.YAKIT_SEVIYESI'
      '     , SRV_ARAC_ONARIM.GARANTI_ISLEMI'
      '     , SRV_ARAC_ONARIM.EXSPERTIZ_ISLEMI'
      '     , SRV_ARAC_ONARIM.SOK_PAR_IADE'
      '     , SRV_ARAC_ONARIM.TESLIM_EDEN'
      '     , SRV_ARAC_ONARIM.ALACAK_OLAN'
      '     , SRV_ARAC_ONARIM.TELEFON'
      '     , SRV_ARAC_ONARIM.SIGORTA_KOD'
      '     , SRV_ARAC_ONARIM.TESLIM_TAR'
      '     , SRV_ARAC_ONARIM.TESLIM_SAAT'
      '     , SRV_ARAC_ONARIM.TAHMINI_PARCA_TUTAR'
      '     , SRV_ARAC_ONARIM.TAHMINI_ISCILIK_TUTAR'
      '     , SRV_ARAC_ONARIM.GIRIS_TARIH'
      '     , SRV_ARAC_ONARIM.GIRIS_SAAT'
      '     , SRV_ARAC_ONARIM.ONARIM_ISTEKLERI'
      '     , SRV_ARAC_ONARIM.MUSTERI_SIKAYETI'
      '     , SRV_ARAC_ONARIM.SERVIS_NOTU'
      '     , SRV_ARAC_ONARIM.CARI_KOD'
      '     , SRV_ARAC_ONARIM.GIRIS_TARIH'
      '     , SRV_ARAC_ONARIM.ACIKLAMA'
      '     , SRV_ARAC_ONARIM.BRUT_TOP'
      '     , SRV_ARAC_ONARIM.NET_TOP'
      '     , SRV_ARAC_ONARIM.GENEL_TOP'
      '     , SRV_ARAC_ONARIM.KDV_TOP'
      '     , SRV_ARAC_ONARIM.YAZILDI'
      '     , SRV_ARAC_ONARIM.DEPO_KOD'
      '     , SRV_ARAC_ONARIM.SAAT'
      '     , SRV_ARAC_ONARIM.KALEM_ISKONTO_TOPLAM_VPB'
      '     , SRV_ARAC_ONARIM.ISKONTO_TIP'
      '     , SRV_ARAC_ONARIM.ISKONTO_ORAN'
      '     , SRV_ARAC_ONARIM.ISKONTO_TUTAR_VPB'
      '     , SRV_ARAC_ONARIM.ISKONTO_TOPLAM_VPB'
      '     , SRV_ARAC_ONARIM.KDV1'
      '     , SRV_ARAC_ONARIM.KDV2'
      '     , SRV_ARAC_ONARIM.KDV3'
      '     , SRV_ARAC_ONARIM.KDV4'
      '     , SRV_ARAC_ONARIM.KDV5'
      '     , SRV_ARAC_ONARIM.OTV'
      '     , SRV_ARAC_ONARIM.VADE_GUN'
      '     , SRV_ARAC_ONARIM.VADE_TARIH'
      '     , SRV_ARAC_ONARIM.KDV1_ORAN'
      '     , SRV_ARAC_ONARIM.KDV2_ORAN'
      '     , SRV_ARAC_ONARIM.KDV3_ORAN'
      '     , SRV_ARAC_ONARIM.KDV4_ORAN'
      '     , SRV_ARAC_ONARIM.KDV5_ORAN'
      '     , SRV_ARAC_ONARIM.MASRAF_MERK'
      '     , SRV_ARAC_ONARIM.KOD1'
      '     , SRV_ARAC_ONARIM.KOD2'
      '     , SRV_ARAC_ONARIM.KOD3'
      '     , SRV_ARAC_ONARIM.KOD4      '
      
        '     , (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=SRV_AR' +
        'AC_ONARIM.CARI_KOD) As CARI_AD   '
      
        '     , (Select DEPO.ADI From DEPO Where DEPO.DEPO_KOD=SRV_ARAC_O' +
        'NARIM.DEPO_KOD ) As DEPO_AD'
      '     , SRV_ARAC_ONARIM.PROJE_KOD'
      
        '     , (Select PROJE.PROJE_AD From PROJE Where PROJE.PROJE_KOD=S' +
        'RV_ARAC_ONARIM.PROJE_KOD) As PROJE_AD'
      '     , SRV_ARAC_ONARIM.SECIM'
      'FROM SRV_ARAC_ONARIM'
      
        'INNER JOIN SRV_ARAC_ONARIM_D ON (SRV_ARAC_ONARIM_D.ONARIM_ID=SRV' +
        '_ARAC_ONARIM.ONARIM_ID And SRV_ARAC_ONARIM_D.ONARIM_SID=SRV_ARAC' +
        '_ONARIM.ONARIM_SID'
      'and SRV_ARAC_ONARIM_D.FATURA_URUN_HAR_ID<=0)'
      'Where SRV_ARAC_ONARIM.CARI_KOD=:PRM_CARI_KOD')
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
    EditSQL.Strings = (
      'UPDATE SRV_ARAC_ONARIM SET'
      '   SECIM = :SECIM'
      'WHERE'
      '   ONARIM_ID = :OLD_ONARIM_ID AND'
      '   ONARIM_SID = :OLD_ONARIM_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterPost = qrySiparisAfterPost
    AfterScroll = qrySiparisAfterScroll
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 156
    Top = 307
    ParamValues = (
      'PRM_CARI_KOD=')
  end
  object qrySiparis_D: TIB_Query
    CalculatedFields.Strings = (
      'FARK1=FLOAT')
    ColumnAttributes.Strings = (
      'SECIM=BOOLEAN=1,0')
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
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
      'SELECT URUNHAR_ID'
      '     , URUNHAR_SID'
      '     , TARIH'
      '     , FIILI_TAR'
      '     , DOV_BAZ_TAR'
      '     , URUN_KOD'
      
        '     , (SELECT  URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD=SRV_A' +
        'RAC_ONARIM_D.URUN_KOD) AS URUN_AD'
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
      
        '     , (SELECT DEPO.ADI FROM DEPO WHERE DEPO.DEPO_KOD = SRV_ARAC' +
        '_ONARIM_D.DEPO_KOD) AS DEPO_AD'
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
      '     , SECIM'
      '     , AKTARILAN_MIKTAR'
      '     , FATURA_URUN_HAR_ID'
      'FROM SRV_ARAC_ONARIM_D'
      
        'WHERE (SRV_ARAC_ONARIM_D.ONARIM_ID=:ONARIM_ID And SRV_ARAC_ONARI' +
        'M_D.ONARIM_SID=:ONARIM_SID)'
      'and FATURA_URUN_HAR_ID<=0'
      'ORDER BY SRV_ARAC_ONARIM_D.URUNHAR_ID;')
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
    CachedUpdates = True
    FetchWholeRows = True
    Left = 252
    Top = 307
    ParamValues = (
      'ONARIM_ID=0')
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
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    SQL.Strings = (
      'SELECT ONARIM_D_FAT_ID'
      '     , ONARIM_ID'
      '     , ONARIMD_ID'
      '     , MIKTAR'
      '     , FATURA_ID'
      '     , FATURAD_ID'
      '     , TAM_AKTARIM'
      '     , NEREDEN'
      'FROM ONARIM_D_FAT')
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
  object qryx: TIB_Query
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
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
