object frmMasrafGroup: TfrmMasrafGroup
  Left = 332
  Top = 463
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Masraf Grup Tan'#305'mlamalar'#305
  ClientHeight = 156
  ClientWidth = 572
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
  object Panel1: TPanel
    Left = 0
    Top = 126
    Width = 572
    Height = 30
    Align = alBottom
    TabOrder = 4
    object btnAra: TBitBtn
      Left = 440
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
      Left = 504
      Top = 3
      Width = 61
      Height = 25
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
    object btnKaydet: TButton
      Left = 69
      Top = 3
      Width = 91
      Height = 25
      Caption = 'Kaydet (CTRL+S)'
      TabOrder = 2
      OnClick = btnKaydetClick
    end
    object btnYeni: TBitBtn
      Left = 5
      Top = 3
      Width = 62
      Height = 25
      Caption = 'Yeni (INS)'
      TabOrder = 3
      OnClick = btnYeniClick
      NumGlyphs = 2
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
  object grdCGROUP: TIB_Grid
    Left = 252
    Top = 2
    Width = 315
    Height = 121
    CustomGlyphsSupplied = []
    DataSource = dtsMasrafGrup
    BorderStyle = bsNone
    TabOrder = 3
    RowSelect = True
    Ctl3DShallow = True
    TabMovesOut = True
  end
  object IB_Edit1: TIB_Edit
    Left = 54
    Top = 12
    Width = 187
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'MASRAF_GRUP_KOD'
    DataSource = dtsMasrafGrup
    TabOrder = 0
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    OnKeyPress = IB_Edit1KeyPress
  end
  object IB_Edit2: TIB_Edit
    Left = 54
    Top = 42
    Width = 187
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'MASRAF_GRUP_ADI'
    DataSource = dtsMasrafGrup
    TabOrder = 1
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    OnKeyPress = IB_Edit1KeyPress
  end
  object IB_Memo1: TIB_Memo
    Left = 54
    Top = 72
    Width = 185
    Height = 47
    AutoLabel.Kind = albLeft
    DataField = 'MASRAF_GRUP_ACK'
    DataSource = dtsMasrafGrup
    TabOrder = 2
    OnEnter = IB_Memo1Enter
    OnExit = IB_Memo1Exit
    AutoSize = False
  end
  object qryMasrafGrup: TIB_Query
    DatabaseName = 'c:\CedaLite\Db\CEVRESEL_2006.FDB'
    FieldsDisplayLabel.Strings = (
      'MASRAF_GRUP_KOD=Grup Kodu'
      'MASRAF_GRUP_ADI=Grup Ad'#305
      'MASRAF_GRUP_ACK=A'#231#305'klama')
    FieldsDisplayWidth.Strings = (
      'MASRAF_GRUP_ADI=161')
    FieldsVisible.Strings = (
      'MASRAF_GRUP_ACK=FALSE'
      'MASRAF_GRUP_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT * FROM MASRAF_GRUP')
    ColorScheme = False
    KeyLinks.Strings = (
      'MASRAF_GRUP.MASRAF_GRUP_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryMasrafGrupAfterInsert
    BeforePost = qryMasrafGrupBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 444
    Top = 12
  end
  object dtsMasrafGrup: TIB_DataSource
    Dataset = qryMasrafGrup
    OnStateChanged = dtsMasrafGrupStateChanged
    Left = 444
    Top = 60
  end
end
