object frmDovKart: TfrmDovKart
  Left = 345
  Top = 265
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'D'#246'viz Kart'#305
  ClientHeight = 290
  ClientWidth = 631
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    000B3B3B3B33330000BB3B3000000000B3B3B3B3333333030BB3303300000003
    3330000000000030BB0B3B3330000003333B8B8383333033BBBB333330000000
    3333333333330B3B3BB33B3B3B0000000B3B3B3333330B3B33B3BBB3330000B3
    B3B3B3B333330B3B333BBB333B0003333000000000000B3B33BBBBB3B3000300
    000B3B3B33330B3B333BB0B33B000030B3B3B3B3B3330B3B333BBBB3B3000303
    3333333333330B33333BBB3B3B000003000B888383830BB33333333BB0000000
    33330000000000B33B3333BB300000033000B3B3B3B3B0BB33330BBB00000000
    0B3B3B3B3B3B3B0BB33B3BB00000000033333333333333300B33330000000000
    3000BBB838383830003000000000000003333380000000000000000000000000
    3338000B3B3B3B3B3B000000000000000330B3B3B3B3B3B3B3B3300000000000
    0003333FFFFFF33333333300000000000003088BBBB3B3B3B300030000000000
    000033333BBBBB3B3B33300000000000000333B3B3BBBBB3B3B3330000000000
    0000333B3BBBBBBB333330000000000000000003B3B3BFFFFB00000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFE003C1FF000000FE0000007C0000003C0000003C0000001C00000018000
    00010000000100000001000000010000000180000003C0000003C0000007E000
    000FE000001FE00000FFE00000FFE000007FF000003FF800001FFC00001FFC00
    001FFC00001FFE00003FFF00007FFFE003FFFFFFFFFFFFFFFFFFFFFFFFFF}
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblGun: TLabel
    Left = 4
    Top = 4
    Width = 37
    Height = 13
    Caption = 'lblGun'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object IB_Grid1: TIB_Grid
    Left = 177
    Top = 20
    Width = 454
    Height = 237
    CustomGlyphsSupplied = []
    DataSource = dtsDov_Kur
    PreventDeleting = True
    PreventInserting = True
    TabOrder = 0
    FixedDataCols = 1
    ColMoving = False
    Ctl3DShallow = True
    TabMovesOut = True
  end
  object Takvim: TMonthCalendar
    Left = 1
    Top = 22
    Width = 176
    Height = 153
    Date = 37246.441475370370000000
    TabOrder = 1
    OnClick = TakvimClick
  end
  object btnIntDov: TButton
    Left = 5
    Top = 232
    Width = 165
    Height = 25
    Caption = #304'nternetten Kur Al'
    TabOrder = 2
    OnClick = btnIntDovClick
  end
  object btnIntBaglan: TButton
    Left = 5
    Top = 179
    Width = 165
    Height = 25
    Caption = #304'nternete Ba'#287'lan'
    TabOrder = 3
    OnClick = btnIntBaglanClick
  end
  object btnBagKes: TButton
    Left = 5
    Top = 204
    Width = 165
    Height = 25
    Caption = 'Ba'#287'lant'#305'y'#305' Kes'
    TabOrder = 4
    OnClick = btnBagKesClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 260
    Width = 631
    Height = 30
    Align = alBottom
    TabOrder = 5
    object cmdKurGir: TBitBtn
      Left = 10
      Top = 3
      Width = 97
      Height = 25
      Hint = 'Tan'#305'ml'#305' D'#246'vizleri Ekler'
      Caption = 'Kur &Gir'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = cmdKurGirClick
    end
    object cmdKurSil: TBitBtn
      Left = 114
      Top = 3
      Width = 99
      Height = 25
      Hint = 'Ekrandaki D'#246'viz Kurlar'#305'n'#305' Siler'
      Caption = 'Kur &Sil'
      TabOrder = 1
      OnClick = cmdKurSilClick
    end
    object btnCikis: TBitBtn
      Left = 563
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
  end
  object btn_SonKur: TButton
    Left = 6
    Top = 204
    Width = 163
    Height = 25
    Caption = 'Girilen Son Kuru Getir'
    TabOrder = 6
    OnClick = btn_SonKurClick
  end
  object qryDov_Kur: TIB_Query
    DatabaseName = 'C:\ekinci_deg\EKINCI2013.FDB'
    FieldsDisplayLabel.Strings = (
      'ALISKUR=Al'#305#351' Kuru')
    FieldsGridLabel.Strings = (
      'DOVKOD=D'#246'viz Kodu'
      'ALISKUR=Al'#305#351' Kuru'
      'SATISKUR=Sat'#305#351' Kuru'
      'EF_ALISKUR=Efektif Al'#305#351
      'EF_SATISKUR=Efektif Sat'#305#351)
    FieldsDisplayWidth.Strings = (
      'ALISKUR=87'
      'SATISKUR=90'
      'EF_ALISKUR=79'
      'EF_SATISKUR=84')
    FieldsVisible.Strings = (
      'TARIH=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'Select * From DOVKUR  where TARIH=:PRM_TARIH')
    ColorScheme = False
    KeyLinks.Strings = (
      'DOVKUR.DOVKOD'
      'DOVKUR.TARIH')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RefreshAction = raKeepDataPos
    RequestLive = True
    AfterPost = qryDov_KurAfterPost
    BeforeDelete = qryDov_KurBeforeDelete
    BeforePost = qryDov_KurBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 220
    Top = 140
  end
  object qryDov_Kart: TIB_Query
    DatabaseName = 'C:\ekinci_deg\EKINCI2013.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'Select * '
      'From DOVKART'
      'WHERE PARITE = 0')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 370
    Top = 28
  end
  object dtsDov_Kur: TIB_DataSource
    Dataset = qryDov_Kur
    Left = 284
    Top = 140
  end
  object dtsDov_Kart: TIB_DataSource
    Dataset = qryDov_Kart
    Left = 438
    Top = 30
  end
  object XMLDocument1: TXMLDocument
    Left = 432
    Top = 176
    DOMVendorDesc = 'MSXML'
  end
end
