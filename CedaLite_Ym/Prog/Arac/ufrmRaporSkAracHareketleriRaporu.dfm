object frmRaporSkAracHareketleriRaporu: TfrmRaporSkAracHareketleriRaporu
  Left = 343
  Top = 160
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'Genel Ara'#231' Maliyet Raporu'
  ClientHeight = 332
  ClientWidth = 420
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
  object Label22: TLabel
    Left = 10
    Top = 303
    Width = 59
    Height = 13
    Caption = 'Personel Ad'#305
    Visible = False
  end
  object Label18: TLabel
    Left = 240
    Top = 303
    Width = 59
    Height = 13
    Caption = 'Personel Ad'#305
    Visible = False
  end
  object Button8: TButton
    Left = 218
    Top = 300
    Width = 17
    Height = 20
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Visible = False
    OnClick = Button8Click
  end
  object txtAlanPers: TEdit
    Left = 89
    Top = 300
    Width = 127
    Height = 21
    TabOrder = 2
    Visible = False
    OnEnter = txtAracEnter
    OnExit = txtAlanPersExit
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 420
    Height = 297
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object Label1: TLabel
        Left = 10
        Top = 253
        Width = 52
        Height = 13
        Caption = 'Ara'#231' Plaka'
      end
      object LblPlaka: TLabel
        Left = 242
        Top = 253
        Width = 52
        Height = 13
        Caption = 'Ara'#231' Plaka'
      end
      object Label36: TLabel
        Left = 10
        Top = 229
        Width = 74
        Height = 13
        Caption = 'Ta'#351#305'y'#305'c'#305' Cari Ad'#305
        Visible = False
      end
      object Label19: TLabel
        Left = 242
        Top = 229
        Width = 74
        Height = 13
        Caption = 'Ta'#351#305'y'#305'c'#305' Cari Ad'#305
        Visible = False
      end
      object chk_Sirket: TCheckBox
        Left = 23
        Top = 128
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
        Top = 0
        Width = 412
        Height = 73
        Align = alTop
        Caption = 'Ara'#231' Kod Aral'#305#287#305
        TabOrder = 0
        object txtAracKod1: TEdit
          Left = 8
          Top = 16
          Width = 119
          Height = 21
          TabOrder = 0
          OnEnter = txtAracKod1Enter
          OnExit = txtAracKod1Exit
          OnKeyDown = txtAracKod1KeyDown
          OnKeyPress = txtAracKod1KeyPress
        end
        object Button1: TButton
          Left = 8
          Top = 38
          Width = 119
          Height = 25
          Caption = '&Ara'#231' Listesi'
          TabOrder = 2
          TabStop = False
          OnClick = Button1Click
        end
        object txtAracKod2: TEdit
          Left = 270
          Top = 16
          Width = 119
          Height = 21
          TabOrder = 1
          OnEnter = txtAracKod1Enter
          OnExit = txtAracKod2Exit
          OnKeyDown = txtAracKod2KeyDown
          OnKeyPress = txtAracKod1KeyPress
        end
        object Button2: TButton
          Left = 270
          Top = 38
          Width = 119
          Height = 25
          Caption = 'Ara'#231' &Listesi'
          TabOrder = 3
          TabStop = False
          OnClick = Button2Click
        end
      end
      object grpSube: TGroupBox
        Left = 0
        Top = 73
        Width = 412
        Height = 49
        Align = alTop
        Caption = #350'ube Ad'#305
        TabOrder = 1
        Visible = False
        object cmbSube: TComboBox
          Left = 126
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
      object Cb_Yeni_Sayfa: TCheckBox
        Left = 23
        Top = 149
        Width = 162
        Height = 17
        Caption = 'Her Ara'#231' Sat'#305'c'#305' Yeni Sayfada'
        TabOrder = 3
      end
      object txtArac: TEdit
        Left = 89
        Top = 245
        Width = 127
        Height = 21
        TabOrder = 4
        OnEnter = txtAracEnter
        OnExit = txtAracExit
      end
      object Button9: TButton
        Left = 218
        Top = 246
        Width = 17
        Height = 20
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        OnClick = Button9Click
      end
      object TxtMazotcu: TEdit
        Left = 89
        Top = 221
        Width = 127
        Height = 21
        TabOrder = 6
        Visible = False
        OnEnter = txtAracEnter
        OnExit = TxtMazotcuExit
      end
      object Button7: TButton
        Left = 218
        Top = 222
        Width = 17
        Height = 20
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        Visible = False
        OnClick = Button7Click
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 170
        Width = 412
        Height = 46
        Caption = 'Tarih Aral'#305#287#305
        TabOrder = 8
        object dtpIslemTar1: TDateTimePicker
          Left = 102
          Top = 16
          Width = 100
          Height = 21
          Date = 37554.733220983800000000
          Time = 37554.733220983800000000
          Checked = False
          TabOrder = 0
        end
        object dtpIslemTar2: TDateTimePicker
          Left = 291
          Top = 15
          Width = 100
          Height = 21
          Date = 37554.733416122690000000
          Time = 37554.733416122690000000
          Checked = False
          TabOrder = 1
        end
      end
      object cb_Satici: TCheckBox
        Left = 239
        Top = 149
        Width = 162
        Height = 17
        Caption = 'Sat'#305'c'#305'ya G'#246're Grupla'
        TabOrder = 9
      end
      object Cb_Alici: TCheckBox
        Left = 239
        Top = 129
        Width = 162
        Height = 17
        Caption = 'Al'#305'c'#305' Bilgili'
        TabOrder = 10
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
          'Ara'#231' Koduna G'#246're'
          'Plakaya G'#246're')
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 299
    Width = 420
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 53
      Top = 4
      Width = 76
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object Button3: TButton
      Left = 288
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object Btn_Fast: TButton
      Left = 171
      Top = 4
      Width = 77
      Height = 25
      Caption = '&Rapor'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object qryRapor: TIB_Cursor
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT ARAC_KOD'
      '     , PLAKA'
      '     , ARAC_TIP'
      '     , OZ_MAL '
      '     , CARI_KOD '
      
        '     ,(SELECT CARI_AD FROM CARI WHERE ARAC.CARI_KOD=CARI.CARI_KO' +
        'D) AS CARI_ADI '
      '     , ACIKLAMA '
      '     , BORC '
      '     , ALACAK '
      '     , AKTIF_DEGIL '
      '     , YAKIT_LITRE '
      '     , TRF_SIG_GEC_TAR '
      '     , KASKO_SIG_GEC_TAR '
      '     , PERSONEL_KOD '
      
        '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_K' +
        'OD=ARAC.PERSONEL_KOD) AS PERSONEL_ADI '
      'FROM ARAC ')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 152
    Top = 80
  end
  object qryRaporH: TIB_Cursor
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'Select '
      '    ARACHAR_ID '
      '    ,ARACHAR_SID '
      '    ,ARAC_KOD '
      '    ,BA '
      '    ,TARIH '
      '    ,DOVKOD   '
      '    ,DOVKUR '
      '    ,TUTAR '
      '    ,TUTAR_VPB '
      '    ,ACIKLAMA '
      '    ,BELGE_TUR '
      '    ,BELGE_ID '
      '    ,BELGE_SID '
      '    ,SIRA_NO '
      '    ,MASRAF_MERK '
      '    ,KOD1 '
      '    ,KOD2 '
      '    ,KOD3 '
      '    ,KOD4 '
      '    from ARACHAR '
      '')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 104
    Top = 112
  end
  object frxReport1: TfrxReport
    Version = '4.3'
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
    ReportOptions.LastChange = 39169.549516956020000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1AfterPrint
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
      'PLAKA=PLAKA'
      'CARI_KOD=CARI_KOD'
      'MIKTAR=MIKTAR')
    DataSet = qrySefer
    Left = 356
    Top = 123
  end
  object qrySefer: TIB_Query
    ColumnAttributes.Strings = (
      'BEKLEME_FAT_VAR=BOOLEAN=1,0'
      'SEFER_ALIS_FAT_ALINDI=BOOLEAN=1,0'
      'SEFER_SATIS_FAT_KESILDI=BOOLEAN=1,0'
      'SECIM=BOOLEAN=1,0'
      'BEKLEME_FATURASI_KESILDI=BOOLEAN=1,0'
      'SEFER_TAMAMLANDI=BOOLEAN=1,0')
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
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
      'SELECT K.SEFER_ID'
      '     , K.SEFER_SID'
      '     , K.SEFER_SAY'
      '     , K.ARAC_KOD'
      '     , ARAC.PLAKA'
      '     , ARAC.PLAKA  AS ARAC_PLAKA'
      '     , K.ALICI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SEFER.ALICI_' +
        'KOD) AS ALICI_ADI'
      '     , K.SATICI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE SEFER.SATICI_KOD=CARI.CARI' +
        '_KOD) AS SATICI_ADI'
      '     , ARAC.CARI_KOD '
      '     , K.PERSONEL_KOD'
      
        '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_K' +
        'OD=SEFER.PERSONEL_KOD) AS PERSONEL_ADI'
      '     , K.OLCU_TIP'
      '     , K.OLCU_BIRIM'
      '     , K.TASINAN_ESYA'
      '     , K.BAS_TAR'
      '     , K.BIT_TAR'
      '     , K.CIK_YER'
      '     , K.BIT_YER'
      '     , K.ALICI_BORC_BIRIM_FIY'
      '     , K.ALICI_B_DOVKOD'
      '     , K.ALICI_BORC'
      '     , K.ALICI_BORC_VPB'
      '     , K.SATICI_ALACAK_BIRIM_FIY'
      '     , K.SATICI_A_DOVKOD'
      '     , K.SATICI_ALACAK'
      '     , K.SATICI_ALACAK_VPB'
      '     , K.BEKLEME_FAT_VAR'
      '     , K.BEKLEME_FAT_TUTAR'
      '     , K.BEKLEME_FAT_DOV_KOD'
      '     , K.BEKLEME_FAT_VPB'
      '     , K.SEFER_NOTLARI'
      '     , K.SEFER_ALIS_FAT_ALINDI'
      '     , K.SEFER_SATIS_FAT_KESILDI'
      '     , K.MASRAF_MERK'
      '     , K.KOD1'
      '     , K.KOD2'
      '     , K.KOD3'
      '     , K.KOD4'
      '     , K.ALICI_B_DOV_BAZ_TAR'
      '     , K.SATICI_A_DOV_BAZ_TAR'
      '     , K.BEKLEME_FAT_DOV_BAZ_TAR'
      '     , K.ALICI_B_DOVKUR'
      '     , K.SATICI_A_DOVKUR'
      '     , K.BEKLEME_FAT_DOVKUR'
      '     , K.SEFER_TAMAMLANDI'
      '     , K.DORSE_KOD'
      '     , K.ALIS_URUN_HAR_ID'
      '     , K.SATIS_URUN_HAR_ID'
      '     , K.SECIM'
      '     , K.BEKLEME_FATURASI_KESILDI'
      '     , K.BEK_FAT_URUN_HAR_ID'
      '     , K.MIKTAR  '
      'FROM SEFER K'
      'LEFT OUTER JOIN ARAC ON (ARAC.ARAC_KOD=SEFER.ARAC_KOD)'
      'WHERE K.SEFER_ID>0 '
      ' ORDER BY ARAC.CARI_KOD,K.BAS_TAR,K.BIT_TAR')
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
    Left = 312
    Top = 208
  end
  object frxIBODataset2: TfrxIBODataset
    UserName = 'frxIBODataset2'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ARACHAR_ID=ARACHAR_ID'
      'ARACHAR_SID=ARACHAR_SID'
      'ARAC_KOD=ARAC_KOD'
      'BA=BA'
      'TARIH=TARIH'
      'DOVKOD=DOVKOD'
      'DOVKUR=DOVKUR'
      'TUTAR=TUTAR'
      'TUTAR_VPB=TUTAR_VPB'
      'ACIKLAMA=ACIKLAMA'
      'BELGE_TUR=BELGE_TUR'
      'BELGE_ID=BELGE_ID'
      'BELGE_SID=BELGE_SID'
      'SIRA_NO=SIRA_NO'
      'MASRAF_MERK=MASRAF_MERK'
      'KOD1=KOD1'
      'KOD2=KOD2'
      'KOD3=KOD3'
      'KOD4=KOD4'
      'PLAKA=PLAKA'
      'ARAC_PLAKA=ARAC_PLAKA'
      'ALICI_ADI=ALICI_ADI'
      'BORC=BORC'
      'ALACAK=ALACAK')
    DataSet = IB_Query1
    Left = 260
    Top = 107
  end
  object IB_Query1: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'Select '
      '    arachar.ARACHAR_ID'
      '    ,arachar.ARACHAR_SID '
      '    ,arachar.ARAC_KOD '
      '    ,arachar.BA '
      '    ,arachar.TARIH '
      '    ,arachar.DOVKOD   '
      '    ,arachar.DOVKUR '
      '    ,arachar.TUTAR '
      '    ,arachar.TUTAR_VPB '
      '    ,arachar.ACIKLAMA '
      '    ,arachar.BELGE_TUR '
      '    ,arachar.BELGE_ID '
      '    ,arachar.BELGE_SID '
      '    ,arachar.SIRA_NO '
      '    ,arachar.MASRAF_MERK '
      '    ,arachar.KOD1 '
      '    ,arachar.KOD2 '
      '    ,arachar.KOD3 '
      '    ,arachar.KOD4 '
      '    ,ARAC.PLAKA '
      ''
      
        '    ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=ARACHAR.ARAC_KO' +
        'D) AS ARAC_PLAKA'
      
        '    ,(select (SELECT CARI_AD FROM CARI WHERE SEFER.ALICI_KOD=CAR' +
        'I.CARI_KOD) FROM SEFER'
      
        '    WHERE SEFER.sefer_id=ARACHAR.BELGE_ID AND ARACHAR.belge_tur=' +
        '41)  AS ALICI_ADI'
      ''
      '    ,(CASE'
      '    WHEN arachar.BA='#39'B'#39' THEN  arachar.TUTAR_VPB'
      '    ELSE 0'
      '    END) BORC'
      '    ,(CASE'
      '    WHEN arachar.BA='#39'A'#39' THEN  arachar.TUTAR_VPB'
      '    ELSE 0'
      '    END) ALACAK'
      ''
      '    from ARACHAR '
      '    LEFT OUTER JOIN ARAC ON (ARAC.ARAC_KOD=ARACHAR.ARAC_KOD)'
      '    WHERE ARAC.oz_mal=1')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 248
    Top = 197
  end
end
