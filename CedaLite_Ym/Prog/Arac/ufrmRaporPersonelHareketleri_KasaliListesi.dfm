object frmRaporPersonelHareketleri_KasaliListesi: TfrmRaporPersonelHareketleri_KasaliListesi
  Left = 138
  Top = 188
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'Genel Personel Hareketleri Listesi'
  ClientHeight = 298
  ClientWidth = 309
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 309
    Height = 257
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object chk_Sirket: TCheckBox
        Left = 23
        Top = 176
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnEnter = chk_SirketEnter
        OnExit = chk_SirketExit
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 46
        Width = 301
        Height = 73
        Align = alTop
        Caption = 'Personel Kod Aral'#305#287#305
        TabOrder = 0
        object txtProjeKod1: TEdit
          Left = 8
          Top = 16
          Width = 119
          Height = 21
          TabOrder = 0
          OnEnter = txtProjeKod1Enter
          OnExit = txtProjeKod1Exit
          OnKeyDown = txtProjeKod1KeyDown
          OnKeyPress = txtProjeKod1KeyPress
        end
        object Button1: TButton
          Left = 8
          Top = 38
          Width = 119
          Height = 25
          Caption = '&Personel Listesi'
          TabOrder = 1
          TabStop = False
          OnClick = Button1Click
        end
        object txtProjeKod2: TEdit
          Left = 134
          Top = 16
          Width = 119
          Height = 21
          TabOrder = 2
          OnEnter = txtProjeKod1Enter
          OnExit = txtProjeKod2Exit
          OnKeyDown = txtProjeKod2KeyDown
          OnKeyPress = txtProjeKod1KeyPress
        end
        object Button2: TButton
          Left = 142
          Top = 38
          Width = 119
          Height = 25
          Caption = 'P&ersonel Listesi'
          TabOrder = 3
          TabStop = False
          OnClick = Button2Click
        end
      end
      object grpSube: TGroupBox
        Left = 0
        Top = 121
        Width = 280
        Height = 49
        Caption = #350'ube Ad'#305
        TabOrder = 1
        Visible = False
        object cmbSube: TComboBox
          Left = 70
          Top = 18
          Width = 129
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnEnter = cmbSubeEnter
          OnExit = cmbSubeExit
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 301
        Height = 46
        Align = alTop
        Caption = 'Tarih Aral'#305#287#305
        TabOrder = 3
        object dtpIslemTar1: TDateTimePicker
          Left = 6
          Top = 16
          Width = 100
          Height = 21
          Date = 37554.733220983800000000
          Time = 37554.733220983800000000
          Checked = False
          TabOrder = 0
        end
        object dtpIslemTar2: TDateTimePicker
          Left = 171
          Top = 15
          Width = 100
          Height = 21
          Date = 37554.733416122690000000
          Time = 37554.733416122690000000
          Checked = False
          TabOrder = 1
        end
      end
      object Cb_Yeni_Sayfa: TCheckBox
        Left = 23
        Top = 200
        Width = 154
        Height = 17
        Caption = 'Her Personel Yeni Sayfada'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnEnter = chk_SirketEnter
        OnExit = chk_SirketExit
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Ko'#351'ullar'
      ImageIndex = 1
      object Label3: TLabel
        Left = 6
        Top = -2
        Width = 40
        Height = 13
        Caption = 'S'#305'ralama'
      end
      object cmb_sirala: TComboBox
        Left = 6
        Top = 12
        Width = 250
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnEnter = cmbSubeEnter
        OnExit = cmbSubeExit
        Items.Strings = (
          'Personel Koduna G'#246're'
          'Personel Ad'#305'na G'#246're')
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 265
    Width = 309
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 5
      Top = 4
      Width = 76
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object Button3: TButton
      Left = 208
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object Btn_Fast: TButton
      Left = 107
      Top = 5
      Width = 77
      Height = 24
      Caption = '&Rapor'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object qryRapor: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\Transport.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT P.PERSONEL_KOD '
      '     , P.ADI_SOYADI '
      '     , P.SICIL_NO '
      '     , P.SSK_NO '
      '     , P.GIRIS_TARIH '
      '     , P.CIKIC_TARIH '
      '     , P.DOGUM_TARIH '
      '     , P.DOGUM_YER '
      '     , P.CINSIYET '
      '     , P.TAHSIL '
      '     , P.EVLI '
      '     , P.GOREVI '
      '     , P.VERGI_NO '
      '     , P.VERGI_DAIRE '
      '     , P.VERGI_KARNE_TARIH '
      '     , P.TEL_NO '
      '     , P.LISTEDEN_CIKAR '
      '     , P.BORC '
      '     , P.ALACAK '
      '     , ARAC.PLAKA AS ARAC_PLAKA'
      '     , ARAC.ARAC_KOD'
      'FROM PERSONEL P'
      
        ' LEFT OUTER JOIN ARAC ON (ARAC.PERSONEL_KOD=PERSONEL.PERSONEL_KO' +
        'D) ')
    ColorScheme = False
    DefaultValues.Strings = (
      'BORC=0'
      'ALACAK=0')
    KeyLinks.Strings = (
      'PERSONEL.PERSONEL_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 204
    Top = 73
  end
  object qryRaporH: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\Transport.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT SEFER_ID '
      ', SEFER_SID'
      ', SEFER_SAY'
      ', ARAC_KOD'
      
        ',(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER.ARAC_KOD) AS ' +
        'ARAC_PLAKA'
      ', ALICI_KOD '
      
        ',(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SEFER.ALICI_KOD) ' +
        'AS ALICI_ADI '
      ', SATICI_KOD '
      
        ',(SELECT CARI_AD FROM CARI WHERE SEFER.SATICI_KOD=CARI.CARI_KOD)' +
        ' AS SATICI_ADI '
      ', PERSONEL_KOD '
      
        ',(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=SE' +
        'FER.PERSONEL_KOD) AS PERSONEL_ADI'
      ', OLCU_TIP '
      ', OLCU_BIRIM '
      ', TASINAN_ESYA '
      ', BAS_TAR '
      ', BIT_TAR '
      ', CIK_YER '
      ', BIT_YER '
      ', ALICI_BORC_BIRIM_FIY '
      ', ALICI_B_DOVKOD '
      ', ALICI_BORC '
      ', ALICI_BORC_VPB '
      ', SATICI_ALACAK_BIRIM_FIY '
      ', SATICI_A_DOVKOD'
      ', SATICI_ALACAK '
      ', SATICI_ALACAK_VPB '
      ', BEKLEME_FAT_VAR '
      ', BEKLEME_FAT_TUTAR '
      ', BEKLEME_FAT_DOV_KOD '
      ', BEKLEME_FAT_VPB'
      ', SEFER_NOTLARI'
      ', SEFER_ALIS_FAT_ALINDI '
      ', SEFER_SATIS_FAT_KESILDI'
      ', MASRAF_MERK '
      ', KOD1 '
      ', KOD2 '
      ', KOD3 '
      ', KOD4 '
      ', ALICI_B_DOV_BAZ_TAR '
      ', SATICI_A_DOV_BAZ_TAR '
      ', BEKLEME_FAT_DOV_BAZ_TAR'
      ', ALICI_B_DOVKUR '
      ', SATICI_A_DOVKUR '
      ', BEKLEME_FAT_DOVKUR '
      ', SEFER_TAMAMLANDI '
      ', DORSE_KOD'
      ', ALIS_URUN_HAR_ID '
      ', SATIS_URUN_HAR_ID'
      ', SECIM '
      ', BEKLEME_FATURASI_KESILDI'
      ', BEK_FAT_URUN_HAR_ID'
      ', MIKTAR'
      ', FATURA_MIK_SEF'
      'FROM SEFER K'
      'WHERE SEFER_ID>0 '
      '')
    ColorScheme = False
    KeyLinks.Strings = (
      'SEFER.SEFER_ID')
    MasterSource = IB_DataSource1
    MasterLinks.Strings = (
      'PERSONEL_KOD=PERSONEL_KOD'
      'ARAC_KOD=ARAC_KOD')
    MasterSearch = True
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 204
    Top = 129
    ParamValues = (
      'PERSONEL_KOD='
      'MLNK_PERSONEL_KOD_0=PER010000000025')
  end
  object frxReport1: TfrxReport
    Version = '4.0.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.MDIChild = True
    PreviewOptions.Modal = False
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmPageWidth
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39139.806122685200000000
    ReportOptions.LastChange = 39149.636307233800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 124
    Top = 75
    Datasets = <
      item
        DataSet = frxIBODataset1
        DataSetName = 'frxIBODataset1'
      end
      item
        DataSet = frxIBODataset2
        DataSetName = 'frxIBODataset2'
      end>
    Variables = <>
    Style = <>
  end
  object frxIBODataset1: TfrxIBODataset
    UserName = 'frxIBODataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'PERSONEL_KOD=PERSONEL_KOD'
      'ADI_SOYADI=ADI_SOYADI'
      'SICIL_NO=SICIL_NO'
      'SSK_NO=SSK_NO'
      'GIRIS_TARIH=GIRIS_TARIH'
      'CIKIC_TARIH=CIKIC_TARIH'
      'DOGUM_TARIH=DOGUM_TARIH'
      'DOGUM_YER=DOGUM_YER'
      'CINSIYET=CINSIYET'
      'TAHSIL=TAHSIL'
      'EVLI=EVLI'
      'GOREVI=GOREVI'
      'VERGI_NO=VERGI_NO'
      'VERGI_DAIRE=VERGI_DAIRE'
      'VERGI_KARNE_TARIH=VERGI_KARNE_TARIH'
      'TEL_NO=TEL_NO'
      'LISTEDEN_CIKAR=LISTEDEN_CIKAR'
      'BORC=BORC'
      'ALACAK=ALACAK'
      'ARAC_PLAKA=ARAC_PLAKA'
      'ARAC_KOD=ARAC_KOD')
    DataSet = qryRapor
    Left = 188
    Top = 35
  end
  object frxIBODataset2: TfrxIBODataset
    UserName = 'frxIBODataset2'
    CloseDataSource = False
    FieldAliases.Strings = (
      'SEFER_ID=SEFER_ID'
      'SEFER_SID=SEFER_SID'
      'SEFER_SAY=SEFER_SAY'
      'ARAC_KOD=ARAC_KOD'
      'ARAC_PLAKA=ARAC_PLAKA'
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
      'BEKLEME_FAT_VAR=BEKLEME_FAT_VAR'
      'BEKLEME_FAT_TUTAR=BEKLEME_FAT_TUTAR'
      'BEKLEME_FAT_DOV_KOD=BEKLEME_FAT_DOV_KOD'
      'BEKLEME_FAT_VPB=BEKLEME_FAT_VPB'
      'SEFER_NOTLARI=SEFER_NOTLARI'
      'SEFER_ALIS_FAT_ALINDI=SEFER_ALIS_FAT_ALINDI'
      'SEFER_SATIS_FAT_KESILDI=SEFER_SATIS_FAT_KESILDI'
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
      'DORSE_KOD=DORSE_KOD'
      'ALIS_URUN_HAR_ID=ALIS_URUN_HAR_ID'
      'SATIS_URUN_HAR_ID=SATIS_URUN_HAR_ID'
      'SECIM=SECIM'
      'BEKLEME_FATURASI_KESILDI=BEKLEME_FATURASI_KESILDI'
      'BEK_FAT_URUN_HAR_ID=BEK_FAT_URUN_HAR_ID'
      'MIKTAR=MIKTAR'
      'FATURA_MIK_SEF=FATURA_MIK_SEF')
    DataSet = qryRaporH
    Left = 224
    Top = 168
  end
  object IB_DataSource1: TIB_DataSource
    Dataset = qryRapor
    Left = 252
    Top = 73
  end
  object IB_DataSource2: TIB_DataSource
    Dataset = qryRaporH
    Left = 252
    Top = 137
  end
end
