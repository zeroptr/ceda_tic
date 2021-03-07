object frmRaporSefer: TfrmRaporSefer
  Left = 265
  Top = 274
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'Sefer Raporlar'#305
  ClientHeight = 259
  ClientWidth = 428
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 428
    Height = 223
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object Label1: TLabel
        Left = 2
        Top = 55
        Width = 52
        Height = 13
        Caption = 'Ara'#231' Plaka'
      end
      object Label34: TLabel
        Left = 2
        Top = 127
        Width = 73
        Height = 13
        Caption = 'M'#252#351'teri Cari Ad'#305
      end
      object Label36: TLabel
        Left = 2
        Top = 103
        Width = 74
        Height = 13
        Caption = 'Ta'#351#305'y'#305'c'#305' Cari Ad'#305
      end
      object Label19: TLabel
        Left = 234
        Top = 103
        Width = 74
        Height = 13
        Caption = 'Ta'#351#305'y'#305'c'#305' Cari Ad'#305
      end
      object Label17: TLabel
        Left = 234
        Top = 127
        Width = 73
        Height = 13
        Caption = 'M'#252#351'teri Cari Ad'#305
      end
      object LblPlaka: TLabel
        Left = 234
        Top = 55
        Width = 52
        Height = 13
        Caption = 'Ara'#231' Plaka'
      end
      object Label22: TLabel
        Left = 2
        Top = 79
        Width = 59
        Height = 13
        Caption = 'Personel Ad'#305
      end
      object Label18: TLabel
        Left = 232
        Top = 79
        Width = 185
        Height = 13
        AutoSize = False
        Caption = 'Personel Ad'#305
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 420
        Height = 46
        Align = alTop
        Caption = 'Tarih Aral'#305#287#305
        TabOrder = 0
        object dtpIslemTar1: TDateTimePicker
          Left = 102
          Top = 16
          Width = 100
          Height = 21
          Date = 37554.733220983800000000
          Time = 37554.733220983800000000
          Checked = False
          TabOrder = 0
          OnEnter = dtpIslemTar1Enter
          OnExit = dtpIslemTar1Exit
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
          OnEnter = dtpIslemTar1Enter
          OnExit = dtpIslemTar1Exit
        end
      end
      object chk_Sirket: TCheckBox
        Left = 11
        Top = 149
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 9
      end
      object TxtMazotcu: TEdit
        Left = 81
        Top = 100
        Width = 127
        Height = 21
        TabOrder = 5
        OnEnter = txtAracEnter
        OnExit = TxtMazotcuExit
        OnKeyDown = TxtMazotcuKeyDown
        OnKeyPress = txtAracKeyPress
      end
      object txtAlanCari: TEdit
        Left = 81
        Top = 124
        Width = 127
        Height = 21
        TabOrder = 7
        OnEnter = txtAracEnter
        OnExit = txtAlanCariExit
        OnKeyDown = txtAlanCariKeyDown
        OnKeyPress = txtAracKeyPress
      end
      object txtArac: TEdit
        Left = 81
        Top = 52
        Width = 127
        Height = 21
        TabOrder = 1
        OnEnter = txtAracEnter
        OnExit = txtAracExit
        OnKeyDown = txtAracKeyDown
        OnKeyPress = txtAracKeyPress
      end
      object Button6: TButton
        Left = 210
        Top = 124
        Width = 17
        Height = 20
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 210
        Top = 100
        Width = 17
        Height = 20
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        OnClick = Button7Click
      end
      object Button9: TButton
        Left = 210
        Top = 52
        Width = 17
        Height = 20
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = Button9Click
      end
      object txtAlanPers: TEdit
        Left = 81
        Top = 76
        Width = 127
        Height = 21
        TabOrder = 3
        OnEnter = txtAracEnter
        OnExit = txtAlanPersExit
        OnKeyDown = txtAlanPersKeyDown
        OnKeyPress = txtAracKeyPress
      end
      object Button8: TButton
        Left = 210
        Top = 76
        Width = 17
        Height = 20
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = Button8Click
      end
      object Cb_Yeni_Sayfa: TCheckBox
        Left = 11
        Top = 167
        Width = 154
        Height = 17
        Caption = 'Her M'#252#351'teri Yeni Sayfada'
        Checked = True
        State = cbChecked
        TabOrder = 10
      end
      object CheckBox1: TCheckBox
        Left = 230
        Top = 167
        Width = 154
        Height = 17
        Caption = 'Al'#305'c'#305' tutars'#305'z'
        TabOrder = 11
      end
      object CheckBox2: TCheckBox
        Left = 230
        Top = 149
        Width = 154
        Height = 17
        Caption = 'Tek Sat'#305'r'
        TabOrder = 12
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Ko'#351'ullar'
      ImageIndex = 1
      object lblISLEMMERKEZI: TLabel
        Left = 108
        Top = 6
        Width = 64
        Height = 13
        Caption = #304#351'lem Merkezi'
      end
      object lblKOD1: TLabel
        Left = 108
        Top = 47
        Width = 29
        Height = 13
        Caption = 'KOD1'
      end
      object txtISLEMMERKEZI: TEdit
        Left = 107
        Top = 20
        Width = 79
        Height = 21
        TabOrder = 0
        OnEnter = txtKOD1Enter
        OnExit = txtISLEMMERKEZIExit
        OnKeyUp = txtISLEMMERKEZIKeyUp
      end
      object btnISLEMMERKEZI: TButton
        Left = 187
        Top = 20
        Width = 17
        Height = 22
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btnISLEMMERKEZIClick
      end
      object txtKOD1: TEdit
        Left = 107
        Top = 61
        Width = 79
        Height = 21
        TabOrder = 2
        OnEnter = txtKOD1Enter
        OnExit = txtKOD1Exit
        OnKeyUp = txtKOD1KeyUp
      end
      object btnKOD1: TButton
        Left = 187
        Top = 60
        Width = 18
        Height = 22
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        TabStop = False
        OnClick = btnKOD1Click
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 226
    Width = 428
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 67
      Top = 4
      Width = 77
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object Button3: TButton
      Left = 279
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object Btn_Fast: TButton
      Left = 171
      Top = 3
      Width = 77
      Height = 25
      Caption = '&Rapor'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object qrySefer: TIB_Query
    ColumnAttributes.Strings = (
      'BEKLEME_FAT_VAR=BOOLEAN=1,0'
      'SEFER_ALIS_FAT_ALINDI=BOOLEAN=1,0'
      'SEFER_SATIS_FAT_KESILDI=BOOLEAN=1,0'
      'SECIM=BOOLEAN=1,0'
      'BEKLEME_FATURASI_KESILDI=BOOLEAN=1,0'
      'SEFER_TAMAMLANDI=BOOLEAN=1,0')
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
      '     , KONTEYNER_NO'
      '     , MIKTAR'
      '   , SBEKLEME_FAT_VAR'
      '   , SBEKLEME_FAT_TUTAR'
      '   , SBEKLEME_FAT_DOV_KOD'
      '   , SBEKLEME_FAT_VPB'
      '   , SBEKLEME_FAT_DOV_BAZ_TAR'
      '   , SBEKLEME_FAT_DOVKUR'
      '   , SBEKLEME_FATURASI_KESILDI'
      '   , SBEK_FAT_URUN_HAR_ID  '
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
    ReportOptions.LastChange = 39544.679740300900000000
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
      'KONTEYNER_NO=KONTEYNER_NO'
      'MIKTAR=MIKTAR'
      'SBEKLEME_FAT_VAR=SBEKLEME_FAT_VAR'
      'SBEKLEME_FAT_TUTAR=SBEKLEME_FAT_TUTAR'
      'SBEKLEME_FAT_DOV_KOD=SBEKLEME_FAT_DOV_KOD'
      'SBEKLEME_FAT_VPB=SBEKLEME_FAT_VPB'
      'SBEKLEME_FAT_DOV_BAZ_TAR=SBEKLEME_FAT_DOV_BAZ_TAR'
      'SBEKLEME_FAT_DOVKUR=SBEKLEME_FAT_DOVKUR'
      'SBEKLEME_FATURASI_KESILDI=SBEKLEME_FATURASI_KESILDI'
      'SBEK_FAT_URUN_HAR_ID=SBEK_FAT_URUN_HAR_ID')
    DataSet = qrySefer
    Left = 356
    Top = 147
  end
end
