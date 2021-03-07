object frmUrun_Masraf_Merkezi: TfrmUrun_Masraf_Merkezi
  Left = 333
  Top = 212
  Width = 490
  Height = 376
  ActiveControl = IB_Edit3
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #220'r'#252'n Masraf Merkezi'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object IB_Grid1: TIB_Grid
    Left = 8
    Top = 168
    Width = 465
    Height = 137
    CustomGlyphsSupplied = []
    DataSource = dts_Netsis_Aktarma
    OnDblClick = IB_Grid1DblClick
    ReadOnly = True
    TabOrder = 4
    RowSelect = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 319
    Width = 482
    Height = 30
    Align = alBottom
    TabOrder = 5
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
      Left = 69
      Top = 3
      Width = 91
      Height = 25
      Caption = 'Kaydet (CTRL+S)'
      TabOrder = 1
      OnClick = btnKaydetClick
    end
    object btnIPTAL: TButton
      Left = 162
      Top = 3
      Width = 80
      Height = 25
      Caption = #304'ptal(CTRL+P)'
      TabOrder = 2
      OnClick = btnIPTALClick
    end
    object btnSil: TButton
      Left = 246
      Top = 3
      Width = 87
      Height = 25
      Caption = 'Sil (CTRL+DEL)'
      TabOrder = 3
      OnClick = btnSilClick
    end
    object btnCikis: TBitBtn
      Left = 401
      Top = 3
      Width = 72
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 4
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
    object Button1: TButton
      Left = 335
      Top = 3
      Width = 65
      Height = 25
      Caption = 'Degi'#351'tir'
      TabOrder = 5
      OnClick = Button1Click
    end
  end
  object txtUrunKodu: TIB_Edit
    Left = 8
    Top = 58
    Width = 116
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'URUN_KOD'
    DataSource = dts_Netsis_Aktarma
    TabOrder = 1
    OnEnter = txtUrunKoduEnter
    OnExit = txtUrunKoduExit
    OnKeyPress = txtUrunKoduKeyPress
    OnKeyUp = txtUrunKoduKeyUp
    ButtonStyle = ebsEllipsis
    OnButtonClick = txtUrunKoduButtonClick
  end
  object IB_Edit23: TIB_Edit
    Left = 126
    Top = 58
    Width = 347
    Height = 21
    TabStop = False
    AutoLabel.Kind = albTop
    DataField = 'URUN_AD'
    DataSource = dts_Netsis_Aktarma
    Enabled = False
    TabOrder = 6
  end
  object IB_Edit1: TIB_Edit
    Left = 8
    Top = 138
    Width = 116
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'YENI_URUN_KOD'
    DataSource = dts_Netsis_Aktarma
    TabOrder = 3
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    OnKeyPress = txtUrunKoduKeyPress
    OnKeyUp = IB_Edit1KeyUp
    ButtonStyle = ebsEllipsis
    OnButtonClick = IB_Edit1ButtonClick
  end
  object IB_Edit2: TIB_Edit
    Left = 126
    Top = 138
    Width = 347
    Height = 21
    TabStop = False
    AutoLabel.Kind = albTop
    DataField = 'YENI_URUN_AD'
    DataSource = dts_Netsis_Aktarma
    Enabled = False
    TabOrder = 7
  end
  object IB_Edit5: TIB_Edit
    Left = 9
    Top = 96
    Width = 115
    Height = 21
    AutoLabel.Kind = albTop
    AutoLabel.Caption = #304#351'lem Merkezi'
    DataField = 'MASRAF_MERKEZI'
    DataSource = dts_Netsis_Aktarma
    TabOrder = 2
    OnEnter = IB_Edit5Enter
    OnExit = IB_Edit5Exit
    OnKeyPress = txtUrunKoduKeyPress
    OnKeyUp = IB_Edit5KeyUp
    ButtonStyle = ebsEllipsis
    OnButtonClick = IB_Edit5ButtonClick
  end
  object IB_Edit3: TIB_Edit
    Left = 9
    Top = 22
    Width = 49
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'ID'
    DataSource = dts_Netsis_Aktarma
    TabOrder = 0
    OnEnter = IB_Edit3Enter
    OnExit = IB_Edit3Exit
  end
  object dts_Netsis_Aktarma: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = Qry_Netsis_Aktarma
    OnStateChanged = dts_Netsis_AktarmaStateChanged
    Left = 112
    Top = 152
  end
  object Qry_Netsis_Aktarma: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\Transport.FDB'
    FieldsDisplayLabel.Strings = (
      'ID=S'#305'ra No'
      'URUN_KOD='#220'r'#252'n Kodu'
      'MASRAF_MERKEZI=Masraf Merkezi'
      'YENI_URUN_KOD=Kar'#351#305'l'#305'k '#220'r'#252'n Kod'
      'URUN_AD='#220'r'#252'n Ad'#305
      'YENI_URUN_AD=Yeni '#220'r'#252'n Ad'#305)
    FieldsDisplayWidth.Strings = (
      'URUN_KOD=133'
      'MASRAF_MERKEZI=92'
      'YENI_URUN_KOD=131')
    FieldsIndex.Strings = (
      'ID'
      'URUN_KOD'
      'MASRAF_MERKEZI'
      'YENI_URUN_KOD'
      'URUN_AD'
      'YENI_URUN_AD')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT ID'
      '     , URUN_KOD'
      
        '     , (SELECT  URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD=NETSI' +
        'S_AKTARMA.URUN_KOD) AS URUN_AD'
      '     , MASRAF_MERKEZI'
      
        '     , (SELECT  URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD=NETSI' +
        'S_AKTARMA.YENI_URUN_KOD) AS YENI_URUN_AD'
      '     , YENI_URUN_KOD'
      'FROM NETSIS_AKTARMA')
    ColorScheme = False
    KeyLinks.Strings = (
      'NETSIS_AKTARMA.ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 216
    Top = 152
  end
end
