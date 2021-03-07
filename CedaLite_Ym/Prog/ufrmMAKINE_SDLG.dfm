object frmMAKINE_SDLG: TfrmMAKINE_SDLG
  Left = 266
  Top = 103
  BorderStyle = bsSingle
  Caption = 'Makine Listesi'
  ClientHeight = 328
  ClientWidth = 606
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 289
    Width = 606
    Height = 39
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      606
      39)
    object btnIPTAL: TBitBtn
      Left = 442
      Top = 8
      Width = 85
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #304'&ptal'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnIPTALClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object btnTAMAM: TBitBtn
      Left = 526
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Tamam'
      TabOrder = 1
      OnClick = btnTAMAMClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
    end
    object btnRapor: TButton
      Left = 6
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Rapor Olu'#351'tur'
      TabOrder = 2
    end
  end
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 73
    Width = 606
    Height = 216
    CustomGlyphsSupplied = []
    DataSource = dstMakine
    Align = alClient
    OnDblClick = IB_Grid1DblClick
    BorderStyle = bsNone
    TabOrder = 1
    OnKeyPress = IB_Grid1KeyPress
    RowSelect = True
    Ctl3DShallow = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 606
    Height = 73
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 32
      Width = 63
      Height = 13
      Caption = 'Makine Kodu'
    end
    object Label2: TLabel
      Left = 216
      Top = 32
      Width = 53
      Height = 13
      Caption = 'Makine Ad'#305
    end
    object Edit1: TEdit
      Left = 80
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 0
      OnEnter = Edit1Enter
      OnExit = Edit2Exit
    end
    object Edit2: TEdit
      Left = 280
      Top = 24
      Width = 193
      Height = 21
      TabOrder = 1
      OnEnter = Edit1Enter
      OnExit = Edit2Exit
    end
    object btn_Ara: TButton
      Left = 505
      Top = 18
      Width = 77
      Height = 39
      Caption = '&Ara'
      TabOrder = 2
      OnClick = btn_AraClick
    end
  end
  object dstMakine: TIB_DataSource
    Dataset = qryMakine
    Left = 216
    Top = 96
  end
  object qryMakine: TIB_Query
    DatabaseName = 'C:\project13100\DB\BILGISAYAR05.FDB'
    FieldsDisplayLabel.Strings = (
      'MAK_KOD=Makine Kodu'
      'MAK_ADI=Makine Ad'#305)
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT MAK_KOD'
      '     , MAK_ADI'
      'FROM MAKINE')
    ColorScheme = False
    KeyLinks.Strings = (
      'MAKINE.MAK_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 304
    Top = 120
  end
end
