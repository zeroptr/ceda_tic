object frmDovTan: TfrmDovTan
  Left = 374
  Top = 280
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'D'#246'viz Tan'#305'mlama'
  ClientHeight = 281
  ClientWidth = 557
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
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 240
    Width = 557
    Height = 41
    Align = alBottom
    TabOrder = 0
    object IB_UpdateBar1: TIB_UpdateBar
      Left = 6
      Top = 8
      Width = 121
      Height = 25
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      DataSource = dts_DovTan
      ReceiveFocus = False
      CustomGlyphsSupplied = []
      VisibleButtons = [ubEdit, ubDelete, ubPost, ubCancel]
    end
    object btnExit: TBitBtn
      Left = 478
      Top = 12
      Width = 75
      Height = 25
      Caption = #199#305'k'#305#351
      TabOrder = 1
      OnClick = btnExitClick
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
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 0
    Width = 557
    Height = 240
    CustomGlyphsSupplied = []
    DataSource = dts_DovTan
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 1
    OnKeyPress = IB_Grid1KeyPress
    Ctl3DShallow = True
  end
  object qry_DovTan: TIB_Query
    ColumnAttributes.Strings = (
      'TAKIP=BOOLEAN=1,0;REQUIRED'
      'VPB=BOOLEAN=1,0'
      'PARITE=BOOLEAN=1,0')
    DatabaseName = 'cedaserver:C:\project13100\DB\bos01.FDB'
    FieldsDisplayLabel.Strings = (
      'DOVKOD=D'#246'viz Kodu'
      'ADI=Ad'#305
      'TAKIP=Takipli'
      'VPB=VPB'
      'PARITE=PARITELI'
      'PARITE_DEGER=P. DE'#286'ER')
    FieldsDisplayWidth.Strings = (
      'TAKIP=36'
      'ADI=207'
      'DOVKOD=64'
      'VPB=31'
      'PARITE=61'
      'PARITE_DEGER=120')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT DOVKOD'
      '     , ADI'
      '     , TAKIP'
      '     , VPB'
      '     , PARITE'
      '     , PARITE_DEGER'
      'FROM DOVKART')
    ColorScheme = False
    DefaultValues.Strings = (
      'VPB=0'
      'PARITE=0'
      'PARITE_DEGER=0')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterCancel = qry_DovTanAfterCancel
    AfterDelete = qry_DovTanAfterDelete
    AfterInsert = qry_DovTanAfterInsert
    AfterPost = qry_DovTanAfterPost
    BeforeDelete = qry_DovTanBeforeDelete
    BeforePost = qry_DovTanBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 210
    Top = 118
  end
  object dts_DovTan: TIB_DataSource
    Dataset = qry_DovTan
    Left = 144
    Top = 118
  end
end
