object frmKASA_CARI: TfrmKASA_CARI
  Left = 369
  Top = 180
  ActiveControl = IB_Edit2
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cari Tahsil / Tediye'
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
    DataField = 'KASA_AD'
    DataSource = dtsKASAHAR
    Color = clMoneyGreen
    ParentColor = False
  end
  object IB_Text2: TIB_Text
    Left = 226
    Top = 56
    Width = 299
    Height = 14
    DataField = 'KARSI_AD'
    DataSource = dtsKASAHAR
    Color = clMoneyGreen
    ParentColor = False
  end
  object IB_Text3: TIB_Text
    Left = 8
    Top = 100
    Width = 85
    Height = 13
    DataField = 'DOVKOD'
    DataSource = dtsKASAHAR
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
    TabOrder = 17
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
    Width = 85
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'TARIH'
    DataSource = dtsKASAHAR
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
    DataSource = dtsKASAHAR
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
    DataField = 'KASA_KOD'
    DataSource = dtsKASAHAR
    TabOrder = 3
    OnEnter = IB_Edit2Enter
    OnExit = IB_Edit2Exit
    OnKeyDown = IB_Edit2KeyDown
    OnKeyPress = IB_Edit2KeyPress
    ButtonStyle = ebsEllipsis
    OnButtonClick = IB_Edit2ButtonClick
  end
  object IB_RadioGroup1: TIB_RadioGroup
    Left = 4
    Top = 53
    Width = 125
    Height = 20
    DataField = 'TIP'
    DataSource = dtsKASAHAR
    TabOrder = 4
    Columns = 2
    Items.Strings = (
      'Giri'#351
      #199#305'k'#305#351)
    Values.Strings = (
      'G'
      'C')
  end
  object IB_Edit3: TIB_Edit
    Left = 132
    Top = 52
    Width = 89
    Height = 21
    AutoLabel.Kind = albTop
    AutoLabel.Caption = 'Cari Kod'
    DataField = 'KARSIKOD'
    DataSource = dtsKASAHAR
    TabOrder = 5
    OnEnter = IB_Edit3Enter
    OnExit = IB_Edit3Exit
    OnKeyDown = IB_Edit3KeyDown
    OnKeyPress = IB_Edit2KeyPress
    ButtonStyle = ebsEllipsis
    OnButtonClick = IB_Edit3ButtonClick
  end
  object IB_Edit4: TIB_Edit
    Left = 268
    Top = 69
    Width = 521
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'ACIKLAMA'
    DataSource = dtsKASAHAR
    Visible = False
    TabOrder = 10
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
    DataSource = dtsKASAHAR
    TabOrder = 7
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
    DataSource = dtsKASAHAR
    TabOrder = 6
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
    DataSource = dtsKASAHAR
    Color = clScrollBar
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    AlwaysShowButton = True
  end
  object txtPROJE_KOD: TIB_Edit
    Left = 4
    Top = 209
    Width = 89
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'PROJE_KOD'
    DataSource = dtsKASAHAR
    TabOrder = 12
    OnEnter = txtPROJE_KODEnter
    OnExit = txtPROJE_KODExit
    OnKeyDown = txtPROJE_KODKeyDown
    OnKeyPress = txtPROJE_KODKeyPress
    ButtonStyle = ebsEllipsis
    OnButtonClick = txtPROJE_KODButtonClick
  end
  object txtPROJE_AD: TIB_Edit
    Left = 96
    Top = 209
    Width = 153
    Height = 21
    TabStop = False
    AutoLabel.Kind = albTop
    DataField = 'PROJE_AD'
    DataSource = dtsKASAHAR
    ReadOnly = True
    TabOrder = 13
  end
  object txtPLASIYER_KOD: TIB_Edit
    Left = 256
    Top = 208
    Width = 89
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'PLASIYER_KOD'
    DataSource = dtsKASAHAR
    TabOrder = 14
    OnEnter = txtPLASIYER_KODEnter
    OnExit = txtPLASIYER_KODExit
    OnKeyDown = txtPLASIYER_KODKeyDown
    OnKeyPress = txtPLASIYER_KODKeyPress
    ButtonStyle = ebsEllipsis
    OnButtonClick = txtPLASIYER_KODButtonClick
  end
  object txtPLASIYER_AD: TIB_Edit
    Left = 348
    Top = 209
    Width = 176
    Height = 21
    TabStop = False
    AutoLabel.Kind = albTop
    DataField = 'PLASIYER_AD'
    DataSource = dtsKASAHAR
    ReadOnly = True
    TabOrder = 16
  end
  object IB_Edit5: TIB_Edit
    Left = 4
    Top = 173
    Width = 521
    Height = 21
    AutoLabel.Kind = albTop
    AutoLabel.Caption = 'Yevmiye A'#231#305'klamas'#305
    DataField = 'YEVMIYE_ACK'
    DataSource = dtsKASAHAR
    Visible = False
    TabOrder = 11
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
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
    TabOrder = 18
  end
  object btnCikti: TButton
    Left = 427
    Top = 301
    Width = 97
    Height = 30
    Caption = 'Yaz'#305'c'#305' '#199#305'kt'#305's'#305
    TabOrder = 19
    TabStop = False
    OnClick = btnCiktiClick
  end
  object grpRapKod: TGroupBox
    Left = 6
    Top = 234
    Width = 517
    Height = 61
    TabOrder = 15
    object IB_Edit8: TIB_Edit
      Left = 10
      Top = 26
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
      Left = 112
      Top = 26
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
      Left = 218
      Top = 26
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
      Left = 319
      Top = 26
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
      Left = 422
      Top = 26
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
  object Cb_Aciklama: TIB_ComboBox
    Left = 5
    Top = 134
    Width = 521
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'ACIKLAMA'
    DataSource = dtsKASAHAR
    TabOrder = 8
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    ItemHeight = 13
  end
  object qryKASAHAR: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    FieldsDisplayLabel.Strings = (
      'FIS_NO=Fi'#351' No'
      'KASA_KOD=Kasa Kodu'
      'TARIH=Tarih'
      'DOV_BAZ_TAR=D'#246'viz Baz Tar'
      'ACIKLAMA=Hareket A'#231#305'klamas'#305
      'KASA_AD=Kasa Ad'#305
      'CH_ACIKLAMA=C/H A'#231#305'klama'
      'YEV_ACIKLAMA=Yevmiye Defteri A'#231#305'klama'
      'KASAHAR_ID=FIS NO')
    FieldsVisible.Strings = (
      'KASAHAR_ID=FALSE'
      'KASAHAR_SID=FALSE'
      'BELGE_TUR=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnKASAHAR
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
      
        '     , (SELECT CARI.CARI_AD FROM CARI WHERE CARI.CARI_KOD = KASA' +
        'HAR.KARSIKOD) AS KARSI_AD'
      '     , SIRA_NO'
      '     , DOVKOD'
      '     , DOVKUR'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , TUTAR'
      '     , TUTAR_VPB'
      '     , OLCUBIRIM'
      '     , MIKTAR'
      '     , PROJE_KOD'
      '     , YEVMIYE_ACK'
      
        '     , (SELECT PROJE.PROJE_AD FROM PROJE WHERE PROJE.PROJE_KOD =' +
        ' KASAHAR.PROJE_KOD) AS PROJE_AD'
      '     , PLASIYER_KOD'
      
        '     , (SELECT PLASIYER.ADISOY FROM PLASIYER WHERE PLASIYER.PLAS' +
        'IYER_KOD = KASAHAR.PLASIYER_KOD) AS PLASIYER_AD '
      'FROM KASAHAR '
      
        'WHERE KASAHAR_ID=:PRM_KASAHAR_ID AND KASAHAR_SID=:PRM_KASAHAR_SI' +
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
    GeneratorLinks.Strings = (
      'KASAHAR.KASAHAR_ID=GEN_KASAHAR')
    KeyLinks.Strings = (
      'KASAHAR.KASAHAR_ID'
      'KASAHAR.KASAHAR_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryKASAHARAfterInsert
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 196
    Top = 108
    ParamValues = (
      'PRM_KASAHAR_ID=0')
  end
  object dtsKASAHAR: TIB_DataSource
    AutoInsert = False
    Dataset = qryKASAHAR
    OnDataChange = dtsKASAHARDataChange
    OnStateChanged = dtsKASAHARStateChanged
    Left = 168
    Top = 156
  end
  object trnKASAHAR: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 260
    Top = 116
  end
end
