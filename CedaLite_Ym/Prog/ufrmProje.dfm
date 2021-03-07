object frmProje: TfrmProje
  Left = 286
  Top = 363
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Proje Tan'#305'mlamalar'#305
  ClientHeight = 177
  ClientWidth = 520
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
  object edt_Proje_Kod: TIB_Edit
    Left = 57
    Top = 3
    Width = 161
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'PROJE_KOD'
    DataSource = dtsProje
    TabOrder = 0
    TabStopAutomation = True
    OnEnter = edt_Proje_KodEnter
    OnExit = edt_Proje_KodExit
    OnKeyPress = edt_Proje_KodKeyPress
    AutoSelect = False
  end
  object edt_Proje_Ad: TIB_Edit
    Left = 56
    Top = 27
    Width = 458
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'PROJE_AD'
    DataSource = dtsProje
    TabOrder = 1
    TabStopAutomation = True
    OnEnter = edt_Proje_KodEnter
    OnExit = edt_Proje_AdExit
    OnKeyPress = edt_Proje_KodKeyPress
    AutoSelect = False
  end
  object IB_Edit3: TIB_Edit
    Left = 3
    Top = 103
    Width = 449
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'ACIKLAMA'
    DataSource = dtsProje
    TabOrder = 3
    TabStopAutomation = True
    OnEnter = edt_Proje_KodEnter
    OnExit = IB_Edit3Exit
    OnKeyPress = edt_Proje_KodKeyPress
    AutoSelect = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 147
    Width = 520
    Height = 30
    Align = alBottom
    TabOrder = 5
    object btnAra: TBitBtn
      Left = 392
      Top = 3
      Width = 62
      Height = 25
      Caption = '&Ara'
      TabOrder = 0
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
      Left = 455
      Top = 3
      Width = 61
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
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
    object btnSil: TButton
      Left = 244
      Top = 3
      Width = 87
      Height = 25
      Caption = 'Sil (CTRL+DEL)'
      TabOrder = 2
      OnClick = btnSilClick
    end
    object btnIPTAL: TButton
      Left = 163
      Top = 3
      Width = 80
      Height = 25
      Caption = #304'ptal(CTRL+P)'
      TabOrder = 3
      OnClick = btnIPTALClick
    end
    object btnKaydet: TButton
      Left = 69
      Top = 3
      Width = 91
      Height = 25
      Caption = 'Kaydet (CTRL+S)'
      TabOrder = 4
      OnClick = btnKaydetClick
    end
    object btnYeni: TBitBtn
      Left = 5
      Top = 3
      Width = 62
      Height = 25
      Caption = 'Yeni (INS)'
      TabOrder = 5
      OnClick = btnYeniClick
      NumGlyphs = 2
    end
    object Btn_Onceki: TButton
      Left = 338
      Top = 3
      Width = 25
      Height = 25
      Caption = '<'
      TabOrder = 6
      OnClick = Btn_OncekiClick
    end
    object Btn_Sonraki: TButton
      Left = 362
      Top = 3
      Width = 25
      Height = 25
      Caption = '>'
      TabOrder = 7
      OnClick = Btn_SonrakiClick
    end
  end
  object IB_Currency1: TIB_Currency
    Left = 207
    Top = 74
    Width = 121
    Height = 21
    TabStop = False
    AutoLabel.Kind = albLeft
    DataField = 'ALACAK'
    DataSource = dtsProje
    Enabled = False
    TabOrder = 6
    AlwaysShowButton = True
  end
  object IB_Currency2: TIB_Currency
    Left = 207
    Top = 51
    Width = 121
    Height = 21
    TabStop = False
    AutoLabel.Kind = albLeft
    DataField = 'BORC'
    DataSource = dtsProje
    Enabled = False
    TabOrder = 7
    AlwaysShowButton = True
  end
  object IB_Currency3: TIB_Currency
    Left = 393
    Top = 51
    Width = 121
    Height = 21
    TabStop = False
    AutoLabel.Kind = albLeft
    DataField = 'BORC_VPB'
    DataSource = dtsProje
    Enabled = False
    TabOrder = 8
    AlwaysShowButton = True
  end
  object IB_Currency4: TIB_Currency
    Left = 393
    Top = 74
    Width = 121
    Height = 21
    TabStop = False
    AutoLabel.Kind = albLeft
    DataField = 'ALACAK_VPB'
    DataSource = dtsProje
    Enabled = False
    TabOrder = 9
    AlwaysShowButton = True
  end
  object IB_CheckBox1: TIB_CheckBox
    Left = 420
    Top = 128
    Width = 85
    Height = 17
    DataField = 'KAPANDI'
    DataSource = dtsProje
    BorderStyle = bsNone
    TabOrder = 4
    Caption = 'Kapand'#305
  end
  object cboDOVKOD: TIB_ComboBox
    Left = 56
    Top = 54
    Width = 121
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'DOVKOD'
    DataSource = dtsProje
    TabOrder = 2
    OnEnter = cboDOVKODEnter
    OnExit = cboDOVKODExit
    Style = csDropDownList
    ItemHeight = 13
  end
  object qryPROJE: TIB_Query
    ColumnAttributes.Strings = (
      'KAPANDI=BOOLEAN=1,0')
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    FieldsCharCase.Strings = (
      'KOD=UPPER'
      'AD=UPPER')
    FieldsDisplayLabel.Strings = (
      'KOD=Kod'
      'DOVKOD=Para Birimi'
      'ACK=Tan'#305'm'#305
      'AD=Ad'
      'PROJE_AD=Proje Ad'#305
      'PROJE_KOD=Proje Kodu'
      'ACIKLAMA=Ac'#305'klama'
      'BORC=Bor'#231
      'ALACAK=Alacak'
      'BORC_VPB=Bor'#231' VPB'
      'ALACAK_VPB=Alacak VPB')
    FieldsReadOnly.Strings = (
      'BORC=TRUE'
      'ALACAK=TRUE'
      'BORC_VPB=TRUE'
      'ALACAK_VPB=TRUE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT PROJE_KOD'
      '     , PROJE_SID'
      '     , PROJE_AD'
      '     , ACIKLAMA'
      '     , DOVKOD'
      '     , BORC'
      '     , ALACAK'
      '     , BORC_VPB'
      '     , ALACAK_VPB'
      '     , KAPANDI'
      'FROM PROJE'
      'WHERE PROJE_KOD =:PRM_PROJE_KOD'
      '')
    ColorScheme = False
    DefaultValues.Strings = (
      'BORC=0'
      'ALACAK=0'
      'BORC_VPB=0'
      'ALACAK_VPB=0'
      'KAPANDI=0')
    KeyLinks.Strings = (
      'PROJE.PROJE_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryPROJEAfterInsert
    BeforeDelete = qryPROJEBeforeDelete
    BeforePost = qryPROJEBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 252
    Top = 4
  end
  object dtsProje: TIB_DataSource
    AutoInsert = False
    Dataset = qryPROJE
    OnStateChanged = dtsProjeStateChanged
    Left = 196
    Top = 4
  end
end
