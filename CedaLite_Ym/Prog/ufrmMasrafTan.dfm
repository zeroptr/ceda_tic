object frmMasrafTan: TfrmMasrafTan
  Left = 302
  Top = 279
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Masraf Tan'#305'mlamalar'#305
  ClientHeight = 214
  ClientWidth = 488
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
  PrintScale = poPrintToFit
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 488
    Height = 214
    ActivePage = TabSheet1
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    OnChange = PageControl1Change
    OnChanging = PageControl1Changing
    object TabSheet1: TTabSheet
      Caption = 'Masraf'
      object edtMasrafKod: TIB_Edit
        Left = 6
        Top = 12
        Width = 127
        Height = 21
        AutoLabel.Kind = albTop
        AutoLabel.Caption = 'Masraf Kodu'
        DataField = 'MASRAF_KOD'
        DataSource = dtsMasrafTan
        TabOrder = 0
        OnEnter = edtMasrafKodEnter
        OnExit = edtMasrafKodExit
      end
      object edtAd: TIB_Edit
        Left = 138
        Top = 12
        Width = 331
        Height = 21
        AutoLabel.Kind = albTop
        AutoLabel.Caption = 'Ad'#305
        DataField = 'ADI'
        DataSource = dtsMasrafTan
        TabOrder = 1
        OnEnter = edtMasrafKodEnter
        OnExit = edtMasrafKodExit
      end
      object Panel1: TPanel
        Left = 0
        Top = 153
        Width = 480
        Height = 30
        Align = alBottom
        TabOrder = 4
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
          Left = 376
          Top = 3
          Width = 47
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
          Left = 424
          Top = 3
          Width = 52
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
        object Btn_Onceki: TButton
          Left = 326
          Top = 3
          Width = 25
          Height = 25
          Caption = '<'
          TabOrder = 6
          OnClick = Btn_OncekiClick
        end
        object Btn_Sonraki: TButton
          Left = 350
          Top = 3
          Width = 25
          Height = 25
          Caption = '>'
          TabOrder = 7
          OnClick = Btn_SonrakiClick
        end
      end
      object edtAck: TIB_Edit
        Left = 8
        Top = 82
        Width = 465
        Height = 21
        AutoLabel.Kind = albTop
        AutoLabel.Caption = 'A'#231#305'klama'
        DataField = 'ACIKLAMA'
        DataSource = dtsMasrafTan
        TabOrder = 2
        OnEnter = edtMasrafKodEnter
        OnExit = edtMasrafKodExit
      end
      object edtBorc: TIB_Currency
        Left = 210
        Top = 117
        Width = 127
        Height = 21
        AutoLabel.Kind = albTop
        AutoLabel.Caption = 'Bor'#231
        DataField = 'BORC'
        DataSource = dtsMasrafTan
        Enabled = False
        TabOrder = 5
        OnEnter = edtBorcEnter
        OnExit = edtBorcExit
        AlwaysShowButton = True
      end
      object edtAlacak: TIB_Currency
        Left = 346
        Top = 117
        Width = 127
        Height = 21
        AutoLabel.Kind = albTop
        AutoLabel.Caption = 'Alacak'
        DataField = 'ALACAK'
        DataSource = dtsMasrafTan
        Enabled = False
        TabOrder = 6
        OnEnter = edtBorcEnter
        OnExit = edtBorcExit
        AlwaysShowButton = True
      end
      object chkDevir: TIB_CheckBox
        Left = 6
        Top = 120
        Width = 121
        Height = 17
        DataField = 'DEVIR'
        DataSource = dtsMasrafTan
        BorderStyle = bsNone
        TabOrder = 3
        Alignment = taLeftJustify
        Caption = 'Devirde Kullan'#305'ls'#305'n'
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Gruplama'
      ImageIndex = 1
      object IB_Grid1: TIB_Grid
        Left = 2
        Top = 4
        Width = 197
        Height = 134
        CustomGlyphsSupplied = []
        DataSource = dtsMasrafGrup
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        BorderStyle = bsNone
        TabOrder = 0
        RowSelect = True
        CurrentRowFont.Charset = DEFAULT_CHARSET
        CurrentRowFont.Color = clPurple
        CurrentRowFont.Height = -11
        CurrentRowFont.Name = 'MS Sans Serif'
        CurrentRowFont.Style = []
        OrderingFont.Charset = DEFAULT_CHARSET
        OrderingFont.Color = clPurple
        OrderingFont.Height = -11
        OrderingFont.Name = 'MS Sans Serif'
        OrderingFont.Style = []
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clBlack
        FixedFont.Height = -11
        FixedFont.Name = 'MS Sans Serif'
        FixedFont.Style = []
        Ctl3DShallow = True
        TabMovesOut = True
      end
      object IB_Grid2: TIB_Grid
        Left = 241
        Top = 4
        Width = 237
        Height = 134
        CustomGlyphsSupplied = []
        DataSource = dtsMasrafGrupUye
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        BorderStyle = bsNone
        TabOrder = 1
        RowSelect = True
        CurrentRowFont.Charset = DEFAULT_CHARSET
        CurrentRowFont.Color = clPurple
        CurrentRowFont.Height = -11
        CurrentRowFont.Name = 'MS Sans Serif'
        CurrentRowFont.Style = []
        OrderingFont.Charset = DEFAULT_CHARSET
        OrderingFont.Color = clPurple
        OrderingFont.Height = -11
        OrderingFont.Name = 'MS Sans Serif'
        OrderingFont.Style = []
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clBlack
        FixedFont.Height = -11
        FixedFont.Name = 'MS Sans Serif'
        FixedFont.Style = []
        Ctl3DShallow = True
        TabMovesOut = True
      end
      object btnGEkle: TButton
        Left = 204
        Top = 12
        Width = 31
        Height = 25
        Caption = '- >'
        TabOrder = 2
        OnClick = btnGEkleClick
      end
      object btnGSil: TButton
        Left = 204
        Top = 42
        Width = 31
        Height = 25
        Caption = '< -'
        TabOrder = 3
        OnClick = btnGSilClick
      end
      object btnGrupTan: TButton
        Left = 4
        Top = 145
        Width = 196
        Height = 31
        Caption = 'Grup Tan'#305'mlamalar'#305
        TabOrder = 4
        OnClick = btnGrupTanClick
      end
      object btnVarsayilan: TButton
        Left = 242
        Top = 145
        Width = 236
        Height = 31
        Caption = 'Se'#231'ili Grubu Varsay'#305'lan Olarak Ata'
        TabOrder = 5
        OnClick = btnVarsayilanClick
      end
    end
  end
  object qryMasraf: TIB_Query
    ColumnAttributes.Strings = (
      'DEVIR=BOOLEAN=1,0')
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    FieldsDisplayLabel.Strings = (
      'DEVIR=Devirde Kullan'#305'ls'#305'n')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT MASRAF_KOD'
      '     , MASRAF_SID'
      '     , ADI'
      '     , ACIKLAMA'
      '     , BORC'
      '     , ALACAK'
      '     , DEVREDEN_BORC'
      '     , DEVREDEN_ALACAK'
      '     , DEVIR'
      'FROM MASRAF'
      'WHERE MASRAF_KOD =:PRM_MASRAF_KOD;')
    ColorScheme = False
    KeyLinks.Strings = (
      'MASRAF.MASRAF_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryMasrafAfterInsert
    BeforeDelete = qryMasrafBeforeDelete
    BeforePost = qryMasrafBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 296
    Top = 60
  end
  object dtsMasrafTan: TIB_DataSource
    AutoInsert = False
    Dataset = qryMasraf
    OnStateChanged = dtsMasrafTanStateChanged
    Left = 364
    Top = 62
  end
  object qryMasrafGrupUye: TIB_Query
    ColumnAttributes.Strings = (
      'VARSAY=BOOLEAN=1,0')
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    FieldsDisplayLabel.Strings = (
      'MASRAF_GRUP_KOD=Grup Kodu'
      'MASRAF_GRUP_ADI=Grup Ad'#305
      'VARSAY=Var Say')
    FieldsDisplayWidth.Strings = (
      'MASRAF_GRUP_ADI=66'
      'MASRAF_GRUP_KOD=77'
      'VARSAY=54')
    FieldsVisible.Strings = (
      'MASRAF_KOD=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT '
      'MASRAF_GRUP_UYE.MASRAF_KOD,'
      'MASRAF_GRUP.MASRAF_GRUP_KOD,'
      'MASRAF_GRUP.MASRAF_GRUP_ADI,  '
      'MASRAF_GRUP_UYE.VARSAY'
      'FROM MASRAF_GRUP_UYE,MASRAF_GRUP'
      'WHERE '
      'MASRAF_GRUP_UYE.MASRAF_GRUP_KOD = MASRAF_GRUP.MASRAF_GRUP_KOD '
      'AND'
      'MASRAF_GRUP_UYE.MASRAF_KOD=:PRM_MASRAF_KOD '
      ' ')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 42
    Top = 31
  end
  object dtsMasrafGrupUye: TIB_DataSource
    Dataset = qryMasrafGrupUye
    Left = 144
    Top = 31
  end
  object qryMasrafGrup: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    FieldsDisplayLabel.Strings = (
      'MASRAF_GRUP_KOD=Grup Kodu'
      'MASRAF_GRUP_ADI=Grup Ad'#305)
    FieldsDisplayWidth.Strings = (
      'MASRAF_GRUP_ADI=87'
      'MASRAF_GRUP_KOD=77')
    FieldsVisible.Strings = (
      'MASRAF_GRUP_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT MASRAF_GRUP_SID,MASRAF_GRUP_KOD,MASRAF_GRUP_ADI'
      'FROM MASRAF_GRUP WHERE NOT EXISTS '
      
        '(SELECT * FROM MASRAF_GRUP_UYE WHERE MASRAF_GRUP_UYE.MASRAF_GRUP' +
        '_KOD = MASRAF_GRUP.MASRAF_GRUP_KOD '
      'AND MASRAF_KOD =:PRM_MASRAF_KOD)')
    ColorScheme = False
    KeyLinks.Strings = (
      'MASRAF_GRUP.MASRAF_GRUP_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 48
    Top = 91
  end
  object dtsMasrafGrup: TIB_DataSource
    Dataset = qryMasrafGrup
    Left = 150
    Top = 91
  end
end
