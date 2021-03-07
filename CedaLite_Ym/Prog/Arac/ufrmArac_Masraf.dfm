object frmArac_Masraf: TfrmArac_Masraf
  Left = 369
  Top = 180
  ActiveControl = IB_Edit2
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Ara'#231' Masraf Giri'#351'i'
  ClientHeight = 366
  ClientWidth = 534
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
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
  object IB_Text1: TIB_Text
    Left = 342
    Top = 20
    Width = 181
    Height = 14
    DataField = 'ARAC_PLAKA'
    DataSource = dtsArac_Masraf
    Color = clMoneyGreen
    ParentColor = False
  end
  object IB_Text3: TIB_Text
    Left = 8
    Top = 100
    Width = 85
    Height = 13
    DataField = 'DOVKOD'
    DataSource = dtsArac_Masraf
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 84
    Width = 49
    Height = 13
    Caption = 'Para Birimi'
  end
  object Panel1: TPanel
    Left = 0
    Top = 336
    Width = 534
    Height = 30
    Align = alBottom
    TabOrder = 9
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
    object btnAra: TBitBtn
      Left = 404
      Top = 3
      Width = 62
      Height = 25
      Caption = '&Ara'
      TabOrder = 4
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
      Left = 469
      Top = 3
      Width = 61
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 5
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
    object btnKaydet: TButton
      Left = 69
      Top = 3
      Width = 91
      Height = 25
      Caption = 'Kaydet (CTRL+S)'
      TabOrder = 1
      OnClick = btnKaydetClick
    end
    object btnIPTAL: TButton
      Left = 163
      Top = 3
      Width = 80
      Height = 25
      Caption = #304'ptal(CTRL+P)'
      TabOrder = 2
      OnClick = btnIPTALClick
    end
    object btnSil: TButton
      Left = 244
      Top = 3
      Width = 87
      Height = 25
      Caption = 'Sil (CTRL+DEL)'
      TabOrder = 3
      OnClick = btnSilClick
    end
    object Btn_Onceki: TButton
      Left = 334
      Top = 3
      Width = 33
      Height = 25
      Caption = '<'
      TabOrder = 6
      OnClick = Btn_OncekiClick
    end
    object Btn_Sonraki: TButton
      Left = 369
      Top = 3
      Width = 33
      Height = 25
      Caption = '>'
      TabOrder = 7
      OnClick = Btn_SonrakiClick
    end
  end
  object IB_Edit1: TIB_Edit
    Left = 4
    Top = 16
    Width = 65
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'ARACHAR_ID'
    DataSource = dtsArac_Masraf
    Enabled = False
    ReadOnly = True
    TabOrder = 0
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Date1: TIB_Date
    Left = 72
    Top = 16
    Width = 85
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'TARIH'
    DataSource = dtsArac_Masraf
    TabOrder = 1
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    IncCellHeight = 1
    IncCellWidth = 2
    DrawYearArrow = False
  end
  object IB_Date2: TIB_Date
    Left = 160
    Top = 16
    Width = 85
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'DOV_BAZ_TAR'
    DataSource = dtsArac_Masraf
    TabOrder = 2
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    IncCellHeight = 1
    IncCellWidth = 2
    DrawYearArrow = False
  end
  object IB_Edit2: TIB_Edit
    Left = 248
    Top = 16
    Width = 89
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'ARAC_KOD'
    DataSource = dtsArac_Masraf
    TabOrder = 3
    OnEnter = IB_Edit2Enter
    OnExit = IB_Edit2Exit
    OnKeyDown = IB_Edit2KeyDown
    ButtonStyle = ebsEllipsis
    OnButtonClick = IB_Edit2ButtonClick
  end
  object IB_Edit4: TIB_Edit
    Left = 4
    Top = 136
    Width = 521
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'ACIKLAMA'
    DataSource = dtsArac_Masraf
    TabOrder = 7
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit4Exit
  end
  object edt_tutar: TIB_Currency
    Left = 192
    Top = 96
    Width = 155
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'TUTAR'
    DataSource = dtsArac_Masraf
    TabOrder = 5
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    AlwaysShowButton = True
  end
  object edt_Dovkur: TIB_Currency
    Left = 100
    Top = 96
    Width = 87
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'DOVKUR'
    DataSource = dtsArac_Masraf
    TabOrder = 4
    OnEnter = IB_Edit1Enter
    OnExit = edt_DovkurExit
    AlwaysShowButton = True
  end
  object IB_Currency3: TIB_Currency
    Left = 352
    Top = 96
    Width = 169
    Height = 21
    TabStop = False
    DataField = 'TUTAR_VPB'
    DataSource = dtsArac_Masraf
    Color = clScrollBar
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    AlwaysShowButton = True
  end
  object rgYAZICI: TRadioGroup
    Left = 6
    Top = 296
    Width = 420
    Height = 35
    Caption = 'Yazd'#305'rma'
    Columns = 3
    ItemIndex = 2
    Items.Strings = (
      'Yazd'#305'r'
      #214'n '#304'zleme'
      'Sadece Kay'#305't')
    TabOrder = 10
    Visible = False
  end
  object btnCikti: TButton
    Left = 427
    Top = 301
    Width = 97
    Height = 30
    Caption = 'Yaz'#305'c'#305' '#199#305'kt'#305's'#305
    TabOrder = 11
    TabStop = False
    Visible = False
    OnClick = btnCiktiClick
  end
  object grpRapKod: TGroupBox
    Left = 6
    Top = 234
    Width = 517
    Height = 61
    TabOrder = 8
    object IB_Edit8: TIB_Edit
      Left = 10
      Top = 26
      Width = 83
      Height = 21
      AutoLabel.Kind = albTop
      AutoLabel.Caption = #304#351'lem Merkezi'
      DataField = 'MASRAF_MERK'
      DataSource = dtsArac_Masraf
      TabOrder = 0
      OnExit = IB_Edit8Exit
      OnKeyUp = IB_Edit8KeyUp
      ButtonStyle = ebsEllipsis
      OnButtonClick = IB_Edit8ButtonClick
    end
    object IB_Edit10: TIB_Edit
      Left = 112
      Top = 26
      Width = 85
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'KOD1'
      DataSource = dtsArac_Masraf
      TabOrder = 1
      OnExit = IB_Edit10Exit
      OnKeyUp = IB_Edit10KeyUp
      ButtonStyle = ebsEllipsis
      OnButtonClick = IB_Edit10ButtonClick
    end
    object IB_Edit11: TIB_Edit
      Left = 218
      Top = 26
      Width = 81
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'KOD2'
      DataSource = dtsArac_Masraf
      TabOrder = 2
      OnExit = IB_Edit11Exit
      OnKeyUp = IB_Edit11KeyUp
      ButtonStyle = ebsEllipsis
      OnButtonClick = IB_Edit11ButtonClick
    end
    object IB_Edit12: TIB_Edit
      Left = 319
      Top = 26
      Width = 85
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'KOD3'
      DataSource = dtsArac_Masraf
      TabOrder = 3
      OnExit = IB_Edit12Exit
      OnKeyUp = IB_Edit12KeyUp
      ButtonStyle = ebsEllipsis
      OnButtonClick = IB_Edit12ButtonClick
    end
    object IB_Edit13: TIB_Edit
      Left = 422
      Top = 26
      Width = 85
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'KOD4'
      DataSource = dtsArac_Masraf
      TabOrder = 4
      OnExit = IB_Edit13Exit
      OnKeyUp = IB_Edit13KeyUp
      ButtonStyle = ebsEllipsis
      OnButtonClick = IB_Edit13ButtonClick
    end
  end
  object qryArac_Masraf: TIB_Query
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
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
      'ARACHAR_ID=Ara'#231' Har No'
      'DOVKOD=D'#246'viz Kodu'
      'ARAC_KOD=Ara'#231' Kodu'
      'TUTAR=Tutar'
      'TUTAR_VPB=Tutar  Vpb')
    FieldsVisible.Strings = (
      'KASAHAR_ID=FALSE'
      'KASAHAR_SID=FALSE'
      'BELGE_TUR=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnArac_Masraf
    SQL.Strings = (
      'SELECT ARACHAR_ID'
      '     , ARACHAR_SID'
      '     , ARAC_KOD'
      
        '     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=ARACHAR.ARAC_K' +
        'OD) AS ARAC_PLAKA'
      '     , TARIH'
      '     , BA'
      '     , DOVKOD'
      '     , DOVKUR'
      '     , TUTAR'
      '     , TUTAR_VPB'
      '     , ACIKLAMA'
      '     , BELGE_TUR'
      '     , BELGE_ID'
      '     , BELGE_SID'
      '     , SIRA_NO'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , DOV_BAZ_TAR'
      'FROM ARACHAR'
      
        'WHERE ARACHAR_ID=:PRM_ARACHAR_ID AND ARACHAR_SID=:PRM_ARACHAR_SI' +
        'D')
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
      'ARACHAR.ARACHAR_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryArac_MasrafAfterInsert
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 196
    Top = 108
    ParamValues = (
      'PRM_ARACHAR_ID=0')
  end
  object dtsArac_Masraf: TIB_DataSource
    AutoInsert = False
    Dataset = qryArac_Masraf
    OnDataChange = dtsArac_MasrafDataChange
    OnStateChanged = dtsArac_MasrafStateChanged
    Left = 168
    Top = 156
  end
  object trnArac_Masraf: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 260
    Top = 116
  end
end
