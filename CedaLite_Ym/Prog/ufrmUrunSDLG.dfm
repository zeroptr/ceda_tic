object frmUrunSDLG: TfrmUrunSDLG
  Left = 45
  Top = 207
  ActiveControl = txtVeri
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = #220'r'#252'n Arama'
  ClientHeight = 365
  ClientWidth = 720
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 720
    Height = 135
    Align = alTop
    TabOrder = 0
    object Label3: TLabel
      Left = 124
      Top = 113
      Width = 39
      Height = 13
      Caption = 'Alan Ad'#305
    end
    object Label4: TLabel
      Left = 301
      Top = 112
      Width = 67
      Height = 13
      Caption = 'Aranacak Veri'
    end
    object txtVeri: TEdit
      Left = 373
      Top = 109
      Width = 188
      Height = 21
      TabOrder = 3
      OnEnter = txtVeriEnter
      OnExit = txtVeriExit
      OnKeyDown = txtVeriKeyDown
      OnKeyPress = txtVeriKeyPress
    end
    object btnAra: TButton
      Left = 636
      Top = 109
      Width = 79
      Height = 21
      Caption = '&Ara'
      TabOrder = 4
      OnClick = btnAraClick
    end
    object cboAlanAdi: TComboBox
      Left = 168
      Top = 109
      Width = 119
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnEnter = cboAlanAdiEnter
      OnExit = cboAlanAdiExit
      Items.Strings = (
        #220'r'#252'n Kodu'
        'T'#252'rk'#231'e '#220'r'#252'n Ad'#305)
    end
    object chkGrup: TCheckBox
      Left = 8
      Top = 1
      Width = 143
      Height = 17
      Caption = #220'r'#252'n Gruplar'#305
      TabOrder = 0
      OnClick = chkGrupClick
      OnEnter = chkGrupEnter
      OnExit = chkGrupExit
    end
    object IB_Grid1: TIB_Grid
      Left = 6
      Top = 17
      Width = 707
      Height = 89
      CustomGlyphsSupplied = []
      DataSource = dtsUrun_Grup
      Enabled = False
      OnDblClick = btnAraClick
      BorderStyle = bsNone
      TabOrder = 1
      RowSelect = True
      Ctl3DShallow = True
      TabMovesOut = True
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 335
    Width = 720
    Height = 30
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      720
      30)
    object btnTamam: TBitBtn
      Left = 643
      Top = 3
      Width = 75
      Height = 25
      Caption = '&Tamam'
      TabOrder = 0
      OnClick = btnTamamClick
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
    object btnIptal: TBitBtn
      Left = 554
      Top = 3
      Width = 85
      Height = 25
      Anchors = [akTop, akRight, akBottom]
      Cancel = True
      Caption = #304'&ptal'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnIptalClick
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
  end
  object IB_Grid2: TIB_Grid
    Left = 0
    Top = 135
    Width = 720
    Height = 200
    CustomGlyphsSupplied = []
    DataSource = dtsUrun
    Align = alClient
    OnDblClick = btnTamamClick
    BorderStyle = bsNone
    TabOrder = 1
    OnKeyPress = IB_Grid2KeyPress
    RowSelect = True
    Ctl3DShallow = True
    TabMovesOut = True
  end
  object qryUrun: TIB_Query
    ColumnAttributes.Strings = (
      'HIZMET=BOOLEAN=1,0')
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    FieldsDisplayLabel.Strings = (
      'UKOD='#220'r'#252'n Kodu'
      'URUNAD='#220'r'#252'n Ad'#305
      'HIZMET=Hizmet'
      'URUN_KOD='#220'r'#252'n Kodu'
      'URUN_AD='#220'r'#252'n Ad'#305
      'DOVKOD=Para Birimi'
      'BIRIMFIY=Birim Fiyat'
      'OLCUBIRIM='#214'l'#231#252' Birimi'
      'MIKTAR_BORC=Borc Miktar'#305
      'MIKTAR_ALACAK=Alacak Miktar'#305)
    FieldsDisplayWidth.Strings = (
      'UKOD=72'
      'URUNAD=368'
      'HIZMET=35'
      'DB_KEY=295'
      'URUN_KOD=77'
      'URUN_AD=227'
      'URUN_AD_ENG=193'
      'DOVKOD=54'
      'OLCUBIRIM=58'
      'BIRIMFIY=94'
      'MIKTAR_BORC=64'
      'MIKTAR_ALACAK=72')
    FieldsIndex.Strings = (
      'URUN_KOD'
      'URUN_AD'
      'DOVKOD'
      'BIRIMFIY'
      'OLCUBIRIM'
      'HIZMET')
    FieldsVisible.Strings = (
      'URUNID=FALSE'
      'URUN_SID=FALSE'
      'URUN_ID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT '
      '      URUN_KOD'
      '     , URUN_AD'
      '     , URUN.HIZMET'
      '     , DOVKOD'
      '     , BIRIMFIY'
      '     , OLCUBIRIM'
      '     , MIKTAR_BORC'
      '     , MIKTAR_ALACAK  '
      'FROM URUN')
    ColorScheme = False
    KeyLinks.Strings = (
      'URUN.URUN_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItems.Strings = (
      #220'r'#252'n Kodu=URUN_KOD;URUN_KOD DESC'
      #220'r'#252'n Ad'#305'=URUN_AD;URUN_AD DESC'
      'Para Birimi=DOVKOD;DOVKOD DESC'
      'Birim Fiyat=BIRIMFIY;BIRIMFIY DESC'
      #214'l'#231#252' Birimi=OLCUBIRIM;OLCUBIRIM DESC')
    OrderingLinks.Strings = (
      'URUN_KOD=ITEM=1'
      'URUN_AD=ITEM=2'
      'DOVKOD=ITEM=3'
      'BIRIMFIY=ITEM=4'
      'OLCUBIRIM=ITEM=5')
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 112
    Top = 263
  end
  object qryUrun_Grup: TIB_Query
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    FieldsDisplayLabel.Strings = (
      'UGKOD=Grup Kodu'
      'UGADI=Grup Ad'#305
      'DOVKOD=D'#246'v. Kodu'
      'BIRIMORAN=Birim Oran'#305
      'URUN_GRUP_KOD=Grup Kodu')
    FieldsDisplayWidth.Strings = (
      'UGKOD=60'
      'DOVKOD=56'
      'BIRIMORAN=55'
      'UGADI=368'
      'UG_KOD=102'
      'URUN_GRUP_KOD=109')
    FieldsVisible.Strings = (
      'URUN_GRUP_ID=FALSE'
      'URUN_GRUP_SID=FALSE'
      'UGACK=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT'
      '     URUN_GRUP_KOD   '
      '     , UGADI'
      '     , UGACK'
      '     , BIRIMORAN'
      '     , DOVKOD'
      '      '
      'From URUN_GRUP')
    ColorScheme = False
    KeyLinks.Strings = (
      'URUN_GRUP.URUN_GRUP_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 328
    Top = 284
  end
  object dtsUrun: TIB_DataSource
    Dataset = qryUrun
    Left = 168
    Top = 276
  end
  object dtsUrun_Grup: TIB_DataSource
    Dataset = qryUrun_Grup
    Left = 216
    Top = 264
  end
end
