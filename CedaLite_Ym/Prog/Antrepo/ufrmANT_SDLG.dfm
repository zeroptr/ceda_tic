object frmANT_SDLG: TfrmANT_SDLG
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Anrepo Hareket Arama'
  ClientHeight = 433
  ClientWidth = 890
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 301
    Width = 890
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 97
    ExplicitWidth = 207
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 890
    Height = 97
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 52
      Width = 55
      Height = 13
      Caption = 'Beyan T'#252'r'#252
    end
    object Label2: TLabel
      Left = 563
      Top = 52
      Width = 23
      Height = 13
      Caption = 'E'#351'ya'
    end
    object GroupBox1: TGroupBox
      Left = 497
      Top = 2
      Width = 384
      Height = 49
      Caption = 'Cari'
      TabOrder = 0
      object Label3: TLabel
        Left = 169
        Top = 19
        Width = 15
        Height = 13
        Caption = 'Ad'#305
      end
      object txtCARI_KOD: TLabeledEdit
        Left = 33
        Top = 17
        Width = 96
        Height = 21
        EditLabel.Width = 24
        EditLabel.Height = 13
        EditLabel.Caption = 'Kodu'
        LabelPosition = lpLeft
        TabOrder = 0
        OnKeyPress = txtBEYANKeyPress
      end
      object btnCARI_LIST: TButton
        Left = 135
        Top = 15
        Width = 22
        Height = 25
        Caption = '...'
        TabOrder = 1
        OnClick = btnCARI_LISTClick
      end
      object cboCARI_AD: TComboBox
        Left = 190
        Top = 16
        Width = 188
        Height = 21
        ItemHeight = 0
        TabOrder = 2
        OnKeyPress = txtBEYANKeyPress
      end
    end
    object GroupBox2: TGroupBox
      Left = 247
      Top = 2
      Width = 247
      Height = 49
      Caption = #304#351'lem Tarihi'
      TabOrder = 1
      object Label4: TLabel
        Left = 112
        Top = 20
        Width = 26
        Height = 13
        Caption = '> - <'
      end
      object dtpIslemTar: TDateTimePicker
        Left = 7
        Top = 17
        Width = 101
        Height = 21
        Date = 37554.733220983800000000
        Time = 37554.733220983800000000
        ShowCheckbox = True
        Checked = False
        TabOrder = 0
      end
      object dtpIslemTar2: TDateTimePicker
        Left = 144
        Top = 17
        Width = 100
        Height = 21
        Date = 37554.733416122690000000
        Time = 37554.733416122690000000
        ShowCheckbox = True
        Checked = False
        TabOrder = 1
      end
    end
    object txtKAP_ADET: TLabeledEdit
      Left = 361
      Top = 67
      Width = 96
      Height = 21
      EditLabel.Width = 46
      EditLabel.Height = 13
      EditLabel.Caption = 'Kap Adeti'
      TabOrder = 2
      OnKeyPress = txtKAP_ADETKeyPress
    end
    object txtKILO: TLabeledEdit
      Left = 463
      Top = 67
      Width = 96
      Height = 21
      EditLabel.Width = 16
      EditLabel.Height = 13
      EditLabel.Caption = 'Kilo'
      TabOrder = 3
      OnKeyPress = txtKAP_ADETKeyPress
    end
    object txtTASIYICI: TLabeledEdit
      Left = 243
      Top = 67
      Width = 112
      Height = 21
      EditLabel.Width = 34
      EditLabel.Height = 13
      EditLabel.Caption = 'Ta'#351#305'y'#305'c'#305
      TabOrder = 4
      OnKeyPress = txtBEYANKeyPress
    end
    object cboBEYAN: TComboBox
      Left = 9
      Top = 67
      Width = 110
      Height = 21
      Style = csDropDownList
      ItemHeight = 0
      TabOrder = 5
      Items.Strings = (
        'Antrepo Bey. No'
        #214'zet Beyan No'
        'Kon'#351'imento No')
    end
    object txtBEYAN: TLabeledEdit
      Left = 121
      Top = 67
      Width = 116
      Height = 21
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = 'Beyan'
      TabOrder = 6
      OnKeyPress = txtBEYANKeyPress
    end
    object btn_Ara: TButton
      Left = 804
      Top = 70
      Width = 77
      Height = 21
      Caption = '&Ara'
      TabOrder = 7
      OnClick = btn_AraClick
    end
    object cboESYA: TComboBox
      Left = 561
      Top = 67
      Width = 237
      Height = 21
      ItemHeight = 0
      TabOrder = 8
      OnKeyPress = txtBEYANKeyPress
    end
    object txtDEF_SIRA_NO: TLabeledEdit
      Left = 9
      Top = 23
      Width = 96
      Height = 21
      EditLabel.Width = 68
      EditLabel.Height = 13
      EditLabel.Caption = 'Defter S'#305'ra No'
      TabOrder = 9
      OnKeyPress = txtKAP_ADETKeyPress
    end
    object GroupBox3: TGroupBox
      Left = 111
      Top = 2
      Width = 130
      Height = 49
      Caption = 'Ya'#351#305' (G'#252'n)'
      TabOrder = 10
      object Label5: TLabel
        Left = 51
        Top = 24
        Width = 26
        Height = 13
        Caption = '> - <'
      end
      object txtYAS1: TEdit
        Left = 8
        Top = 20
        Width = 37
        Height = 21
        TabOrder = 0
        OnKeyPress = txtKAP_ADETKeyPress
      end
      object txtYAS2: TEdit
        Left = 83
        Top = 20
        Width = 37
        Height = 21
        TabOrder = 1
        OnKeyPress = txtKAP_ADETKeyPress
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 304
    Width = 890
    Height = 90
    Align = alBottom
    TabOrder = 1
    object IB_Grid2: TIB_Grid
      Left = 1
      Top = 1
      Width = 888
      Height = 88
      HelpType = htKeyword
      CustomGlyphsSupplied = []
      DataSource = dtsCIKIS
      Align = alClient
      PopupMenu = PopupMenu2
      OnDblClick = mnuCikisFisACClick
      Ctl3D = True
      ParentCtl3D = False
      PreventDeleting = True
      PreventEditing = True
      PreventInserting = True
      ReadOnly = True
      TabOrder = 0
      RowSelect = True
      Ctl3DShallow = True
    end
  end
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 97
    Width = 890
    Height = 204
    HelpType = htKeyword
    CustomGlyphsSupplied = []
    DataSource = dtsARA
    Align = alClient
    PopupMenu = PopupMenu1
    OnDblClick = IB_Grid1DblClick
    Ctl3D = True
    ParentCtl3D = False
    PreventDeleting = True
    PreventEditing = True
    PreventInserting = True
    ReadOnly = True
    TabOrder = 2
    RowSelect = True
    Ctl3DShallow = True
  end
  object Panel3: TPanel
    Left = 0
    Top = 394
    Width = 890
    Height = 39
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      890
      39)
    object BitBtn1: TBitBtn
      Left = 680
      Top = 6
      Width = 85
      Height = 25
      Anchors = [akRight, akBottom]
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
    object BitBtn2: TBitBtn
      Left = 771
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
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
  end
  object qryARA: TIB_Query
    ColumnAttributes.Strings = (
      'YANICI=BOOLEAN=1,0')
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    FieldsGridLabel.Strings = (
      'TARIH=Tarih'
      'TASIYAN_ID=Plaka / Ad'
      'OZET_BEYAN_NO='#214'zet B. No.'
      'ANT_BEYAN_NO=Ant. Bey. No'
      'KONSIMENTO=Kon'#351'imento'
      'CARI_AD=Cari Ad'
      'CARI_KOD=Cari Kod'
      'KAP_ADET=Kap Adet'
      'KILO=Kilo'
      'ESYA=E'#351'ya'
      'YANICI=Yan'#305'c'#305
      'YASI=G'#252'n'
      'KALAN_KAP=Kalan Kap'
      'KALAN_KILO=Kalan Kilo'
      'DEF_SIRA_NO=Def. S'#305'ra No.'
      'CIK_KAP='#199#305'kan Kap'
      'CIK_KILO='#199#305'kan Kilo'
      'GUM_VEZ_NO=Vezne Al'#305'nd'#305's'#305
      'GUM_KOM_KOD=Komisyoncu Kodu'
      'GUM_KOM_AD=Komisyoncu Ad'#305)
    FieldsDisplayWidth.Strings = (
      'TASIYAN_ID=69'
      'OZET_BEYAN_NO=77'
      'ANT_MAIN_ID=59'
      'ANT_BEYAN_NO=68'
      'CARI_AD=88'
      'CARI_KOD=57'
      'KAP_ADET=49'
      'KILO=63'
      'ESYA=84'
      'KONSIMENTO=87'
      'YASI=29'
      'TARIH=60'
      'KALAN_KILO=77'
      'DEF_SIRA_NO=62'
      'GUM_VEZ_NO=94'
      'GUM_KOM_KOD=47'
      'GUM_KOM_AD=126'
      'CIK_KILO=65')
    FieldsVisible.Strings = (
      'ANT_DETAIL_ID=FALSE'
      'ANT_MAIN_ID=FALSE'
      'CIK_KAP=TRUE'
      'CIK_KILO=TRUE'
      'GUM_VEZ_NO=TRUE'
      'GUM_KOM_KOD=TRUE'
      'GUM_KOM_AD=TRUE'
      'YASI=FALSE'
      'KALAN_KILO=FALSE'
      'KALAN_KAP=FALSE'
      'ANT_BEYAN_NO=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT ANT_MAIN.ANT_MAIN_ID'
      '     , ANT_DETAIL.ANT_DETAIL_ID'
      '     , ANT_MAIN.DEF_SIRA_NO'
      '     , ANT_MAIN.TARIH'
      '     , ANT_MAIN.TASIYAN_ID'
      '     , ANT_MAIN.OZET_BEYAN_NO'
      '     , ANT_DETAIL.ANT_BEYAN_NO'
      '     , ANT_DETAIL.KONSIMENTO'
      '     , ANT_DETAIL.CARI_KOD'
      '     , ANT_DETAIL.CARI_AD'
      '     , ANT_DETAIL.KAP_ADET'
      '     , ANT_DETAIL.KILO'
      '     , ANT_DETAIL.KALAN_KAP'
      '     , ANT_DETAIL.KALAN_KILO'
      '     , ANT_DETAIL.ESYA'
      '     , ((CURRENT_DATE - ANT_MAIN.TARIH)+1) AS YASI'
      '     , ANT_MAIN.CIK_KAP'
      '     , ANT_MAIN.CIK_KILO'
      '     , GUM_VEZ_NO'
      '     , GUM_KOM_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE CARI_KOD = ANT_MAIN.GUM_KO' +
        'M_KOD) AS GUM_KOM_AD'
      'FROM ANT_DETAIL'
      
        'INNER JOIN ANT_MAIN ON (ANT_DETAIL.ANT_MAIN_ID = ANT_MAIN.ANT_MA' +
        'IN_ID)')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItemNo = 1
    OrderingItems.Strings = (
      'ANT_MAIN_ID=ANT_MAIN.ANT_MAIN_ID;ANT_MAIN.ANT_MAIN_ID DESC'
      'TARIH=ANT_MAIN.TARIH;ANT_MAIN.TARIH DESC'
      'TASIYAN_ID=ANT_MAIN.TASIYAN_ID;ANT_MAIN.TASIYAN_ID DESC'
      'OZET_BEYAN_NO=ANT_MAIN.OZET_BEYAN_NO;ANT_MAIN.OZET_BEYAN_NO DESC'
      'KONSIMENTO=ANT_DETAIL.KONSIMENTO;ANT_DETAIL.KONSIMENTO DESC'
      
        'ANT_BEYAN_NO=ANT_DETAIL.ANT_BEYAN_NO;ANT_DETAIL.ANT_BEYAN_NO DES' +
        'C'
      'CARI_KOD=ANT_DETAIL.CARI_KOD;ANT_DETAIL.CARI_KOD DESC'
      'CARI_AD=ANT_DETAIL.CARI_AD;ANT_DETAIL.CARI_AD DESC'
      'KAP_ADET=ANT_DETAIL.KAP_ADET;ANT_DETAIL.KAP_ADET DESC'
      'KILO=ANT_DETAIL.KILO;ANT_DETAIL.KILO DESC'
      'ESYA=ANT_DETAIL.ESYA;ANT_DETAIL.ESYA DESC'
      'KALAN_KAP=ANT_DETAIL.KALAN_KAP;ANT_DETAIL.KALAN_KAP DESC'
      'KALAN_KILO=ANT_DETAIL.KALAN_KILO;ANT_DETAIL.KALAN_KILO DESC'
      'DEF_SIRA_NO=ANT_MAIN.DEF_SIRA_NO;ANT_MAIN.DEF_SIRA_NO DESC'
      
        'ANT_DETAIL_ID=ANT_DETAIL.ANT_DETAIL_ID;ANT_DETAIL.ANT_DETAIL_ID ' +
        'DESC'
      'CIK_KAP=ANT_MAIN.CIK_KAP;ANT_MAIN.CIK_KAP DESC'
      'CIK_KILO=ANT_MAIN.CIK_KILO;ANT_MAIN.CIK_KILO DESC'
      'GUM_VEZ_NO=ANT_MAIN.GUM_VEZ_NO;ANT_MAIN.GUM_VEZ_NO DESC'
      'GUM_KOM_KOD=ANT_MAIN.GUM_KOM_KOD;ANT_MAIN.GUM_KOM_KOD DESC')
    OrderingLinks.Strings = (
      'ANT_MAIN_ID=ITEM=1'
      'TARIH=ITEM=2'
      'TASIYAN_ID=ITEM=3'
      'OZET_BEYAN_NO=ITEM=4'
      'KONSIMENTO=ITEM=5'
      'ANT_BEYAN_NO=ITEM=6'
      'CARI_KOD=ITEM=7'
      'CARI_AD=ITEM=8'
      'KAP_ADET=ITEM=9'
      'KILO=ITEM=10'
      'ESYA=ITEM=11'
      'KALAN_KAP=ITEM=12'
      'KALAN_KILO=ITEM=13'
      'DEF_SIRA_NO=ITEM=14'
      'ANT_DETAIL_ID=ITEM=15'
      'CIK_KAP=ITEM=16'
      'CIK_KILO=ITEM=17'
      'GUM_VEZ_NO=ITEM=18'
      'GUM_KOM_KOD=ITEM=19')
    AfterScroll = qryARAAfterScroll
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 560
    Top = 116
  end
  object dtsARA: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = qryARA
    Left = 604
    Top = 116
  end
  object PopupMenu1: TPopupMenu
    Left = 504
    Top = 116
    object GiriFiiniGster1: TMenuItem
      Caption = 'Giri'#351' Fi'#351'ini A'#231
      OnClick = GiriFiiniGster1Click
    end
    object kFiiYarat1: TMenuItem
      Caption = #199#305'k'#305#351' Fi'#351'i Yarat'
      OnClick = kFiiYarat1Click
    end
  end
  object qryCIKIS: TIB_Query
    ColumnAttributes.Strings = (
      'YANICI=BOOLEAN=1,0'
      'KAP_BOL=BOOLEAN=1,0')
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    FieldsGridLabel.Strings = (
      'ANT_MAIN_ID=Def. S'#305'ra No.'
      'TARIH=Tarih'
      'TASIYAN_ID=Plaka / Ad'
      'OZET_BEYAN_NO='#199#305'k'#305#351' B. No.'
      'ANT_BEYAN_NO=Ant. Bey. No'
      'KONSIMENTO=Kon'#351'imento'
      'CARI_AD=Cari Ad'
      'CARI_KOD=Cari Kod'
      'KAP_ADET=Kap Adet'
      'KILO=Kilo'
      'ESYA=E'#351'ya'
      'YANICI=Yan'#305'c'#305
      'YASI=Ya'#351#305
      'KALAN_KAP=Kalan Kap'
      'KALAN_KILO=Kalan Kilo'
      'DEF_SIRA_NO=Def. S'#305'ra No.'
      'CIK_KAP='#199#305'kan Kap'
      'GUM_KOM_KOD=G'#252'm. Kom. Kod.'
      'GUM_KOM_AD=G'#252'mr'#252'k Komisyoncusu'
      'CIK_KILO='#199#305'kan Kilo'
      'GUM_VEZ_NO=Vezne Al'#305'nd'#305's'#305
      'KAP_BOL=Kap B'#246'l')
    FieldsDisplayWidth.Strings = (
      'TASIYAN_ID=69'
      'OZET_BEYAN_NO=63'
      'ANT_MAIN_ID=59'
      'ANT_BEYAN_NO=68'
      'CARI_AD=88'
      'CARI_KOD=57'
      'KAP_ADET=49'
      'KILO=63'
      'ESYA=84'
      'KONSIMENTO=87'
      'YASI=29'
      'TARIH=60'
      'KALAN_KILO=77'
      'DEF_SIRA_NO=74')
    FieldsIndex.Strings = (
      'ANT_MAIN.ANT_MAIN_ID'
      'ANT_MAIN.DEF_SIRA_NO'
      'ANT_MAIN.TARIH'
      'ANT_MAIN.TASIYAN_ID'
      'ANT_MAIN.OZET_BEYAN_NO'
      'ANT_DETAIL.ANT_DETAIL_ID'
      'ANT_MAIN.KAP_BOL'
      'ANT_MAIN.CIK_KAP'
      'ANT_MAIN.CIK_KILO'
      'ANT_MAIN.GUM_VEZ_NO'
      'ANT_MAIN.GUM_KOM_KOD'
      'GUM_KOM_AD')
    FieldsVisible.Strings = (
      'ANT_DETAIL_ID=FALSE'
      'ANT_MAIN_ID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT ANT_MAIN.ANT_MAIN_ID'
      '     , ANT_DETAIL.ANT_DETAIL_ID     '
      '     , DEF_SIRA_NO'
      '     , ANT_MAIN.TARIH'
      '     , ANT_MAIN.TASIYAN_ID'
      '     , ANT_MAIN.OZET_BEYAN_NO'
      '     , KAP_BOL'
      '     , ANT_MAIN.CIK_KAP'
      '     , ANT_MAIN.CIK_KILO'
      '     , GUM_VEZ_NO'
      '     , GUM_KOM_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE CARI_KOD = ANT_MAIN.GUM_KO' +
        'M_KOD) AS GUM_KOM_AD'
      'FROM ANT_MAIN'
      
        'INNER JOIN ANT_DETAIL ON (ANT_MAIN.GIRIS_ANT_DETAIL_ID = ANT_DET' +
        'AIL.ANT_DETAIL_ID)'
      'WHERE ANT_MAIN.GIRIS_ANT_DETAIL_ID =:PRM_ANT_DETAIL_ID;')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItemNo = 1
    OrderingItems.Strings = (
      'ANT_MAIN_ID=ANT_MAIN.ANT_MAIN_ID;ANT_MAIN.ANT_MAIN_ID DESC'
      'TARIH=ANT_MAIN.TARIH;ANT_MAIN.TARIH DESC'
      'TASIYAN_ID=ANT_MAIN.TASIYAN_ID;ANT_MAIN.TASIYAN_ID DESC'
      'OZET_BEYAN_NO=ANT_MAIN.OZET_BEYAN_NO;ANT_MAIN.OZET_BEYAN_NO DESC'
      'KONSIMENTO=ANT_DETAIL.KONSIMENTO;ANT_DETAIL.KONSIMENTO DESC'
      
        'ANT_BEYAN_NO=ANT_DETAIL.ANT_BEYAN_NO;ANT_DETAIL.ANT_BEYAN_NO DES' +
        'C'
      'CARI_KOD=ANT_DETAIL.CARI_KOD;ANT_DETAIL.CARI_KOD DESC'
      'CARI_AD=ANT_DETAIL.CARI_AD;ANT_DETAIL.CARI_AD DESC'
      'KAP_ADET=ANT_DETAIL.KAP_ADET;ANT_DETAIL.KAP_ADET DESC'
      'KILO=ANT_DETAIL.KILO;ANT_DETAIL.KILO DESC'
      'ESYA=ANT_DETAIL.ESYA;ANT_DETAIL.ESYA DESC')
    OrderingLinks.Strings = (
      'ANT_MAIN_ID=ITEM=1'
      'TARIH=ITEM=2'
      'TASIYAN_ID=ITEM=3'
      'OZET_BEYAN_NO=ITEM=4'
      'KONSIMENTO=ITEM=5'
      'ANT_BEYAN_NO=ITEM=6'
      'CARI_KOD=ITEM=7'
      'CARI_AD=ITEM=8'
      'KAP_ADET=ITEM=9'
      'KILO=ITEM=10'
      'ESYA=ITEM=11')
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 520
    Top = 256
    ParamValues = (
      'PRM_ANT_DETAIL_ID=0')
  end
  object dtsCIKIS: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = qryCIKIS
    Left = 584
    Top = 260
  end
  object PopupMenu2: TPopupMenu
    Left = 368
    Top = 212
    object mnuCikisFisAC: TMenuItem
      Caption = #199#305'k'#305#351' Fi'#351'ini A'#231
      OnClick = mnuCikisFisACClick
    end
  end
end
