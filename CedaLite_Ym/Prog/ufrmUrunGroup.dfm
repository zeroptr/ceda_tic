object frmUrunGroup: TfrmUrunGroup
  Left = 95
  Top = 121
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #220'r'#252'n Grup'
  ClientHeight = 477
  ClientWidth = 801
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 64
    Top = 176
    Width = 58
    Height = 13
    Caption = 'T'#252'm '#220'r'#252'nler'
  end
  object Label1: TLabel
    Left = 496
    Top = 176
    Width = 93
    Height = 13
    Caption = 'Gruba Dahil '#220'r'#252'nler'
  end
  object Panel1: TPanel
    Left = 0
    Top = 447
    Width = 801
    Height = 30
    Align = alBottom
    TabOrder = 5
    object btnCikis: TBitBtn
      Left = 737
      Top = 2
      Width = 61
      Height = 26
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
    object btnAra: TBitBtn
      Left = 671
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
    object btnYeni: TBitBtn
      Left = 5
      Top = 3
      Width = 62
      Height = 25
      Caption = 'Yeni (INS)'
      TabOrder = 2
      OnClick = btnYeniClick
      NumGlyphs = 2
    end
    object btnKaydet: TButton
      Left = 69
      Top = 3
      Width = 91
      Height = 25
      Caption = 'Kaydet (CTRL+S)'
      TabOrder = 3
      OnClick = btnKaydetClick
    end
    object btnIPTAL: TButton
      Left = 163
      Top = 3
      Width = 80
      Height = 25
      Caption = #304'ptal(CTRL+P)'
      TabOrder = 4
      OnClick = btnIPTALClick
    end
    object btnSil: TButton
      Left = 244
      Top = 3
      Width = 87
      Height = 25
      Caption = 'Sil (CTRL+DEL)'
      TabOrder = 5
      OnClick = btnSilClick
    end
  end
  object IB_Edit1: TIB_Edit
    Left = 90
    Top = 9
    Width = 121
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'URUN_GRUP_KOD'
    DataSource = dtsUrun_Grup
    TabOrder = 0
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    OnKeyPress = IB_Edit1KeyPress
  end
  object IB_Edit2: TIB_Edit
    Left = 90
    Top = 33
    Width = 335
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'UGADI'
    DataSource = dtsUrun_Grup
    TabOrder = 1
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    OnKeyPress = IB_Edit1KeyPress
  end
  object IB_Memo1: TIB_Memo
    Left = 89
    Top = 106
    Width = 336
    Height = 53
    AutoLabel.Kind = albLeft
    AutoLabel.Margin = 0
    DataField = 'UGACK'
    DataSource = dtsUrun_Grup
    TabOrder = 4
    OnEnter = IB_Memo1Enter
    OnExit = IB_Memo1Exit
    AutoSize = False
  end
  object IB_Edit3: TIB_Edit
    Left = 90
    Top = 58
    Width = 31
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'BIRIMORAN'
    DataSource = dtsUrun_Grup
    TabOrder = 2
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object cboDOVKOD: TIB_ComboBox
    Left = 89
    Top = 82
    Width = 89
    Height = 21
    AutoLabel.Kind = albLeft
    AutoLabel.Caption = 'D'#246'viz Kodu'
    DataField = 'DOVKOD'
    DataSource = dtsUrun_Grup
    TabOrder = 3
    Style = csDropDownList
    ItemHeight = 13
  end
  object grdCGROUP: TIB_Grid
    Left = 440
    Top = 2
    Width = 353
    Height = 151
    CustomGlyphsSupplied = []
    DataSource = dtsUrun_Grup
    BorderStyle = bsNone
    TabOrder = 6
    RowSelect = True
    Ctl3DShallow = True
    TabMovesOut = True
  end
  object BitBtn1: TBitBtn
    Left = 144
    Top = 168
    Width = 169
    Height = 25
    Caption = #220'r'#252'n'#252' Aktif Gruba Dahil Et'
    TabOrder = 7
    OnClick = BitBtn1Click
  end
  object IB_Grid1: TIB_Grid
    Left = 12
    Top = 200
    Width = 373
    Height = 233
    CustomGlyphsSupplied = []
    DataSource = IB_DataSource1
    BorderStyle = bsNone
    TabOrder = 8
    RowSelect = True
    Ctl3DShallow = True
    TabMovesOut = True
  end
  object BitBtn2: TBitBtn
    Left = 592
    Top = 168
    Width = 161
    Height = 25
    Caption = 'Gruptan '#199#305'kart'
    TabOrder = 9
    OnClick = BitBtn2Click
  end
  object IB_Grid2: TIB_Grid
    Left = 392
    Top = 200
    Width = 405
    Height = 233
    CustomGlyphsSupplied = []
    DataSource = IB_DataSource2
    BorderStyle = bsNone
    TabOrder = 10
    RowSelect = True
    Ctl3DShallow = True
    TabMovesOut = True
  end
  object qryUrun_Grup: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\Transport.FDB'
    FieldsDisplayLabel.Strings = (
      'UGKOD=Grup Kodu'
      'UGADI=Grup Ad'#305
      'UGACK= Ac'#305'klama'
      'BIRIMORAN=Birim Fiyat Oran'#305
      'DOVKOD=D'#246'viz Kodu'
      'URUN_GRUP_KOD=Grup Kodu')
    FieldsVisible.Strings = (
      'URUN_GRUP_ID=FALSE'
      'URUN_GRUP_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT * FROM URUN_GRUP')
    ColorScheme = False
    KeyLinks.Strings = (
      'URUN_GRUP.URUN_GRUP_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryUrun_GrupAfterInsert
    AfterScroll = qryUrun_GrupAfterScroll
    BeforeDelete = qryUrun_GrupBeforeDelete
    BeforePost = qryUrun_GrupBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 276
    Top = 20
  end
  object dtsUrun_Grup: TIB_DataSource
    AutoInsert = False
    Dataset = qryUrun_Grup
    OnStateChanged = dtsUrun_GrupStateChanged
    Left = 368
    Top = 21
  end
  object IB_Query1: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\Transport.FDB'
    FieldsDisplayLabel.Strings = (
      'CGKOD=KOD'
      'CGADI=Grup Ad'#305
      'CG_KOD=Grup Kodu'
      'CGACK=Ac'#305'klama'
      'TIP=Tip'
      'CARI_GRUP_KOD=Grup Kodu'
      'CARI_KOD=Cari Kodu'
      'CARI_AD=Cari Ad'#305
      'YETKISI=Yetkilisi'
      'URUN_KOD='#220'r'#252'n Kod'
      'URUN_AD='#220'r'#252'n Ad'#305
      'URUN_AD_YD='#220'r'#252'n Ad'#305'('#304'ng.)')
    FieldsDisplayWidth.Strings = (
      'CGKOD=39'
      'CGADI=121'
      'CG_KOD=65'
      'TIP=24'
      'CARI_GRUP_KOD=74'
      'CARI_KOD=77'
      'CARI_AD=114'
      'YETKISI=104'
      'URUN_KOD=88'
      'URUN_AD=141'
      'URUN_AD_YD=111')
    FieldsVisible.Strings = (
      'CARI_GRUP_ID=FALSE'
      'CARI_GRUP_SID=FALSE'
      'CGACK=FALSE'
      'TIP=TRUE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT URUN_KOD'
      '     , URUN_AD'
      '     , URUN_AD_YD'
      'FROM URUN')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 88
    Top = 249
  end
  object IB_DataSource1: TIB_DataSource
    Dataset = IB_Query1
    Left = 186
    Top = 252
  end
  object IB_Query2: TIB_Query
    ColumnAttributes.Strings = (
      'VARSAY=BOOLEAN=1,0')
    DatabaseName = 'C:\CedaLite\Trans_Db\Transport.FDB'
    FieldsDisplayLabel.Strings = (
      'CGKOD=KOD'
      'CGADI=Grup Ad'#305
      'CG_KOD=Grup Kodu'
      'CGACK=Ac'#305'klama'
      'TIP=Tip'
      'CARI_GRUP_KOD=Grup Kodu'
      'CARI_KOD=Cari Kodu'
      'CARI_AD=Cari Ad'#305
      'YETKISI=Yetkilisi'
      'VARSAY=VarSay'
      'URUN_KOD='#220'r'#252'n Kodu'
      'URUN_AD='#220'r'#252'n Ad'#305
      'URUN_AD_YD='#220'r'#252'n Ad'#305'('#304'ng.)')
    FieldsDisplayWidth.Strings = (
      'CGKOD=39'
      'CGADI=121'
      'CG_KOD=65'
      'TIP=24'
      'CARI_GRUP_KOD=74'
      'CARI_KOD=77'
      'CARI_AD=107'
      'YETKISI=111'
      'VARSAY=41'
      'URUN_KOD=111'
      'URUN_AD=121'
      'URUN_AD_YD=93')
    FieldsVisible.Strings = (
      'CARI_GRUP_ID=FALSE'
      'CARI_GRUP_SID=FALSE'
      'CGACK=FALSE'
      'TIP=TRUE'
      'VARSAY=TRUE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT URUN.URUN_KOD'
      '     , URUN.URUN_AD'
      '     , URUN.URUN_AD_YD'
      '     ,Urun_grup_uye.VARSAY'
      'FROM URUN'
      
        'left outer join urun_grup_uye on (urun_grup_uye.urun_kod=Urun.Ur' +
        'un_kod)'
      'Where Urun_grup_uye.Urun_grup_kod=:Grup_kod ')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 608
    Top = 241
    ParamValues = (
      'GRUP_KOD=')
  end
  object IB_DataSource2: TIB_DataSource
    Dataset = IB_Query2
    Left = 706
    Top = 244
  end
end
