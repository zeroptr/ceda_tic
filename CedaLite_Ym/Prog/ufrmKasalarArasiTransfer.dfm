object frmKasalarArasiTransfer: TfrmKasalarArasiTransfer
  Left = 317
  Top = 253
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Kasalar Aras'#305' Transfer Fi'#351'i'
  ClientHeight = 397
  ClientWidth = 506
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 346
    Top = 42
    Width = 49
    Height = 13
    Caption = 'Para Birimi'
  end
  object Label2: TLabel
    Left = 352
    Top = 122
    Width = 49
    Height = 13
    Caption = 'Para Birimi'
  end
  object lbl_Borc_Kasa_Dov_Kod: TLabel
    Left = 354
    Top = 138
    Width = 9
    Height = 13
    Caption = '---'
    Color = clMoneyGreen
    ParentColor = False
  end
  object Label5: TLabel
    Left = 6
    Top = 120
    Width = 57
    Height = 13
    Caption = 'Bor'#231'lu Kasa'
  end
  object IB_Text1: TIB_Text
    Left = 345
    Top = 56
    Width = 65
    Height = 19
    DataField = 'DOVKOD'
    DataSource = dtsKASAHAR
    Color = clMoneyGreen
    ParentColor = False
  end
  object IB_Text2: TIB_Text
    Left = 130
    Top = 57
    Width = 201
    Height = 17
    DataField = 'KASA_AD'
    DataSource = dtsKASAHAR
    Color = clMoneyGreen
    ParentColor = False
  end
  object Label3: TLabel
    Left = 130
    Top = 44
    Width = 42
    Height = 13
    Caption = 'Kasa Ad'#305
  end
  object Label4: TLabel
    Left = 129
    Top = 121
    Width = 42
    Height = 13
    Caption = 'Kasa Ad'#305
  end
  object Label6: TLabel
    Left = 130
    Top = 135
    Width = 32
    Height = 13
    Caption = 'Label6'
    Color = clMoneyGreen
    ParentColor = False
  end
  object IB_Edit1: TIB_Edit
    Left = 4
    Top = 16
    Width = 63
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'KASAHAR_ID'
    DataSource = dtsKASAHAR
    Enabled = False
    ReadOnly = True
    TabOrder = 0
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Date1: TIB_Date
    Left = 72
    Top = 16
    Width = 103
    Height = 21
    AutoLabel.Kind = albTop
    AutoLabel.Caption = 'Tarih'
    DataField = 'TARIH'
    DataSource = dtsKASAHAR
    TabOrder = 1
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    IncCellHeight = 1
    IncCellWidth = 2
    DrawYearArrow = False
  end
  object IB_Date4: TIB_Date
    Left = 176
    Top = 15
    Width = 84
    Height = 21
    AutoLabel.Kind = albTop
    AutoLabel.Caption = 'D'#246'viz Baz Tarihi'
    DataField = 'DOV_BAZ_TAR'
    DataSource = dtsKASAHAR
    TabOrder = 2
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    IncCellHeight = 1
    IncCellWidth = 2
    DrawYearArrow = False
  end
  object edt_Dovkur: TIB_Currency
    Left = 4
    Top = 93
    Width = 87
    Height = 21
    AutoLabel.Kind = albTop
    AutoLabel.Caption = 'D'#246'viz Kuru'
    DataField = 'DOVKUR'
    DataSource = dtsKASAHAR
    TabOrder = 5
    OnEnter = IB_Edit1Enter
    OnExit = edt_DovkurExit
    AlwaysShowButton = True
  end
  object edt_tutar_alacak: TIB_Currency
    Left = 93
    Top = 92
    Width = 157
    Height = 21
    AutoLabel.Kind = albTop
    AutoLabel.Caption = 'Alacakl'#305' Kasa Tutar'#305
    DataField = 'TUTAR'
    DataSource = dtsKASAHAR
    TabOrder = 6
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    AlwaysShowButton = True
  end
  object edt_tutar_borc: TIB_Currency
    Left = 94
    Top = 171
    Width = 155
    Height = 21
    AutoLabel.Kind = albTop
    AutoLabel.Caption = 'Bor'#231'lu Kasa Tutar'#305
    TabOrder = 10
    OnEnter = edt_tutar_borcEnter
    OnExit = edt_tutar_borcExit
    AlwaysShowButton = True
    OnChange = edt_Dovkur1Change
  end
  object IB_Edit3: TIB_Edit
    Left = 4
    Top = 208
    Width = 502
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'ACIKLAMA'
    DataSource = dtsKASAHAR
    TabOrder = 12
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit3Exit
  end
  object txt_Borclu_Kasa: TEdit
    Left = 4
    Top = 134
    Width = 105
    Height = 21
    TabOrder = 7
    OnEnter = txt_Borclu_KasaEnter
    OnExit = txt_Borclu_KasaExit
    OnKeyDown = txt_Borclu_KasaKeyDown
    OnKeyPress = txt_Alacakli_KasaKeyPress
  end
  object btnALACAKLI: TButton
    Left = 109
    Top = 55
    Width = 19
    Height = 21
    Caption = '...'
    TabOrder = 4
    OnClick = btnALACAKLIClick
  end
  object btnBORCLU: TButton
    Left = 110
    Top = 134
    Width = 18
    Height = 21
    Caption = '...'
    TabOrder = 8
    OnClick = btnBORCLUClick
  end
  object txt_Alacakli_Kasa: TIB_Edit
    Left = 4
    Top = 55
    Width = 105
    Height = 21
    AutoLabel.Kind = albTop
    AutoLabel.Caption = 'Alacakl'#305' Kasa'
    DataField = 'KASA_KOD'
    DataSource = dtsKASAHAR
    TabOrder = 3
    OnEnter = txt_Alacakli_KasaEnter
    OnExit = txt_Alacakli_KasaExit
    OnKeyDown = txt_Alacakli_KasaKeyDown
    OnKeyPress = txt_Alacakli_KasaKeyPress
  end
  object Panel1: TPanel
    Left = 0
    Top = 367
    Width = 506
    Height = 30
    Align = alBottom
    TabOrder = 15
    object btnYeni: TBitBtn
      Left = 5
      Top = 3
      Width = 64
      Height = 25
      Caption = 'Yeni (INS)'
      TabOrder = 0
      OnClick = btnYeniClick
      NumGlyphs = 2
    end
    object btnAra: TBitBtn
      Left = 352
      Top = 3
      Width = 70
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
      Left = 421
      Top = 3
      Width = 79
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
      Left = 68
      Top = 3
      Width = 91
      Height = 25
      Caption = 'Kaydet (CTRL+S)'
      TabOrder = 1
      OnClick = btnKaydetClick
    end
    object btnIPTAL: TButton
      Left = 158
      Top = 3
      Width = 80
      Height = 25
      Caption = #304'ptal(CTRL+P)'
      TabOrder = 2
      OnClick = btnIPTALClick
    end
    object btnSil: TButton
      Left = 237
      Top = 3
      Width = 87
      Height = 25
      Caption = 'Sil (CTRL+DEL)'
      Enabled = False
      TabOrder = 3
      OnClick = btnSilClick
    end
  end
  object edt_Dovkur1: TIB_Currency
    Left = 4
    Top = 171
    Width = 87
    Height = 21
    AutoLabel.Kind = albTop
    AutoLabel.Caption = 'D'#246'viz Kuru'
    TabOrder = 9
    OnEnter = edt_Dovkur1Enter
    OnExit = edt_Dovkur1Exit
    AlwaysShowButton = True
    OnChange = edt_Dovkur1Change
  end
  object edt_tutar_vpb: TIB_Currency
    Left = 252
    Top = 170
    Width = 157
    Height = 21
    AutoLabel.Kind = albTop
    AutoLabel.Caption = 'Tutar VPB'
    Enabled = False
    TabOrder = 11
    AlwaysShowButton = True
  end
  object IB_Edit6: TIB_Edit
    Left = 4
    Top = 243
    Width = 502
    Height = 21
    AutoLabel.Kind = albTop
    AutoLabel.Caption = 'Yevmiye A'#231#305'klamas'#305
    DataField = 'YEVMIYE_ACK'
    DataSource = dtsKASAHAR
    Visible = False
    TabOrder = 13
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object rgYAZICI: TRadioGroup
    Left = 4
    Top = 329
    Width = 377
    Height = 35
    Caption = 'Yazd'#305'rma'
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'Yazd'#305'r'
      #214'n '#304'zleme'
      'Sadece Kay'#305't')
    TabOrder = 16
  end
  object edt_tutar_vpb1: TIB_Currency
    Left = 254
    Top = 92
    Width = 121
    Height = 21
    AutoLabel.Kind = albTop
    AutoLabel.Caption = 'Tutar VPB'
    DataField = 'TUTAR_VPB'
    DataSource = dtsKASAHAR
    Enabled = False
    TabOrder = 17
    AlwaysShowButton = True
  end
  object btnCikti: TButton
    Left = 384
    Top = 335
    Width = 116
    Height = 28
    Caption = 'Yaz'#305'c'#305' '#199#305'kt'#305's'#305
    TabOrder = 18
    TabStop = False
    OnClick = btnCiktiClick
  end
  object grpRapKod: TGroupBox
    Left = 4
    Top = 270
    Width = 499
    Height = 55
    TabOrder = 14
    object IB_Edit8: TIB_Edit
      Left = 10
      Top = 22
      Width = 83
      Height = 21
      AutoLabel.Kind = albTop
      AutoLabel.Caption = #304#351'lem Merkezi'
      DataField = 'MASRAF_MERK'
      DataSource = dtsKASAHAR
      TabOrder = 0
      OnExit = IB_Edit8Exit
      OnKeyUp = IB_Edit8KeyUp
      ButtonStyle = ebsEllipsis
      OnButtonClick = IB_Edit8ButtonClick
    end
    object IB_Edit10: TIB_Edit
      Left = 108
      Top = 22
      Width = 85
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'KOD1'
      DataSource = dtsKASAHAR
      TabOrder = 1
      OnExit = IB_Edit10Exit
      OnKeyUp = IB_Edit10KeyUp
      ButtonStyle = ebsEllipsis
      OnButtonClick = IB_Edit10ButtonClick
    end
    object IB_Edit11: TIB_Edit
      Left = 208
      Top = 22
      Width = 81
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'KOD2'
      DataSource = dtsKASAHAR
      TabOrder = 2
      OnExit = IB_Edit11Exit
      OnKeyUp = IB_Edit11KeyUp
      ButtonStyle = ebsEllipsis
      OnButtonClick = IB_Edit11ButtonClick
    end
    object IB_Edit12: TIB_Edit
      Left = 303
      Top = 22
      Width = 85
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'KOD3'
      DataSource = dtsKASAHAR
      TabOrder = 3
      OnExit = IB_Edit12Exit
      OnKeyUp = IB_Edit12KeyUp
      ButtonStyle = ebsEllipsis
      OnButtonClick = IB_Edit12ButtonClick
    end
    object IB_Edit13: TIB_Edit
      Left = 402
      Top = 21
      Width = 85
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'KOD4'
      DataSource = dtsKASAHAR
      TabOrder = 4
      OnExit = IB_Edit13Exit
      OnKeyUp = IB_Edit13KeyUp
      ButtonStyle = ebsEllipsis
      OnButtonClick = IB_Edit13ButtonClick
    end
  end
  object qryKASAHAR: TIB_Query
    DatabaseName = 'C:\Musteriler\Kasali\Transport.FDB'
    FieldsDisplayLabel.Strings = (
      'KASAHAR_ID=FIS NO')
    FieldsVisible.Strings = (
      'BELGE_ID=TRUE'
      'BELGE_SID=TRUE'
      'KASAHAR_SID=TRUE'
      'KASAHAR_ID=TRUE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnTRANSFER
    SQL.Strings = (
      'SELECT KASAHAR_ID'
      '     , KASAHAR_SID'
      '     , KASA_KOD'
      
        '     , (SELECT KASA.ACIKLAMA FROM KASA WHERE KASA.KASA_KOD = KAS' +
        'AHAR.KASA_KOD)AS KASA_AD '
      '     , TARIH'
      '     , DOV_BAZ_TAR'
      '     , BELGE_TUR'
      '     , BELGE_ID'
      '     , BELGE_SID'
      '     , TIP'
      '     , ACIKLAMA'
      '     , KASADEGER'
      '     , ISLEM_TIP'
      '     , MC'
      '     , KARSIKOD'
      '     , SIRA_NO'
      '     , DOVKOD'
      '     , DOVKUR'
      '     , TUTAR'
      '     , TUTAR_VPB'
      '     , OLCUBIRIM'
      '     , MIKTAR'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2 '
      '     , KOD3'
      '     , KOD4'
      '     , YEVMIYE_ACK'
      'FROM KASAHAR '
      
        'WHERE BELGE_TUR=:PRM_BELGE_TUR AND BELGE_ID=:PRM_BELGE_ID AND BE' +
        'LGE_SID=:PRM_BELGE_SID AND ISLEM_TIP=6 '
      'ORDER BY KASAHAR.SIRA_NO')
    ColorScheme = False
    GeneratorLinks.Strings = (
      'KASAHAR.KASAHAR_ID=GEN_KASAHAR')
    KeyLinks.Strings = (
      'KASAHAR.KASAHAR_ID'
      'KASAHAR.KASAHAR_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 432
    Top = 54
    ParamValues = (
      'PRM_BELGE_TUR=0')
  end
  object dtsKASAHAR: TIB_DataSource
    Dataset = qryKASAHAR
    OnDataChange = dtsKASAHARDataChange
    OnStateChanged = dtsKASAHARStateChanged
    Left = 433
    Top = 106
  end
  object trnTRANSFER: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 432
    Top = 2
  end
end
