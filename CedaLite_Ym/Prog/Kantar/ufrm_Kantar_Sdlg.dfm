object frm_Kantar_Sdlg: Tfrm_Kantar_Sdlg
  Left = 65
  Top = 91
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Kantar Listesi'
  ClientHeight = 481
  ClientWidth = 845
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 442
    Width = 845
    Height = 39
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      845
      39)
    object btnIPTAL: TBitBtn
      Left = 681
      Top = 8
      Width = 85
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #304'&ptal'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnIPTALClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object btnTAMAM: TBitBtn
      Left = 765
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Tamam'
      TabOrder = 1
      OnClick = btnTAMAMClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
    end
    object btnRapor: TButton
      Left = 6
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Rapor Olu'#351'tur'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 225
    Width = 845
    Height = 217
    CustomGlyphsSupplied = []
    DataSource = DtsKantar
    Align = alClient
    OnDblClick = btnTAMAMClick
    BorderStyle = bsNone
    ReadOnly = True
    TabOrder = 1
    RowSelect = True
    Ctl3DShallow = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 845
    Height = 225
    Align = alTop
    TabOrder = 2
    object Label2: TLabel
      Left = 10
      Top = 15
      Width = 51
      Height = 13
      Caption = #220'r'#252'n Kodu'
    end
    object lblMamul_Ad: TLabel
      Left = 154
      Top = 31
      Width = 41
      Height = 13
      Caption = #220'r'#252'n Ad'#305
    end
    object Label7: TLabel
      Left = 10
      Top = 95
      Width = 46
      Height = 13
      Caption = 'Cari Kodu'
    end
    object lblCari_Adi: TLabel
      Left = 154
      Top = 111
      Width = 36
      Height = 13
      Caption = 'Cari Ad'#305
    end
    object Label9: TLabel
      Left = 10
      Top = 55
      Width = 44
      Height = 13
      Caption = 'Plaka No'
    end
    object Label10: TLabel
      Left = 802
      Top = 36
      Width = 17
      Height = 13
      Caption = 'Tipi'
      OnClick = Label10Click
    end
    object lbl_Plaka_Aciklama: TLabel
      Left = 154
      Top = 71
      Width = 73
      Height = 13
      Caption = 'Plaka A'#231#305'klama'
    end
    object Label11: TLabel
      Left = 10
      Top = 143
      Width = 51
      Height = 13
      Caption = 'Geldi'#287'i Yer'
    end
    object Label12: TLabel
      Left = 10
      Top = 167
      Width = 45
      Height = 13
      Caption = 'Gitti'#287'i Yer'
    end
    object Label13: TLabel
      Left = 10
      Top = 191
      Width = 43
      Height = 13
      Caption = 'A'#231#305'klama'
    end
    object btn_Ara: TButton
      Left = 784
      Top = 174
      Width = 51
      Height = 39
      Caption = '&Ara'
      TabOrder = 12
      OnClick = btn_AraClick
    end
    object GroupBox2: TGroupBox
      Left = 338
      Top = 9
      Width = 247
      Height = 45
      Caption = 'Giri'#351' Tarihi'
      TabOrder = 8
      object Label4: TLabel
        Left = 112
        Top = 18
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object dtpGiris_tar: TDateTimePicker
        Left = 7
        Top = 15
        Width = 101
        Height = 21
        Date = 37554.733220983800000000
        Time = 37554.733220983800000000
        ShowCheckbox = True
        Checked = False
        TabOrder = 0
        OnEnter = txt_Plaka_NoEnter
        OnExit = txt_Plaka_NoExit
      end
      object dtpGiris_Tar2: TDateTimePicker
        Left = 137
        Top = 14
        Width = 100
        Height = 21
        Date = 37554.733416122690000000
        Time = 37554.733416122690000000
        ShowCheckbox = True
        Checked = False
        TabOrder = 1
        OnEnter = txt_Plaka_NoEnter
        OnExit = txt_Plaka_NoExit
      end
    end
    object GroupBox3: TGroupBox
      Left = 594
      Top = 9
      Width = 183
      Height = 45
      Caption = 'Ara'#231' Kilo'
      TabOrder = 7
      object Label1: TLabel
        Left = 81
        Top = 17
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object crArac_Kilo: TIB_Currency
        Left = 6
        Top = 14
        Width = 75
        Height = 21
        TabOrder = 0
        OnEnter = txt_Plaka_NoEnter
        OnExit = txt_Plaka_NoExit
        AlwaysShowButton = True
      end
      object crArac_Kilo2: TIB_Currency
        Left = 104
        Top = 14
        Width = 73
        Height = 21
        TabOrder = 1
        OnEnter = txt_Plaka_NoEnter
        OnExit = txt_Plaka_NoExit
        AlwaysShowButton = True
      end
    end
    object txtMamul_Kod: TEdit
      Left = 9
      Top = 28
      Width = 120
      Height = 21
      TabOrder = 0
      OnEnter = txtMamul_KodEnter
      OnExit = txtMamul_KodExit
      OnKeyPress = txtMamul_KodKeyPress
    end
    object Button1: TButton
      Left = 130
      Top = 28
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
      OnClick = Button1Click
    end
    object GroupBox1: TGroupBox
      Left = 338
      Top = 65
      Width = 247
      Height = 45
      Caption = #199#305'k'#305#351' Tarihi'
      TabOrder = 9
      object Label3: TLabel
        Left = 112
        Top = 18
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object dtpCikis_Tar: TDateTimePicker
        Left = 7
        Top = 15
        Width = 101
        Height = 21
        Date = 37554.733220983800000000
        Time = 37554.733220983800000000
        ShowCheckbox = True
        Checked = False
        TabOrder = 0
        OnEnter = txt_Plaka_NoEnter
        OnExit = txt_Plaka_NoExit
      end
      object dtpCikis_Tar2: TDateTimePicker
        Left = 137
        Top = 14
        Width = 100
        Height = 21
        Date = 37554.733416122690000000
        Time = 37554.733416122690000000
        ShowCheckbox = True
        Checked = False
        TabOrder = 1
        OnEnter = txt_Plaka_NoEnter
        OnExit = txt_Plaka_NoExit
      end
    end
    object GroupBox4: TGroupBox
      Left = 338
      Top = 121
      Width = 247
      Height = 45
      Caption = 'Giri'#351' Saati'
      TabOrder = 10
      object Label5: TLabel
        Left = 112
        Top = 18
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object dtpGiris_Sat: TDateTimePicker
        Left = 7
        Top = 15
        Width = 101
        Height = 21
        Date = 37554.733220983800000000
        Time = 37554.733220983800000000
        ShowCheckbox = True
        Checked = False
        Kind = dtkTime
        TabOrder = 0
        OnEnter = txt_Plaka_NoEnter
        OnExit = txt_Plaka_NoExit
      end
      object dtpGiris_Sat2: TDateTimePicker
        Left = 137
        Top = 14
        Width = 100
        Height = 21
        Date = 37554.733416122690000000
        Time = 37554.733416122690000000
        ShowCheckbox = True
        Checked = False
        Kind = dtkTime
        TabOrder = 1
        OnEnter = txt_Plaka_NoEnter
        OnExit = txt_Plaka_NoExit
      end
    end
    object txtCari_Kod: TEdit
      Left = 9
      Top = 108
      Width = 120
      Height = 21
      TabOrder = 2
      OnEnter = txtCari_KodEnter
      OnExit = txtCari_KodExit
      OnKeyPress = txtMamul_KodKeyPress
    end
    object Button2: TButton
      Left = 130
      Top = 108
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
      OnClick = Button2Click
    end
    object GroupBox5: TGroupBox
      Left = 594
      Top = 169
      Width = 183
      Height = 45
      Caption = 'Fark Kilo'
      TabOrder = 6
      object Label6: TLabel
        Left = 81
        Top = 17
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object crFark_Kilo: TIB_Currency
        Left = 6
        Top = 14
        Width = 75
        Height = 21
        TabOrder = 0
        OnEnter = txt_Plaka_NoEnter
        OnExit = txt_Plaka_NoExit
        AlwaysShowButton = True
      end
      object crFark_Kilo2: TIB_Currency
        Left = 104
        Top = 14
        Width = 73
        Height = 21
        TabOrder = 1
        OnEnter = txt_Plaka_NoEnter
        OnExit = txt_Plaka_NoExit
        AlwaysShowButton = True
      end
    end
    object GroupBox6: TGroupBox
      Left = 338
      Top = 169
      Width = 247
      Height = 45
      Caption = #199#305'k'#305#351' Saati'
      TabOrder = 11
      object Label8: TLabel
        Left = 112
        Top = 18
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object dtpCikis_Sat: TDateTimePicker
        Left = 7
        Top = 15
        Width = 101
        Height = 21
        Date = 37554.733220983800000000
        Time = 37554.733220983800000000
        ShowCheckbox = True
        Checked = False
        Kind = dtkTime
        TabOrder = 0
        OnEnter = txt_Plaka_NoEnter
        OnExit = txt_Plaka_NoExit
      end
      object dptCikis_Sat2: TDateTimePicker
        Left = 137
        Top = 14
        Width = 100
        Height = 21
        Date = 37554.733416122690000000
        Time = 37554.733416122690000000
        ShowCheckbox = True
        Checked = False
        Kind = dtkTime
        TabOrder = 1
        OnEnter = txt_Plaka_NoEnter
        OnExit = txt_Plaka_NoExit
      end
    end
    object txt_Plaka_No: TEdit
      Left = 9
      Top = 68
      Width = 120
      Height = 21
      TabOrder = 4
      OnEnter = txt_Plaka_NoEnter
      OnExit = txt_Plaka_NoExit
      OnKeyPress = txtMamul_KodKeyPress
    end
    object cb_Tipi: TComboBox
      Left = 784
      Top = 61
      Width = 57
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      OnEnter = txt_Plaka_NoEnter
      OnExit = txt_Plaka_NoExit
      Items.Strings = (
        'Giri'#351
        #199#305'k'#305#351
        'T'#252'm'#252)
    end
    object Button3: TButton
      Left = 130
      Top = 68
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 13
      OnClick = Button3Click
    end
    object cb_Geldigi_Yer: TComboBox
      Left = 96
      Top = 136
      Width = 233
      Height = 21
      ItemHeight = 13
      TabOrder = 14
    end
    object cb_Gitigi_Yer: TComboBox
      Left = 96
      Top = 160
      Width = 233
      Height = 21
      ItemHeight = 13
      TabOrder = 15
    end
    object cb_Aciklama: TComboBox
      Left = 96
      Top = 184
      Width = 233
      Height = 21
      ItemHeight = 13
      TabOrder = 16
    end
    object GroupBox7: TGroupBox
      Left = 594
      Top = 65
      Width = 183
      Height = 45
      Caption = 'Giri'#351' Kilo'
      TabOrder = 17
      object Label14: TLabel
        Left = 81
        Top = 17
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object cr_Giris_Kilo1: TIB_Currency
        Left = 6
        Top = 14
        Width = 75
        Height = 21
        TabOrder = 0
        OnEnter = txt_Plaka_NoEnter
        OnExit = txt_Plaka_NoExit
        AlwaysShowButton = True
      end
      object cr_Giris_Kilo2: TIB_Currency
        Left = 104
        Top = 14
        Width = 73
        Height = 21
        TabOrder = 1
        OnEnter = txt_Plaka_NoEnter
        OnExit = txt_Plaka_NoExit
        AlwaysShowButton = True
      end
    end
    object GroupBox8: TGroupBox
      Left = 594
      Top = 121
      Width = 183
      Height = 45
      Caption = #199#305'k'#305#351' Kilo'
      TabOrder = 18
      object Label15: TLabel
        Left = 81
        Top = 17
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object cr_Cikis_Kilo1: TIB_Currency
        Left = 6
        Top = 14
        Width = 75
        Height = 21
        TabOrder = 0
        OnEnter = txt_Plaka_NoEnter
        OnExit = txt_Plaka_NoExit
        AlwaysShowButton = True
      end
      object cr_Cikis_Kilo2: TIB_Currency
        Left = 104
        Top = 14
        Width = 73
        Height = 21
        TabOrder = 1
        OnEnter = txt_Plaka_NoEnter
        OnExit = txt_Plaka_NoExit
        AlwaysShowButton = True
      end
    end
  end
  object DtsKantar: TIB_DataSource
    Dataset = qry_Kantar
    Left = 272
    Top = 64
  end
  object qry_Kantar: TIB_Query
    DatabaseName = 'c:\CedaLite\Db\cevresel_2006.FDB'
    FieldsDisplayLabel.Strings = (
      'GIRIS_TARIHI=Giri'#351' Tarihi'
      'GIRIS_SAATI=Giri'#351' Saati'
      'MAKBUZ_NO=Makbu No'
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
      'PLAKA_NO=Plaka No')
    FieldsDisplayWidth.Strings = (
      'FARK_KILO=77'
      'UCRETI=84'
      'TIPI=64')
    FieldsIndex.Strings = (
      'KANTAR_SID'
      'KANTAR_NO'
      'PLAKA_NO'
      'GIRIS_TARIHI'
      'GIRIS_SAATI'
      'CIKIS_TARIHI'
      'CIKIS_SAATI'
      'MAKBUZ_NO'
      'URUN_KOD'
      'URUN_AD'
      'CARI_KOD'
      'CARI_AD'
      'ACIKLAMA'
      'GELDIGI_YER'
      'GELDIGI_YER_KOD'
      'GITTIGI_YER'
      'GITTIGI_YER_KOD'
      'ARAC_KILO'
      'GIRIS_KILO'
      'CIKIS_KILO'
      'FARK_KILO'
      'UCRETI'
      'TIPI')
    FieldsVisible.Strings = (
      'KANTAR_NO=FALSE'
      'KANTAR_SID=FALSE'
      'GELDIGI_YER_KOD=FALSE'
      'GITTIGI_YER_KOD=FALSE')
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
      'FROM KANTAR'
      'WHERE KANTAR_SID=:PRM_KANTAR_SID AND KANTAR_NO=:PRM_KANTAR_NO')
    ColorScheme = False
    KeyLinks.Strings = (
      'KANTAR.KANTAR_SID'
      'KANTAR.KANTAR_NO')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItems.Strings = (
      'Plaka No=PLAKA_NO;PLAKA_NO DESC'
      'Giri'#351' Tarihi=GIRIS_TARIHI;GIRIS_TARIHI DESC'
      'Giri'#351' Saati=GIRIS_SAATI;GIRIS_SAATI DESC'
      #199#305'k'#305#351' Tarihi=CIKIS_TARIHI;CIKIS_TARIHI DESC'
      #199#305'k'#305#351' Saati=CIKIS_SAATI;CIKIS_SAATI DESC'
      'Makbu No=MAKBUZ_NO;MAKBUZ_NO DESC'
      #220'r'#252'n Kodu=URUN_KOD;URUN_KOD DESC'
      'Cari Kod=CARI_KOD;CARI_KOD DESC'
      'Geldi'#287'i Yer=GELDIGI_YER;GELDIGI_YER DESC'
      'Gittigi Yer=GITTIGI_YER;GITTIGI_YER DESC'
      'Ara'#231' Kilo=ARAC_KILO;ARAC_KILO DESC'
      'Giri'#351' Kilo=GIRIS_KILO;GIRIS_KILO DESC'
      #199#305'k'#305#351' Kilo=CIKIS_KILO;CIKIS_KILO DESC'
      'Giri'#351' '#199#305'k'#305#351' Fark'#305'=FARK_KILO;FARK_KILO DESC'
      #220'creti=UCRETI;UCRETI DESC'
      'Tipi=TIPI;TIPI DESC')
    OrderingLinks.Strings = (
      'PLAKA_NO=ITEM=1'
      'GIRIS_TARIHI=ITEM=2'
      'GIRIS_SAATI=ITEM=3'
      'CIKIS_TARIHI=ITEM=4'
      'CIKIS_SAATI=ITEM=5'
      'MAKBUZ_NO=ITEM=6'
      'URUN_KOD=ITEM=7'
      'CARI_KOD=ITEM=8'
      'GELDIGI_YER=ITEM=9'
      'GITTIGI_YER=ITEM=10'
      'ARAC_KILO=ITEM=11'
      'GIRIS_KILO=ITEM=12'
      'CIKIS_KILO=ITEM=13'
      'FARK_KILO=ITEM=14'
      'UCRETI=ITEM=15'
      'TIPI=ITEM=16')
    ReadOnly = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 312
    Top = 72
    ParamValues = (
      'PRM_KANTAR_SID=0')
  end
  object frxIBOKantar_Fis_Lis: TfrxIBODataset
    UserName = 'frxIBOKantar_Fis_Lis'
    CloseDataSource = False
    FieldAliases.Strings = (
      'KANTAR_SID=KANTAR_SID'
      'KANTAR_NO=KANTAR_NO'
      'PLAKA_NO=PLAKA_NO'
      'GIRIS_TARIHI=GIRIS_TARIHI'
      'GIRIS_SAATI=GIRIS_SAATI'
      'CIKIS_TARIHI=CIKIS_TARIHI'
      'CIKIS_SAATI=CIKIS_SAATI'
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
      'ARAC_KILO=ARAC_KILO'
      'GIRIS_KILO=GIRIS_KILO'
      'CIKIS_KILO=CIKIS_KILO'
      'FARK_KILO=FARK_KILO'
      'UCRETI=UCRETI'
      'TIPI=TIPI')
    DataSet = qry_Kantar
    Left = 256
    Top = 184
  end
  object frxReport1: TfrxReport
    Version = '4.3'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39136.775302905100000000
    ReportOptions.LastChange = 39203.635718495370000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 336
    Top = 185
  end
end
