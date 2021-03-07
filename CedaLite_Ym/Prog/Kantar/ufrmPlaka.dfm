object frmPlaka: TfrmPlaka
  Left = 232
  Top = 239
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Plaka'
  ClientHeight = 172
  ClientWidth = 484
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
    Top = 142
    Width = 484
    Height = 30
    Align = alBottom
    TabOrder = 0
    TabStop = True
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
    object btnKaydet: TButton
      Left = 66
      Top = 3
      Width = 91
      Height = 25
      Caption = 'Kaydet (CTRL+S)'
      TabOrder = 1
      OnClick = btnKaydetClick
    end
    object btnIPTAL: TButton
      Left = 156
      Top = 3
      Width = 80
      Height = 25
      Caption = 'Iptal(CTRL+P)'
      TabOrder = 2
      OnClick = btnIPTALClick
    end
    object btnSil: TButton
      Left = 235
      Top = 3
      Width = 87
      Height = 25
      Caption = 'Sil (CTRL+DEL)'
      TabOrder = 3
      OnClick = btnSilClick
    end
    object btnAra: TBitBtn
      Left = 328
      Top = 3
      Width = 77
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
      Left = 404
      Top = 3
      Width = 72
      Height = 25
      Caption = #199#305'k'#305#351
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
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 484
    Height = 142
    Align = alClient
    TabOrder = 1
    object IB_Edit1: TIB_Edit
      Left = 72
      Top = 16
      Width = 121
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'PLAKA_NO'
      DataSource = dstPlaka
      TabOrder = 0
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      OnKeyPress = IB_Edit1KeyPress
    end
    object IB_Edit2: TIB_Edit
      Left = 72
      Top = 112
      Width = 281
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'ACIKLAMA'
      DataSource = dstPlaka
      TabOrder = 3
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      OnKeyPress = IB_Edit1KeyPress
    end
    object IB_Edit3: TIB_Edit
      Left = 72
      Top = 80
      Width = 281
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'CARI_AD'
      DataSource = dstPlaka
      Enabled = False
      TabOrder = 2
      OnEnter = IB_Edit1Enter
      OnExit = IB_Edit1Exit
      OnKeyPress = IB_Edit1KeyPress
    end
    object txtCari_Kod: TIB_Edit
      Left = 72
      Top = 48
      Width = 121
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'CARI_KOD'
      DataSource = dstPlaka
      TabOrder = 1
      OnEnter = txtCari_KodEnter
      OnExit = txtCari_KodExit
      OnKeyPress = IB_Edit1KeyPress
      OnKeyUp = txtCari_KodKeyUp
      ButtonStyle = ebsEllipsis
      OnButtonClick = txtCari_KodButtonClick
    end
  end
  object dstPlaka: TIB_DataSource
    AutoInsert = False
    Dataset = qryPlaka
    OnStateChanged = dstPlakaStateChanged
    Left = 224
    Top = 24
  end
  object qryPlaka: TIB_Query
    DatabaseName = 'C:\project13100\DB\bos.FDB'
    FieldsDisplayLabel.Strings = (
      'MAK_KOD=Makine Kodu'
      'MAK_ADI=Makine Ad'#305
      'PLAKA_NO=Plaka No'
      'CARI_KOD=Cari Kod'
      'ACIKLAMA=A'#231#305'klama'
      'CARI_AD=Cari Ad'#305)
    FieldsVisible.Strings = (
      'PLAKA_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT '
      '       PLAKA_NO'
      '     , CARI_KOD'
      
        '     , (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=PLAKA.' +
        'CARI_KOD) As CARI_AD   '
      '     , ACIKLAMA'
      '     , PLAKA_SID'
      'FROM PLAKA'
      'where PLAKA_NO=:PRM_PLAKA_NO')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryPlakaAfterInsert
    BeforeDelete = qryPlakaBeforeDelete
    BeforePost = qryPlakaBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 312
    Top = 40
    ParamValues = (
      'PRM_PLAKA_NO=')
  end
end
