object frmANT_GIRIS: TfrmANT_GIRIS
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Antrepo Giri'#351' Fi'#351'i'
  ClientHeight = 404
  ClientWidth = 761
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
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 761
    Height = 109
    TabOrder = 0
    object IB_Edit1: TIB_Edit
      Left = 249
      Top = 33
      Width = 121
      Height = 21
      AutoLabel.Kind = albTop
      AutoLabel.Caption = 'Ta'#351#305'y'#305'c'#305' Plaka / Ad / Seri '
      DataField = 'TASIYAN_ID'
      DataSource = dtsANT_MAIN
      TabOrder = 4
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      OnKeyPress = IB_Edit1KeyPress
    end
    object IB_Edit2: TIB_Edit
      Left = 11
      Top = 75
      Width = 121
      Height = 21
      AutoLabel.Kind = albTop
      AutoLabel.Caption = #214'zet Beyan No'
      DataField = 'OZET_BEYAN_NO'
      DataSource = dtsANT_MAIN
      TabOrder = 5
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      OnKeyPress = IB_Edit1KeyPress
    end
    object IB_Date1: TIB_Date
      Left = 11
      Top = 33
      Width = 105
      Height = 21
      AutoLabel.Kind = albTop
      AutoLabel.Caption = 'Tarih'
      DataField = 'TARIH'
      DataSource = dtsANT_MAIN
      TabOrder = 2
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      IncCellHeight = 1
      IncCellWidth = 2
      DrawYearArrow = False
    end
    object IB_ComboBox1: TIB_ComboBox
      Left = 138
      Top = 33
      Width = 105
      Height = 21
      AutoLabel.Kind = albTop
      AutoLabel.Caption = 'Ta'#351#305'y'#305'c'#305
      DataField = 'TASIYAN'
      DataSource = dtsANT_MAIN
      TabOrder = 3
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      Style = csDropDownList
      ItemHeight = 13
      Items.Strings = (
        'TIR'
        'GEMI')
      ItemValues.Strings = (
        '1'
        '2')
    end
    object IB_Date2: TIB_Date
      Left = 138
      Top = 75
      Width = 105
      Height = 21
      AutoLabel.Kind = albTop
      AutoLabel.Caption = #214'zet Beyan Tar'
      DataField = 'OZET_BEYAN_TAR'
      DataSource = dtsANT_MAIN
      TabOrder = 6
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      IncCellHeight = 1
      IncCellWidth = 2
      DrawYearArrow = False
    end
    object IB_Edit3: TIB_Edit
      Left = 249
      Top = 75
      Width = 121
      Height = 21
      AutoLabel.Kind = albTop
      AutoLabel.Caption = 'Kon'#351'imento'
      DataField = 'KONSIMENTO'
      DataSource = dtsANT_MAIN
      TabOrder = 7
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      OnKeyPress = IB_Edit1KeyPress
    end
    object IB_CheckBox2: TIB_CheckBox
      Left = 5
      Top = 4
      Width = 47
      Height = 17
      TabStop = False
      DataField = 'DEVIR'
      DataSource = dtsANT_MAIN
      OnClick = IB_CheckBox2Click
      BorderStyle = bsNone
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      Caption = 'Devir'
    end
    object txtDEFSIRANO: TIB_Edit
      Left = 122
      Top = 5
      Width = 50
      Height = 15
      TabStop = False
      AutoLabel.Kind = albLeft
      AutoLabel.Caption = 'Def. S'#305'ra No.'
      DataField = 'DEF_SIRA_NO'
      DataSource = dtsANT_MAIN
      BorderStyle = bsNone
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 1
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      OnKeyPress = txtDEFSIRANOKeyPress
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 372
    Width = 761
    Height = 32
    Align = alBottom
    TabOrder = 2
    TabStop = True
    object btnAra: TBitBtn
      Left = 600
      Top = 3
      Width = 62
      Height = 25
      Caption = '&Ara'
      TabOrder = 1
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
      Left = 692
      Top = 3
      Width = 61
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 2
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
    object btnTRN_KAYDET: TButton
      Left = 100
      Top = 3
      Width = 119
      Height = 25
      Caption = 'Kaydet ( CTRL + END)'
      TabOrder = 0
      OnClick = btnTRN_KAYDETClick
    end
    object btnTRN_IPTAL: TButton
      Left = 223
      Top = 3
      Width = 108
      Height = 25
      Caption = 'Iptal (CTRL + A)'
      TabOrder = 3
      OnClick = btnTRN_IPTALClick
    end
    object btnFisSil: TBitBtn
      Left = 337
      Top = 3
      Width = 92
      Height = 25
      Caption = 'Sil (CTRL + DEL)'
      TabOrder = 4
      OnClick = btnFisSilClick
    end
    object btnYeni: TButton
      Left = 3
      Top = 3
      Width = 94
      Height = 25
      Caption = 'Yeni (CTRL+INS)'
      TabOrder = 5
      OnClick = btnYeniClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 109
    Width = 761
    Height = 112
    TabOrder = 1
    object IB_Edit4: TIB_Edit
      Left = 12
      Top = 18
      Width = 121
      Height = 21
      HelpType = htKeyword
      AutoLabel.Kind = albTop
      AutoLabel.Caption = 'Kon'#351'imento'
      DataField = 'KONSIMENTO'
      DataSource = dtsANT_DETAIL
      TabOrder = 0
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      OnKeyPress = IB_Edit1KeyPress
    end
    object IB_Edit5: TIB_Edit
      Left = 139
      Top = 18
      Width = 121
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'ANT_BEYAN_NO'
      DataSource = dtsANT_DETAIL
      TabOrder = 1
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      OnKeyPress = IB_Edit1KeyPress
    end
    object IB_Date3: TIB_Date
      Left = 266
      Top = 18
      Width = 104
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'ANT_BEYAN_TAR'
      DataSource = dtsANT_DETAIL
      TabOrder = 2
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      IncCellHeight = 1
      IncCellWidth = 2
      DrawYearArrow = False
    end
    object IB_Edit6: TIB_Edit
      Left = 12
      Top = 58
      Width = 121
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'CARI_KOD'
      DataSource = dtsANT_DETAIL
      TabOrder = 5
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit6Exit
      OnKeyDown = IB_Edit6KeyDown
      OnKeyPress = IB_Edit1KeyPress
      ButtonStyle = ebsEllipsis
      OnButtonClick = IB_Edit6ButtonClick
    end
    object IB_CheckBox1: TIB_CheckBox
      Left = 622
      Top = 19
      Width = 47
      Height = 17
      DataField = 'YANICI'
      DataSource = dtsANT_DETAIL
      BorderStyle = bsNone
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 4
      Caption = 'Yan'#305'c'#305
    end
    object IB_Currency1: TIB_Currency
      Left = 303
      Top = 56
      Width = 59
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'KAP_ADET'
      DataSource = dtsANT_DETAIL
      TabOrder = 7
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      AlwaysShowButton = True
    end
    object IB_Currency2: TIB_Currency
      Left = 368
      Top = 56
      Width = 62
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'KILO'
      DataSource = dtsANT_DETAIL
      TabOrder = 8
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      AlwaysShowButton = True
    end
    object IB_Currency3: TIB_Currency
      Left = 436
      Top = 56
      Width = 69
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'ARDIYE_FIY'
      DataSource = dtsANT_DETAIL
      TabOrder = 9
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      AlwaysShowButton = True
    end
    object IB_Currency4: TIB_Currency
      Left = 577
      Top = 54
      Width = 64
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'HAMMALIYE'
      DataSource = dtsANT_DETAIL
      TabOrder = 11
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      AlwaysShowButton = True
    end
    object cboDOVKOD: TIB_ComboBox
      Left = 511
      Top = 55
      Width = 60
      Height = 21
      AutoLabel.Kind = albTop
      AutoLabel.Caption = 'D'#246'viz Kodu'
      DataField = 'ARD_DOVKOD'
      DataSource = dtsANT_DETAIL
      TabOrder = 10
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      Style = csDropDownList
      ItemHeight = 13
    end
    object cboHDOVKOD: TIB_ComboBox
      Left = 647
      Top = 53
      Width = 60
      Height = 21
      AutoLabel.Kind = albTop
      AutoLabel.Caption = 'D'#246'viz Kodu'
      DataField = 'HAMM_DOVKOD'
      DataSource = dtsANT_DETAIL
      TabOrder = 12
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      Style = csDropDownList
      ItemHeight = 13
    end
    object btnKaydet: TButton
      Left = 68
      Top = 89
      Width = 94
      Height = 23
      Caption = 'Kaydet (CTRL+S)'
      TabOrder = 13
      OnClick = btnKaydetClick
    end
    object btnEKLE: TButton
      Left = 5
      Top = 89
      Width = 60
      Height = 23
      Caption = 'Ekle (INS)'
      TabOrder = 15
      OnClick = btnEKLEClick
    end
    object btnIptal: TButton
      Left = 164
      Top = 89
      Width = 86
      Height = 23
      Caption = #304'ptal(CTRL+P)'
      TabOrder = 14
      OnClick = btnIptalClick
    end
    object btnSil: TButton
      Left = 640
      Top = 89
      Width = 95
      Height = 23
      Caption = 'Sil (CTRL + DEL)'
      TabOrder = 16
      OnClick = btnSilClick
    end
    object cboCARI_AD: TIB_ComboBox
      Left = 139
      Top = 57
      Width = 158
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'CARI_AD'
      DataSource = dtsANT_DETAIL
      TabOrder = 6
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      OnKeyPress = IB_Edit1KeyPress
      ItemHeight = 13
    end
    object cboESYA: TIB_ComboBox
      Left = 376
      Top = 17
      Width = 232
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'ESYA'
      DataSource = dtsANT_DETAIL
      TabOrder = 3
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      OnKeyPress = IB_Edit1KeyPress
      ItemHeight = 13
    end
  end
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 221
    Width = 761
    Height = 151
    HelpType = htKeyword
    CustomGlyphsSupplied = []
    DataSource = dtsANT_DETAIL
    BorderStyle = bsNone
    Ctl3D = True
    ParentCtl3D = False
    PreventDeleting = True
    PreventEditing = True
    PreventInserting = True
    ReadOnly = True
    TabOrder = 3
    RowSelect = True
    Ctl3DShallow = True
  end
  object qryANT_MAIN: TIB_Query
    ColumnAttributes.Strings = (
      'DEVIR=BOOLEAN=1,0')
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnANTREPO
    SQL.Strings = (
      'SELECT ANT_MAIN_ID'
      '     , ANT_MAIN_SID'
      '     , DEF_SIRA_NO'
      '     , TARIH'
      '     , GIRCIK'
      '     , TASIYAN'
      '     , TASIYAN_ID'
      '     , OZET_BEYAN_NO'
      '     , OZET_BEYAN_TAR'
      '     , KONSIMENTO'
      '     , GIRIS_ANT_DETAIL_ID'
      '     , CIK_KAP'
      '     , CIK_KILO'
      '     , FATURA_ID'
      '     , GUM_VEZ_NO'
      '     , GUM_VEZ_TAR'
      '     , GUM_KOM_KOD'
      '     , KAP_BOL'
      '     , DEVIR'
      'FROM ANT_MAIN'
      'WHERE ANT_MAIN_ID =:PRM_ANT_MAIN_ID')
    ColorScheme = False
    DefaultValues.Strings = (
      'ANT_MAIN_ID=0'
      'DEF_SIRA_NO=0'
      'GIRIS_ANT_DETAIL_ID=0'
      'CIK_KILO=0'
      'FATURA_ID=0'
      'GUM_KOM_KOD=0')
    KeyLinks.Strings = (
      'ANT_MAIN.ANT_MAIN_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryANT_MAINAfterInsert
    BeforeCancel = qryANT_MAINBeforeCancel
    BeforePost = qryANT_MAINBeforePost
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 628
    Top = 12
    ParamValues = (
      'PRM_ANT_MAIN_ID=0')
  end
  object dtsANT_MAIN: TIB_DataSource
    Dataset = qryANT_MAIN
    OnStateChanged = dtsANT_MAINStateChanged
    Left = 696
    Top = 8
  end
  object trnANTREPO: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    Left = 532
    Top = 32
  end
  object qryANT_DETAIL: TIB_Query
    ColumnAttributes.Strings = (
      'YANICI=BOOLEAN=1,0')
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    FieldsDisplayLabel.Strings = (
      'ANT_BEYAN_NO=Antrepo Bey. No'
      'ANT_BEYAN_TAR=Antrepo Bey. Tar'
      'KONSIMENTO=Kon'#351'imento No'
      'CARI_AD=Cari Ad'#305
      'CARI_KOD=Cari Kodu'
      'KAP_ADET=Kap Adet'
      'KILO=Kilo'
      'ESYA=E'#351'yan'#305'n Tan'#305'm'#305
      'YANICI=Yan'#305'c'#305
      'ARDIYE_FIY=Ardiye Fiyat'#305
      'ARD_DOVKOD=Para Birimi'
      'HAMM_DOVKOD=Para Birimi'
      'HAMMALIYE=Hammaliye')
    FieldsGridLabel.Strings = (
      'ANT_BEYAN_NO=Antrepo Bey. No'
      'KONSIMENTO=Kon'#351'imento No'
      'CARI_KOD=Cari Kodu'
      'CARI_AD=Cari Ad'#305
      'KAP_ADET=Kap Adet'
      'KILO=Kilo'
      'ESYA=E'#351'yan'#305'n Tan'#305'm'#305
      'YANICI=Yan'#305'c'#305
      'ARDIYE_FIY=Ardiye'
      'ARD_DOVKOD=Para Birimi'
      'HAMM_DOVKOD=Para Birimi'
      'HAMMALIYE=Hammaliye'
      'ANT_BEYAN_TAR=Antrepo Bey. Tar')
    FieldsDisplayWidth.Strings = (
      'CARI_KOD=64'
      'KONSIMENTO=86'
      'KAP_ADET=51'
      'KILO=73'
      'YANICI=36'
      'ARD_DOVKOD=54'
      'HAMM_DOVKOD=54'
      'ARDIYE_FIY=60'
      'HAMMALIYE=64'
      'CARI_AD=180'
      'ESYA=179')
    FieldsIndex.Strings = (
      'ANT_DETAIL_ID'
      'ANT_MAIN_ID'
      'ANT_BEYAN_NO'
      'ANT_BEYAN_TAR'
      'KONSIMENTO'
      'CARI_KOD'
      'CARI_AD'
      'KAP_ADET'
      'KILO'
      'ESYA'
      'YANICI'
      'ARDIYE_FIY'
      'ARD_DOVKOD'
      'HAMMALIYE'
      'HAMM_DOVKOD'
      'KALAN_KAP'
      'KALAN_KILO')
    FieldsVisible.Strings = (
      'ANT_DETAIL_ID=FALSE'
      'ANT_MAIN_ID=FALSE'
      'ANT_BEYAN_NO=FALSE'
      'ANT_BEYAN_TAR=FALSE'
      'KALAN_KAP=FALSE'
      'KALAN_KILO=FALSE'
      'ARD_DOVKOD=FALSE'
      'HAMM_DOVKOD=FALSE'
      'KAPANDI=FALSE'
      'CARI_KOD=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnANTREPO
    SQL.Strings = (
      'SELECT ANT_DETAIL_ID'
      '     , ANT_MAIN_ID'
      '     , ANT_BEYAN_NO'
      '     , ANT_BEYAN_TAR'
      '     , KONSIMENTO'
      '     , CARI_AD'
      '     , CARI_KOD'
      '     , KAP_ADET'
      '     , KILO'
      '     , ESYA'
      '     , YANICI'
      '     , ARDIYE_FIY'
      '     , ARD_DOVKOD'
      '     , HAMMALIYE'
      '     , HAMM_DOVKOD'
      '     , KALAN_KAP'
      '     , KALAN_KILO'
      'FROM ANT_DETAIL'
      'WHERE ANT_DETAIL.ANT_MAIN_ID=:PRM_ANT_MAIN_ID')
    ColorScheme = False
    DefaultValues.Strings = (
      'ANT_MAIN_ID=0'
      'DEF_SIRA_NO=0'
      'GIRIS_ANT_DETAIL_ID=0'
      'CIK_KILO=0'
      'FATURA_ID=0'
      'GUM_KOM_KOD=0'
      'ARD_DOVKOD=USD'
      'HAMM_DOVKOD=USD')
    KeyLinks.Strings = (
      'ANT_DETAIL.ANT_DETAIL_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryANT_DETAILAfterInsert
    BeforeInsert = qryANT_DETAILBeforeInsert
    BeforePost = qryANT_DETAILBeforePost
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 632
    Top = 88
    ParamValues = (
      'PRM_ANT_MAIN_ID=0')
  end
  object dtsANT_DETAIL: TIB_DataSource
    Dataset = qryANT_DETAIL
    OnStateChanged = dtsANT_DETAILStateChanged
    Left = 700
    Top = 104
  end
end
