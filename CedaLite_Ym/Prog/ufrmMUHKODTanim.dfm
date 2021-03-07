object frmMUHKODTanim: TfrmMUHKODTanim
  Left = 421
  Top = 240
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Rapor Kodlar'#305
  ClientHeight = 421
  ClientWidth = 511
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
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 511
    Height = 421
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Rapor Kodlar'#305
      object tcMUHKOD: TTabControl
        Left = 0
        Top = 0
        Width = 503
        Height = 363
        Align = alClient
        HotTrack = True
        Style = tsFlatButtons
        TabOrder = 0
        Tabs.Strings = (
          #304#351'lem Merkezi'
          'Kod 1'
          'Kod 2'
          'Kod 3'
          'Kod 4'
          'Kod 5')
        TabIndex = 0
        OnChange = tcMUHKODChange
        OnChanging = tcMUHKODChanging
        object IB_Grid1: TIB_Grid
          Left = 4
          Top = 27
          Width = 495
          Height = 332
          CustomGlyphsSupplied = []
          DataSource = dtsMUHKOD
          Align = alClient
          BorderStyle = bsNone
          TabOrder = 0
          Ctl3DShallow = True
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 363
        Width = 503
        Height = 30
        Align = alBottom
        TabOrder = 1
        DesignSize = (
          503
          30)
        object btnCikis: TBitBtn
          Left = 437
          Top = 3
          Width = 61
          Height = 25
          Anchors = [akRight, akBottom]
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
        object btnYeni: TBitBtn
          Left = 5
          Top = 3
          Width = 62
          Height = 25
          Caption = 'Yeni (INS)'
          TabOrder = 1
          OnClick = btnYeniClick
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
        object btnIPTAL: TButton
          Left = 163
          Top = 3
          Width = 80
          Height = 25
          Caption = #304'ptal(CTRL+P)'
          TabOrder = 3
          OnClick = btnIPTALClick
        end
        object btnSil: TButton
          Left = 244
          Top = 3
          Width = 87
          Height = 25
          Caption = 'Sil (CTRL+DEL)'
          TabOrder = 4
          OnClick = btnSilClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Rapor Kod Parametreleri'
      ImageIndex = 1
      object IB_Text1: TIB_Text
        Left = 0
        Top = 346
        Width = 503
        Height = 17
        DataField = 'ACIKLAMA'
        DataSource = dtsRAPKODPARAMS
        Align = alBottom
        Color = clInfoBk
        ParentColor = False
      end
      object Panel3: TPanel
        Left = 0
        Top = 363
        Width = 503
        Height = 30
        Align = alBottom
        TabOrder = 0
        DesignSize = (
          503
          30)
        object btnCikis1: TBitBtn
          Left = 437
          Top = 3
          Width = 61
          Height = 25
          Anchors = [akRight, akBottom]
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
        object btnYeni1: TBitBtn
          Left = 5
          Top = 3
          Width = 62
          Height = 25
          Caption = 'Yeni (INS)'
          TabOrder = 1
          OnClick = btnYeni1Click
          NumGlyphs = 2
        end
        object btnKaydet1: TButton
          Left = 69
          Top = 3
          Width = 91
          Height = 25
          Caption = 'Kaydet (CTRL+S)'
          TabOrder = 2
          OnClick = btnKaydet1Click
        end
        object btnIPTAL1: TButton
          Left = 163
          Top = 3
          Width = 80
          Height = 25
          Caption = #304'ptal(CTRL+P)'
          TabOrder = 3
          OnClick = btnIPTAL1Click
        end
        object btnSil1: TButton
          Left = 244
          Top = 3
          Width = 87
          Height = 25
          Caption = 'Sil (CTRL+DEL)'
          TabOrder = 4
          OnClick = btnSil1Click
        end
      end
      object IB_Grid2: TIB_Grid
        Left = 0
        Top = 0
        Width = 503
        Height = 346
        CustomGlyphsSupplied = []
        DataSource = dtsRAPKODPARAMS
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 1
        FixedDataCols = 1
        Ctl3DShallow = True
      end
    end
  end
  object qryMUHKOD: TIB_Query
    DatabaseName = 'c:\CedaLite\Db\CEVRESEL_2006.FDB'
    FieldsCharCase.Strings = (
      'KOD=UPPER')
    FieldsGridLabel.Strings = (
      'KOD=Kod'
      'ACIKLAMA=A'#231#305'klama')
    FieldsTrimming.Strings = (
      'KOD=BOTH')
    FieldsVisible.Strings = (
      'MUH_KOD_TIP=FALSE'
      'RAP_KOD_TIP=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT RAP_KOD_TIP'
      '     , KOD'
      '     , ACIKLAMA'
      'FROM RAP_KOD'
      'WHERE RAP_KOD_TIP = :PRM_KOD_TIP')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BeforePost = qryMUHKODBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 42
    Top = 104
    ParamValues = (
      'PRM_KOD_TIP=0')
  end
  object dtsMUHKOD: TIB_DataSource
    AutoInsert = False
    Dataset = qryMUHKOD
    OnStateChanged = dtsMUHKODStateChanged
    Left = 46
    Top = 160
  end
  object qryRAPKODPARAMS: TIB_Query
    ColumnAttributes.Strings = (
      'KOD1=BOOLEAN=1,0'
      'KOD2=BOOLEAN=1,0'
      'KOD3=BOOLEAN=1,0'
      'KOD4=BOOLEAN=1,0'
      'ACIKLAMA=BOOLEAN=1,0'
      'MASRAF_MERK=BOOLEAN=1,0')
    DatabaseName = 'c:\CedaLite\Db\CEVRESEL_2006.FDB'
    FieldsDisplayLabel.Strings = (
      'BELGE=Belge Ad'#305
      'MASRAF_MERK=Masraf Merkezi'
      'KOD1=Kod 1'
      'KOD2=Kod 2'
      'KOD3=Kod 3'
      'KOD4=Kod 4')
    FieldsDisplayWidth.Strings = (
      'BELGE=70')
    FieldsReadOnly.Strings = (
      'BELGE=TRUE;NOEDIT')
    FieldsVisible.Strings = (
      'ACIKLAMA=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT BELGE,'
      '       MASRAF_MERK,'
      '       KOD1,'
      '       KOD2,'
      '       KOD3,'
      '       KOD4,'
      '       ACIKLAMA'
      'FROM RAP_KOD_PARAMS'
      'ORDER BY BELGE')
    ColorScheme = False
    KeyLinks.Strings = (
      'RAP_KOD_PARAMS.BELGE')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BeforePost = qryRAPKODPARAMSBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 134
    Top = 105
  end
  object dtsRAPKODPARAMS: TIB_DataSource
    AutoInsert = False
    Dataset = qryRAPKODPARAMS
    OnStateChanged = dtsRAPKODPARAMSStateChanged
    Left = 134
    Top = 159
  end
end
