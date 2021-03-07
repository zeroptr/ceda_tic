object frm_Kantar: Tfrm_Kantar
  Left = 42
  Top = 83
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Kantar'
  ClientHeight = 563
  ClientWidth = 931
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
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 931
    Height = 533
    Align = alClient
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 553
      Top = 1
      Height = 367
    end
    object IB_Edit14: TIB_Edit
      Left = 992
      Top = 440
      Width = 520
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'GELDIGI_YER'
      DataSource = DtsKantar
      Visible = False
      TabOrder = 0
      OnEnter = IB_Edit14Enter
      OnExit = IB_Edit14Exit
      OnKeyPress = txtPlaka_NoKeyPress
    end
    object IB_Edit15: TIB_Edit
      Left = 992
      Top = 472
      Width = 520
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'GITTIGI_YER'
      DataSource = DtsKantar
      Visible = False
      TabOrder = 1
      OnEnter = IB_Edit14Enter
      OnExit = IB_Edit14Exit
      OnKeyPress = txtPlaka_NoKeyPress
    end
    object IB_Edit16: TIB_Edit
      Left = 992
      Top = 504
      Width = 520
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'ACIKLAMA'
      DataSource = DtsKantar
      Visible = False
      TabOrder = 2
      OnEnter = IB_Edit14Enter
      OnExit = IB_Edit14Exit
      OnKeyPress = txtPlaka_NoKeyPress
    end
    object Memo1: TMemo
      Left = 1000
      Top = 384
      Width = 185
      Height = 169
      Lines.Strings = (
        'geldi'#287'i yer '
        'gittigi yer '
        'a'#231#305'klama'
        'plakalar '
        #252'cretler'
        'tan'#305'm yap'#305'labilir'
        'girlenden sogulan'#305'p commbo box '
        'se'#351'linde getirilebilir'
        'plakalar cari ile e'#351'lenebilir'
        ''
        ''
        ''
        'Liste '#231#305'kt'#305'lar'#305'na kriterler yazd'#305'r'#305'l'#305'r'
        #252'cret kilo toplamlar'#305' ald'#305'r'#305'labilir'
        ''
        'ek alanlar'
        'rutubet oran'#305' '
        'kasa adedi'
        'kodu')
      TabOrder = 3
      Visible = False
    end
    object Pnl_Giris: TPanel
      Left = 1
      Top = 1
      Width = 552
      Height = 367
      Align = alLeft
      TabOrder = 4
      object txtPlaka_No: TIB_Edit
        Left = 72
        Top = 24
        Width = 117
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'PLAKA_NO'
        DataSource = DtsKantar
        TabOrder = 0
        OnEnter = txtPlaka_NoEnter
        OnExit = txtPlaka_NoExit
        OnKeyPress = txtPlaka_NoKeyPress
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtPlaka_NoButtonClick
      end
      object txtCari_Kod: TIB_Edit
        Left = 72
        Top = 56
        Width = 117
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'CARI_KOD'
        DataSource = DtsKantar
        TabOrder = 3
        OnEnter = txtCari_KodEnter
        OnExit = txtCari_KodExit
        OnKeyPress = txtPlaka_NoKeyPress
        OnKeyUp = txtCari_KodKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtCari_KodButtonClick
      end
      object IB_Edit3: TIB_Edit
        Left = 256
        Top = 56
        Width = 281
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'CARI_AD'
        DataSource = DtsKantar
        Enabled = False
        TabOrder = 4
      end
      object txtUrun_Kod: TIB_Edit
        Left = 72
        Top = 88
        Width = 117
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'URUN_KOD'
        DataSource = DtsKantar
        TabOrder = 5
        OnEnter = txtUrun_KodEnter
        OnExit = txtUrun_KodExit
        OnKeyPress = txtPlaka_NoKeyPress
        OnKeyUp = txtUrun_KodKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtUrun_KodButtonClick
      end
      object IB_Edit5: TIB_Edit
        Left = 256
        Top = 88
        Width = 281
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'URUN_AD'
        DataSource = DtsKantar
        Enabled = False
        TabOrder = 6
      end
      object IB_Edit10: TIB_Edit
        Left = 248
        Top = 216
        Width = 113
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'ARAC_KILO'
        DataSource = DtsKantar
        TabOrder = 12
        OnEnter = IB_Edit14Enter
        OnExit = IB_Edit14Exit
      end
      object IB_Edit11: TIB_Edit
        Left = 248
        Top = 248
        Width = 113
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'GIRIS_KILO'
        DataSource = DtsKantar
        TabOrder = 13
        OnEnter = IB_Edit14Enter
        OnExit = IB_Edit14Exit
      end
      object IB_Date1: TIB_Date
        Left = 72
        Top = 216
        Width = 93
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'GIRIS_TARIHI'
        DataSource = DtsKantar
        TabOrder = 10
        OnEnter = IB_Edit14Enter
        OnExit = IB_Edit14Exit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_ComboBox1: TIB_ComboBox
        Left = 216
        Top = 24
        Width = 141
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'TIPI'
        DataSource = DtsKantar
        Enabled = False
        TabOrder = 1
        OnEnter = IB_ComboBox1Enter
        OnExit = IB_ComboBox1Exit
        Style = csDropDownList
        ItemHeight = 13
        Items.Strings = (
          'Giri'#351
          #199#305'k'#305#351)
        ItemValues.Strings = (
          'G'
          'C')
      end
      object IB_Edit2: TIB_Edit
        Left = 432
        Top = 24
        Width = 105
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'MAKBUZ_NO'
        DataSource = DtsKantar
        TabOrder = 2
        OnEnter = IB_Edit14Enter
        OnExit = IB_Edit14Exit
        OnKeyPress = txtPlaka_NoKeyPress
      end
      object Btn_Giris_Kilo: TBitBtn
        Left = 376
        Top = 248
        Width = 53
        Height = 25
        Caption = 'Kilo Al'
        TabOrder = 14
      end
      object Cb_Geldigi_Yer: TIB_ComboBox
        Left = 70
        Top = 120
        Width = 467
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'GELDIGI_YER'
        DataSource = DtsKantar
        TabOrder = 7
        OnEnter = IB_Edit14Enter
        OnExit = IB_Edit14Exit
        ItemHeight = 13
      end
      object Cb_Gittigi_Yer: TIB_ComboBox
        Left = 70
        Top = 152
        Width = 467
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'GITTIGI_YER'
        DataSource = DtsKantar
        TabOrder = 8
        OnEnter = IB_Edit14Enter
        OnExit = IB_Edit14Exit
        ItemHeight = 13
      end
      object Cb_Aciklama: TIB_ComboBox
        Left = 70
        Top = 184
        Width = 467
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'ACIKLAMA'
        DataSource = DtsKantar
        TabOrder = 9
        OnEnter = IB_Edit14Enter
        OnExit = IB_Edit14Exit
        ItemHeight = 13
      end
      object IB_Date4: TIB_Date
        Left = 72
        Top = 248
        Width = 93
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'GIRIS_SAATI'
        DataSource = DtsKantar
        TabOrder = 11
        OnEnter = IB_Edit14Enter
        OnExit = IB_Edit14Exit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object Btn_Cikis_Yap: TBitBtn
        Left = 456
        Top = 248
        Width = 75
        Height = 25
        Caption = #199#305'k'#305#351#305'n'#305' Yap'
        TabOrder = 15
        OnClick = Btn_Cikis_YapClick
      end
      object grpRapKod: TGroupBox
        Left = 1
        Top = 275
        Width = 550
        Height = 91
        Align = alBottom
        TabOrder = 18
        object IB_Edit1: TIB_Edit
          Left = 8
          Top = 21
          Width = 83
          Height = 21
          AutoLabel.Kind = albTop
          AutoLabel.Caption = #304#351'lem Merkezi'
          DataField = 'MASRAF_MERK'
          DataSource = DtsKantar
          TabOrder = 0
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyUp = IB_Edit1KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit1ButtonClick
        end
        object IB_Edit6: TIB_Edit
          Left = 118
          Top = 21
          Width = 85
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD1'
          DataSource = DtsKantar
          TabOrder = 1
          OnEnter = IB_Edit6Enter
          OnExit = IB_Edit6Exit
          OnKeyUp = IB_Edit6KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit6ButtonClick
        end
        object IB_Edit7: TIB_Edit
          Left = 226
          Top = 21
          Width = 81
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD2'
          DataSource = DtsKantar
          TabOrder = 2
          OnEnter = IB_Edit7Enter
          OnExit = IB_Edit7Exit
          OnKeyUp = IB_Edit7KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit7ButtonClick
        end
        object IB_Edit24: TIB_Edit
          Left = 334
          Top = 21
          Width = 85
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD3'
          DataSource = DtsKantar
          TabOrder = 3
          OnEnter = IB_Edit24Enter
          OnExit = IB_Edit24Exit
          OnKeyUp = IB_Edit24KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit24ButtonClick
        end
        object IB_Edit25: TIB_Edit
          Left = 445
          Top = 21
          Width = 85
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD4'
          DataSource = DtsKantar
          TabOrder = 4
          OnEnter = IB_Edit25Enter
          OnExit = IB_Edit25Exit
          OnKeyUp = IB_Edit25KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit25ButtonClick
        end
        object txtKasaKod: TIB_Edit
          Left = 118
          Top = 52
          Width = 121
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'KASA_KOD'
          DataSource = DtsKantar
          TabOrder = 5
          OnEnter = txtKasaKodEnter
          OnExit = txtKasaKodExit
          OnKeyPress = txtPlaka_NoKeyPress
          OnKeyUp = txtKasaKodKeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = txtKasaKodButtonClick
        end
        object txtKasaAd: TIB_Edit
          Left = 332
          Top = 52
          Width = 197
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'KASA_AD'
          DataSource = DtsKantar
          Enabled = False
          TabOrder = 6
          OnEnter = IB_Edit14Enter
          OnExit = txtPlaka_NoExit
        end
      end
      object Btn_Giris_Yaz: TBitBtn
        Left = 456
        Top = 219
        Width = 73
        Height = 25
        Caption = 'Fi'#351' Yazd'#305'r'
        TabOrder = 16
        OnClick = BtnYazdirClick
      end
      object Pnl_Cikis: TPanel
        Left = 481
        Top = 218
        Width = 550
        Height = 81
        TabOrder = 17
        Visible = False
        object IB_Edit12: TIB_Edit
          Left = 224
          Top = 16
          Width = 90
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'CIKIS_KILO'
          DataSource = DtsKantar
          TabOrder = 2
          OnEnter = IB_Edit14Enter
          OnExit = IB_Edit14Exit
        end
        object IB_Edit13: TIB_Edit
          Left = 224
          Top = 48
          Width = 90
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'FARK_KILO'
          DataSource = DtsKantar
          ReadOnly = True
          TabOrder = 4
          OnEnter = IB_Edit14Enter
          OnExit = IB_Edit14Exit
        end
        object IB_Date3: TIB_Date
          Left = 56
          Top = 48
          Width = 88
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'CIKIS_SAATI'
          DataSource = DtsKantar
          TabOrder = 1
          OnEnter = IB_Edit14Enter
          OnExit = IB_Edit14Exit
          IncCellHeight = 1
          IncCellWidth = 2
          DrawYearArrow = False
        end
        object IB_Edit4: TIB_Edit
          Left = 424
          Top = 16
          Width = 89
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'UCRETI'
          DataSource = DtsKantar
          TabOrder = 5
          OnEnter = IB_Edit14Enter
          OnExit = IB_Edit14Exit
        end
        object Btn_Cikis_Kilo: TBitBtn
          Left = 320
          Top = 16
          Width = 57
          Height = 25
          Caption = 'Kilo Al'
          TabOrder = 3
        end
        object IB_Date2: TIB_Date
          Left = 56
          Top = 12
          Width = 89
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'CIKIS_TARIHI'
          DataSource = DtsKantar
          TabOrder = 0
          OnEnter = IB_Edit14Enter
          OnExit = IB_Edit14Exit
          IncCellHeight = 1
          IncCellWidth = 2
          DrawYearArrow = False
        end
      end
    end
    object IB_Grid1: TIB_Grid
      Left = 556
      Top = 1
      Width = 374
      Height = 367
      CustomGlyphsSupplied = []
      DataSource = Dts_Girenler
      Align = alClient
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 5
      RowSelect = True
      Ctl3DShallow = True
      TabMovesOut = True
    end
    object IB_Grid2: TIB_Grid
      Left = 1
      Top = 368
      Width = 929
      Height = 164
      CustomGlyphsSupplied = []
      DataSource = Dts_Cikanlar
      Align = alBottom
      BorderStyle = bsNone
      ReadOnly = True
      TabOrder = 6
      RowSelect = True
      Ctl3DShallow = True
      TabMovesOut = True
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 533
    Width = 931
    Height = 30
    Align = alBottom
    TabOrder = 1
    TabStop = True
    object SpeedButton1: TSpeedButton
      Left = 672
      Top = 8
      Width = 23
      Height = 22
      Visible = False
      OnClick = SpeedButton1Click
    end
    object btnYeni: TBitBtn
      Left = 5
      Top = 3
      Width = 62
      Height = 25
      Caption = 'Yeni (INS)'
      TabOrder = 0
      OnClick = btnYeniClick
      NumGlyphs = 2
    end
    object btnKaydet: TButton
      Left = 66
      Top = 3
      Width = 91
      Height = 25
      Caption = 'Kaydet (CTRL+S)'
      TabOrder = 1
      OnClick = btnKaydetClick
    end
    object btnIPTAL: TButton
      Left = 156
      Top = 3
      Width = 80
      Height = 25
      Caption = 'Iptal(CTRL+P)'
      TabOrder = 2
      OnClick = btnIPTALClick
    end
    object btnSil: TButton
      Left = 235
      Top = 3
      Width = 87
      Height = 25
      Caption = 'Sil (CTRL+DEL)'
      TabOrder = 3
      OnClick = btnSilClick
    end
    object btnAra: TBitBtn
      Left = 776
      Top = 3
      Width = 77
      Height = 25
      Caption = '&Ara'
      TabOrder = 5
      OnClick = btnAraClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
        3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
        33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
        333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
    end
    object btnCikis: TBitBtn
      Left = 852
      Top = 3
      Width = 72
      Height = 25
      Caption = #199#305'k'#305#351
      TabOrder = 6
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
    object BtnYazdir: TBitBtn
      Left = 512
      Top = 3
      Width = 89
      Height = 25
      Caption = 'Fi'#351' Yazd'#305'r'
      TabOrder = 4
      OnClick = BtnYazdirClick
    end
    object Btn_Onceki: TButton
      Left = 432
      Top = 3
      Width = 25
      Height = 25
      Caption = '<'
      TabOrder = 7
      Visible = False
      OnClick = Btn_OncekiClick
    end
    object Btn_Sonraki: TButton
      Left = 464
      Top = 3
      Width = 25
      Height = 25
      Caption = '>'
      TabOrder = 8
      Visible = False
      OnClick = Btn_SonrakiClick
    end
    object Btn_Degistir: TBitBtn
      Left = 324
      Top = 3
      Width = 75
      Height = 25
      Caption = 'De'#287'i'#351'tir'
      TabOrder = 9
      OnClick = Btn_DegistirClick
    end
  end
  object qry_Kantar: TIB_Query
    DatabaseName = 'c:\CedaLite\Db\Cevresel_2006.FDB'
    FieldsDisplayLabel.Strings = (
      'GIRIS_TARIHI=Giri'#351' Tarihi'
      'GIRIS_SAATI=Giri'#351' Saati'
      'MAKBUZ_NO=Makbuz No'
      'URUN_KOD='#220'r'#252'n Kodu'
      'URUN_AD='#220'r'#252'n Ad'#305
      'CARI_KOD=Cari Kod'
      'CARI_AD=Cari Ad'#305
      'ACIKLAMA=A'#231#305'klama'
      'GELDIGI_YER=Geldi'#287'i Yer'
      'GELDIGI_YER_KOD=Geldi'#287'i Yer Kodu'
      'GITTIGI_YER=Gittigi Yer'
      'GITTIGI_YER_KOD=Gitti'#287'i Yer Kodu'
      'CIKIS_TARIHI='#199#305'k'#305#351' Tarihi'
      'CIKIS_SAATI='#199#305'k'#305#351' Saati'
      'ARAC_KILO=Ara'#231' Kilo'
      'GIRIS_KILO=Giri'#351' Kilo'
      'CIKIS_KILO='#199#305'k'#305#351' Kilo'
      'FARK_KILO=Giri'#351' '#199#305'k'#305#351' Fark'#305
      'UCRETI='#220'creti'
      'TIPI=Tipi'
      'PLAKA_NO=Plaka No'
      'KASA_KOD=Kasa Kodu'
      'KASA_AD=Kasa Ad'#305
      'MASRAF_MERK='#304#351'lem Merkezi'
      'KOD1=Kod1'
      'KOD2=Kod2'
      'KOD3=Kod3'
      'KOD4=Kod4')
    FieldsDisplayWidth.Strings = (
      'PLAKA_NO=88'
      'GIRIS_TARIHI=75'
      'GIRIS_SAATI=54'
      'GIRIS_KILO=57')
    FieldsIndex.Strings = (
      'KANTAR_SID'
      'KANTAR_NO'
      'PLAKA_NO'
      'GIRIS_TARIHI'
      'GIRIS_SAATI'
      'GIRIS_KILO'
      'URUN_KOD'
      'URUN_AD'
      'CARI_KOD'
      'CARI_AD'
      'ACIKLAMA'
      'GELDIGI_YER'
      'MAKBUZ_NO'
      'GITTIGI_YER'
      'GITTIGI_YER_KOD'
      'GELDIGI_YER_KOD'
      'CIKIS_TARIHI'
      'CIKIS_SAATI'
      'ARAC_KILO'
      'CIKIS_KILO'
      'FARK_KILO'
      'UCRETI'
      'TIPI'
      'KASA_KOD'
      'KASA_AD'
      'MASRAF_MERK'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4'
      'PERSONEL_KOD'
      'PROJE_KOD')
    FieldsVisible.Strings = (
      'KANTAR_NO=FALSE'
      'KANTAR_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT KANTAR_SID'
      '     , KANTAR_NO'
      '     , GIRIS_TARIHI'
      '     , GIRIS_SAATI'
      '     , MAKBUZ_NO'
      '     , URUN_KOD'
      
        '     ,(Select URUN_AD from URUN where URUN.URUN_KOD=KANTAR.URUN_' +
        'KOD) as URUN_AD'
      '     , CARI_KOD'
      
        '     , (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=KANTAR' +
        '.CARI_KOD) As CARI_AD   '
      '     , ACIKLAMA'
      '     , GELDIGI_YER'
      '     , GELDIGI_YER_KOD'
      '     , GITTIGI_YER'
      '     , GITTIGI_YER_KOD'
      '     , CIKIS_TARIHI'
      '     , CIKIS_SAATI'
      '     , ARAC_KILO'
      '     , GIRIS_KILO'
      '     , CIKIS_KILO'
      '     , FARK_KILO'
      '     , UCRETI'
      '     , TIPI'
      '     , PLAKA_NO'
      '     , KASA_KOD'
      
        '     , (Select KASA.ACIKLAMA From KASA where KASA.KASA_KOD=KANTA' +
        'R.KASA_KOD) as KASA_AD'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , PERSONEL_KOD'
      '     , PROJE_KOD'
      ''
      'FROM KANTAR'
      'WHERE KANTAR_NO=:PRM_KANTAR_NO'
      'ORDER BY GIRIS_TARIHI, GIRIS_SAATI'
      '/*WHERE TIPI='#39'G'#39'*/')
    ColorScheme = False
    KeyLinks.Strings = (
      'KANTAR.KANTAR_SID'
      'KANTAR.KANTAR_NO')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qry_KantarAfterInsert
    BeforePost = qry_KantarBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 288
    Top = 112
    ParamValues = ()
  end
  object DtsKantar: TIB_DataSource
    AutoInsert = False
    Dataset = qry_Kantar
    OnDataChange = DtsKantarDataChange
    OnStateChanged = DtsKantarStateChanged
    Left = 232
    Top = 112
  end
  object frxReport1: TfrxReport
    Version = '4.3'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39203.438300416700000000
    ReportOptions.LastChange = 39203.684919699070000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 240
    Top = 385
  end
  object frxIBOKantar_Fisi: TfrxIBODataset
    UserName = 'frxIBOKantar_Fisi'
    CloseDataSource = False
    FieldAliases.Strings = (
      'KANTAR_SID=KANTAR_SID'
      'KANTAR_NO=KANTAR_NO'
      'GIRIS_TARIHI=GIRIS_TARIHI'
      'GIRIS_SAATI=GIRIS_SAATI'
      'MAKBUZ_NO=MAKBUZ_NO'
      'URUN_KOD=URUN_KOD'
      'URUN_AD=URUN_AD'
      'CARI_KOD=CARI_KOD'
      'CARI_AD=CARI_AD'
      'ACIKLAMA=ACIKLAMA'
      'GELDIGI_YER=GELDIGI_YER'
      'GELDIGI_YER_KOD=GELDIGI_YER_KOD'
      'GITTIGI_YER=GITTIGI_YER'
      'GITTIGI_YER_KOD=GITTIGI_YER_KOD'
      'CIKIS_TARIHI=CIKIS_TARIHI'
      'CIKIS_SAATI=CIKIS_SAATI'
      'ARAC_KILO=ARAC_KILO'
      'GIRIS_KILO=GIRIS_KILO'
      'CIKIS_KILO=CIKIS_KILO'
      'FARK_KILO=FARK_KILO'
      'UCRETI=UCRETI'
      'TIPI=TIPI'
      'PLAKA_NO=PLAKA_NO'
      'KASA_KOD=KASA_KOD'
      'KASA_AD=KASA_AD')
    DataSet = IB_Query1
    Left = 176
    Top = 384
  end
  object Dts_Cikanlar: TIB_DataSource
    AutoInsert = False
    Dataset = Qry_Cikanlar
    Left = 528
    Top = 416
  end
  object Qry_Cikanlar: TIB_Query
    DatabaseName = 'c:\CedaLite\Db\Cevresel_2006.FDB'
    FieldsDisplayLabel.Strings = (
      'GIRIS_TARIHI=Giri'#351' Tarihi'
      'GIRIS_SAATI=Giri'#351' Saati'
      'MAKBUZ_NO=Makbuz No'
      'URUN_KOD='#220'r'#252'n Kodu'
      'URUN_AD='#220'r'#252'n Ad'#305
      'CARI_KOD=Cari Kod'
      'CARI_AD=Cari Ad'#305
      'ACIKLAMA=A'#231#305'klama'
      'GELDIGI_YER=Geldi'#287'i Yer'
      'GELDIGI_YER_KOD=Geldi'#287'i Yer Kodu'
      'GITTIGI_YER=Gittigi Yer'
      'GITTIGI_YER_KOD=Gitti'#287'i Yer Kodu'
      'CIKIS_TARIHI='#199#305'k'#305#351' Tarihi'
      'CIKIS_SAATI='#199#305'k'#305#351' Saati'
      'ARAC_KILO=Ara'#231' Kilo'
      'GIRIS_KILO=Giri'#351' Kilo'
      'CIKIS_KILO='#199#305'k'#305#351' Kilo'
      'FARK_KILO=Giri'#351' '#199#305'k'#305#351' Fark'#305
      'UCRETI='#220'creti'
      'TIPI=Tipi'
      'PLAKA_NO=Plaka No'
      'KASA_KOD=Kasa Kodu'
      'KASA_AD=Kasa Ad'#305
      'MASRAF_MERK='#304#351'lem Merkezi'
      'KOD1=Kod1'
      'KOD2=Kod2'
      'KOD3=Kod3'
      'KOD4=Kod4')
    FieldsDisplayWidth.Strings = (
      'FARK_KILO=77'
      'CIKIS_TARIHI=66'
      'CIKIS_SAATI=58'
      'GIRIS_TARIHI=60'
      'GIRIS_SAATI=55'
      'ARAC_KILO=53'
      'PLAKA_NO=91')
    FieldsIndex.Strings = (
      'KANTAR_SID'
      'KANTAR_NO'
      'PLAKA_NO'
      'CIKIS_TARIHI'
      'CIKIS_SAATI'
      'GIRIS_TARIHI'
      'GIRIS_SAATI'
      'MAKBUZ_NO'
      'GIRIS_KILO'
      'CIKIS_KILO'
      'FARK_KILO'
      'UCRETI'
      'URUN_KOD'
      'URUN_AD'
      'CARI_KOD'
      'CARI_AD'
      'ACIKLAMA'
      'GELDIGI_YER'
      'GITTIGI_YER'
      'GITTIGI_YER_KOD'
      'GELDIGI_YER_KOD'
      'ARAC_KILO'
      'TIPI'
      'KASA_KOD'
      'KASA_AD'
      'MASRAF_MERK'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4'
      'PERSONEL_KOD'
      'PROJE_KOD')
    FieldsVisible.Strings = (
      'KANTAR_NO=FALSE'
      'KANTAR_SID=FALSE'
      'PERSONEL_KOD=FALSE'
      'PROJE_KOD=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT KANTAR_SID'
      '     , KANTAR_NO'
      '     , GIRIS_TARIHI'
      '     , GIRIS_SAATI'
      '     , MAKBUZ_NO'
      '     , URUN_KOD'
      
        '     ,(Select URUN_AD from URUN where URUN.URUN_KOD=KANTAR.URUN_' +
        'KOD) as URUN_AD'
      '     , CARI_KOD'
      
        '     , (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=KANTAR' +
        '.CARI_KOD) As CARI_AD   '
      '     , ACIKLAMA'
      '     , GELDIGI_YER'
      '     , GELDIGI_YER_KOD'
      '     , GITTIGI_YER'
      '     , GITTIGI_YER_KOD'
      '     , CIKIS_TARIHI'
      '     , CIKIS_SAATI'
      '     , ARAC_KILO'
      '     , GIRIS_KILO'
      '     , CIKIS_KILO'
      '     , FARK_KILO'
      '     , UCRETI'
      '     , TIPI'
      '     , PLAKA_NO'
      '     , KASA_KOD'
      
        '     , (Select KASA.ACIKLAMA From KASA where KASA.KASA_KOD=KANTA' +
        'R.KASA_KOD) as KASA_AD'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , PERSONEL_KOD'
      '     , PROJE_KOD'
      ''
      'FROM KANTAR'
      'WHERE TIPI='#39'C'#39
      'order by CIKIS_TARIHI DESC, CIKIS_SAATI DESC'
      '')
    ColorScheme = False
    KeyLinks.Strings = (
      'KANTAR.KANTAR_SID'
      'KANTAR.KANTAR_NO')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    RequestLive = True
    AfterInsert = qry_KantarAfterInsert
    AfterScroll = Qry_CikanlarAfterScroll
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 592
    Top = 416
  end
  object IB_Query1: TIB_Query
    DatabaseName = 'c:\CedaLite\Db\Cevresel_2006.FDB'
    FieldsDisplayLabel.Strings = (
      'GIRIS_TARIHI=Giri'#351' Tarihi'
      'GIRIS_SAATI=Giri'#351' Saati'
      'MAKBUZ_NO=Makbuz No'
      'URUN_KOD='#220'r'#252'n Kodu'
      'URUN_AD='#220'r'#252'n Ad'#305
      'CARI_KOD=Cari Kod'
      'CARI_AD=Cari Ad'#305
      'ACIKLAMA=A'#231#305'klama'
      'GELDIGI_YER=Geldi'#287'i Yer'
      'GELDIGI_YER_KOD=Geldi'#287'i Yer Kodu'
      'GITTIGI_YER=Gittigi Yer'
      'GITTIGI_YER_KOD=Gitti'#287'i Yer Kodu'
      'CIKIS_TARIHI='#199#305'k'#305#351' Tarihi'
      'CIKIS_SAATI='#199#305'k'#305#351' Saati'
      'ARAC_KILO=Ara'#231' Kilo'
      'GIRIS_KILO=Giri'#351' Kilo'
      'CIKIS_KILO='#199#305'k'#305#351' Kilo'
      'FARK_KILO=Giri'#351' '#199#305'k'#305#351' Fark'#305
      'UCRETI='#220'creti'
      'TIPI=Tipi'
      'PLAKA_NO=Plaka No'
      'KASA_KOD=Kasa Kodu'
      'KASA_AD=Kasa Ad'#305
      'MASRAF_MERK='#304#351'lem Merkezi'
      'KOD1=Kod1'
      'KOD2=Kod2'
      'KOD3=Kod3'
      'KOD4=Kod4')
    FieldsVisible.Strings = (
      'KANTAR_NO=FALSE'
      'KANTAR_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT KANTAR_SID'
      '     , KANTAR_NO'
      '     , GIRIS_TARIHI'
      '     , GIRIS_SAATI'
      '     , MAKBUZ_NO'
      '     , URUN_KOD'
      
        '     ,(Select URUN_AD from URUN where URUN.URUN_KOD=KANTAR.URUN_' +
        'KOD) as URUN_AD'
      '     , CARI_KOD'
      
        '     , (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=KANTAR' +
        '.CARI_KOD) As CARI_AD   '
      '     , ACIKLAMA'
      '     , GELDIGI_YER'
      '     , GELDIGI_YER_KOD'
      '     , GITTIGI_YER'
      '     , GITTIGI_YER_KOD'
      '     , CIKIS_TARIHI'
      '     , CIKIS_SAATI'
      '     , ARAC_KILO'
      '     , GIRIS_KILO'
      '     , CIKIS_KILO'
      '     , FARK_KILO'
      '     , UCRETI'
      '     , TIPI'
      '     , PLAKA_NO'
      '     , KASA_KOD'
      
        '     , (Select KASA.ACIKLAMA From KASA where KASA.KASA_KOD=KANTA' +
        'R.KASA_KOD) as KASA_AD'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , PERSONEL_KOD'
      '     , PROJE_KOD'
      ''
      'FROM KANTAR'
      'WHERE KANTAR_NO=:PRM_KANTAR_NO')
    ColorScheme = False
    KeyLinks.Strings = (
      'KANTAR.KANTAR_SID'
      'KANTAR.KANTAR_NO')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qry_KantarAfterInsert
    BeforePost = qry_KantarBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 288
    Top = 384
  end
  object Dts_Girenler: TIB_DataSource
    AutoInsert = False
    Dataset = Qry_Girenler
    Left = 704
    Top = 112
  end
  object Qry_Girenler: TIB_Query
    DatabaseName = 'c:\CedaLite\Db\Cevresel_2006.FDB'
    FieldsDisplayLabel.Strings = (
      'GIRIS_TARIHI=Giri'#351' Tarihi'
      'GIRIS_SAATI=Giri'#351' Saati'
      'MAKBUZ_NO=Makbuz No'
      'URUN_KOD='#220'r'#252'n Kodu'
      'URUN_AD='#220'r'#252'n Ad'#305
      'CARI_KOD=Cari Kod'
      'CARI_AD=Cari Ad'#305
      'ACIKLAMA=A'#231#305'klama'
      'GELDIGI_YER=Geldi'#287'i Yer'
      'GELDIGI_YER_KOD=Geldi'#287'i Yer Kodu'
      'GITTIGI_YER=Gittigi Yer'
      'GITTIGI_YER_KOD=Gitti'#287'i Yer Kodu'
      'CIKIS_TARIHI='#199#305'k'#305#351' Tarihi'
      'CIKIS_SAATI='#199#305'k'#305#351' Saati'
      'ARAC_KILO=Ara'#231' Kilo'
      'GIRIS_KILO=Giri'#351' Kilo'
      'CIKIS_KILO='#199#305'k'#305#351' Kilo'
      'FARK_KILO=Giri'#351' '#199#305'k'#305#351' Fark'#305
      'UCRETI='#220'creti'
      'TIPI=Tipi'
      'PLAKA_NO=Plaka No'
      'KASA_KOD=Kasa Kodu'
      'KASA_AD=Kasa Ad'#305
      'MASRAF_MERK='#304#351'lem Merkezi'
      'KOD1=Kod1'
      'KOD2=Kod2'
      'KOD3=Kod3'
      'KOD4=Kod4')
    FieldsDisplayWidth.Strings = (
      'PLAKA_NO=88'
      'GIRIS_TARIHI=75'
      'GIRIS_SAATI=54'
      'GIRIS_KILO=57')
    FieldsIndex.Strings = (
      'KANTAR_SID'
      'KANTAR_NO'
      'PLAKA_NO'
      'GIRIS_TARIHI'
      'GIRIS_SAATI'
      'GIRIS_KILO'
      'URUN_KOD'
      'URUN_AD'
      'CARI_KOD'
      'CARI_AD'
      'ACIKLAMA'
      'GELDIGI_YER'
      'MAKBUZ_NO'
      'GITTIGI_YER'
      'GITTIGI_YER_KOD'
      'GELDIGI_YER_KOD'
      'CIKIS_TARIHI'
      'CIKIS_SAATI'
      'ARAC_KILO'
      'CIKIS_KILO'
      'FARK_KILO'
      'UCRETI'
      'TIPI'
      'KASA_KOD'
      'KASA_AD'
      'MASRAF_MERK'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4'
      'PERSONEL_KOD'
      'PROJE_KOD')
    FieldsVisible.Strings = (
      'KANTAR_NO=FALSE'
      'KANTAR_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT KANTAR_SID'
      '     , KANTAR_NO'
      '     , GIRIS_TARIHI'
      '     , GIRIS_SAATI'
      '     , MAKBUZ_NO'
      '     , URUN_KOD'
      
        '     ,(Select URUN_AD from URUN where URUN.URUN_KOD=KANTAR.URUN_' +
        'KOD) as URUN_AD'
      '     , CARI_KOD'
      
        '     , (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=KANTAR' +
        '.CARI_KOD) As CARI_AD   '
      '     , ACIKLAMA'
      '     , GELDIGI_YER'
      '     , GELDIGI_YER_KOD'
      '     , GITTIGI_YER'
      '     , GITTIGI_YER_KOD'
      '     , CIKIS_TARIHI'
      '     , CIKIS_SAATI'
      '     , ARAC_KILO'
      '     , GIRIS_KILO'
      '     , CIKIS_KILO'
      '     , FARK_KILO'
      '     , UCRETI'
      '     , TIPI'
      '     , PLAKA_NO'
      '     , KASA_KOD'
      
        '     , (Select KASA.ACIKLAMA From KASA where KASA.KASA_KOD=KANTA' +
        'R.KASA_KOD) as KASA_AD'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , PERSONEL_KOD'
      '     , PROJE_KOD'
      ''
      'FROM KANTAR'
      'WHERE TIPI='#39'G'#39
      'ORDER BY GIRIS_TARIHI, GIRIS_SAATI'
      ''
      '/*WHERE KANTAR_NO=:PRM_KANTAR_NO*/')
    ColorScheme = False
    KeyLinks.Strings = (
      'KANTAR.KANTAR_SID'
      'KANTAR.KANTAR_NO')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterScroll = Qry_GirenlerAfterScroll
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 768
    Top = 112
  end
end
