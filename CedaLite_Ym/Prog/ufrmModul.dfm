object frmModul: TfrmModul
  Left = 512
  Top = 117
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Program Mod'#252'l Tan'#305'mlama'
  ClientHeight = 484
  ClientWidth = 497
  Color = clBtnFace
  Font.Charset = TURKISH_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Grid_Panel: TPanel
    Left = 0
    Top = 0
    Width = 497
    Height = 453
    Align = alClient
    TabOrder = 0
    object Modul_Grid: TIB_Grid
      Left = 13
      Top = 225
      Width = 476
      Height = 180
      CustomGlyphsSupplied = []
      DataSource = dts_Modul
      BorderStyle = bsNone
      TabOrder = 1
      OnKeyPress = Modul_GridKeyPress
      Ctl3DShallow = True
    end
    object IB_Grid1: TIB_Grid
      Left = 12
      Top = 8
      Width = 477
      Height = 177
      CustomGlyphsSupplied = []
      DataSource = dts_Prg
      BorderStyle = bsNone
      TabOrder = 0
      OnEnter = IB_Grid1Enter
      OnExit = IB_Grid1Exit
      Ctl3DShallow = True
    end
    object IB_NavigationBar1: TIB_NavigationBar
      Left = 14
      Top = 411
      Width = 121
      Height = 25
      Enabled = False
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 2
      DataSource = dts_Modul
      ReceiveFocus = False
      CustomGlyphsSupplied = []
    end
    object IB_UpdateBar1: TIB_UpdateBar
      Left = 135
      Top = 411
      Width = 121
      Height = 25
      Enabled = False
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 3
      DataSource = dts_Modul
      ReceiveFocus = False
      CustomGlyphsSupplied = []
    end
    object IB_NavigationBar2: TIB_NavigationBar
      Left = 10
      Top = 191
      Width = 121
      Height = 25
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 4
      DataSource = dts_Prg
      ReceiveFocus = False
      CustomGlyphsSupplied = []
    end
    object IB_UpdateBar2: TIB_UpdateBar
      Left = 131
      Top = 191
      Width = 121
      Height = 25
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 5
      DataSource = dts_Prg
      ReceiveFocus = False
      CustomGlyphsSupplied = []
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 453
    Width = 497
    Height = 31
    Align = alBottom
    TabOrder = 1
    object btnExit: TBitBtn
      Left = 414
      Top = 3
      Width = 75
      Height = 25
      Caption = #199#305'k'#305#351
      TabOrder = 0
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
  object qry_Modul: TIB_Query
    DatabaseName = 'c:\project13100\DB\MAIN.FDB'
    FieldsDisplayLabel.Strings = (
      'MODUL_ID=Mod'#252'l Numaras'#305
      'MODUL_ADI=Mod'#252'l Ad'#305
      'MODUL_DESC=Mod'#252'l A'#231#305'klamas'#305)
    FieldsDisplayWidth.Strings = (
      'MODUL_ID=84'
      'MODUL_ADI=106'
      'MODUL_DESC=248')
    FieldsVisible.Strings = (
      'PROGRAM_ID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT MODUL_ID'
      '     , MODUL_ADI'
      '     , MODUL_DESC'
      '     , PROGRAM_ID'
      'FROM MODUL')
    ColorScheme = False
    MasterSource = dts_Prg
    MasterLinks.Strings = (
      'MODUL.PROGRAM_ID=PROGRAM.PROGRAM_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qry_ModulAfterInsert
    BeforePost = qry_ModulBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 271
    Top = 331
    ParamValues = (
      'MLNK_PROGRAM_ID_0=1')
  end
  object dts_Modul: TIB_DataSource
    AutoEdit = False
    Dataset = qry_Modul
    Left = 375
    Top = 331
  end
  object qry_Prg: TIB_Query
    DatabaseName = 'c:\project13100\DB\MAIN.FDB'
    FieldsDisplayLabel.Strings = (
      'PROGRAM_ID=Program No'
      'PROGRAM_ADI=Program Ad'#305
      'ACIKLAMA=A'#231#305'klama')
    FieldsDisplayWidth.Strings = (
      'PROGRAM_ID=67'
      'PROGRAM_ADI=115'
      'ACIKLAMA=258')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT PROGRAM_ID'
      '     , PROGRAM_ADI'
      '     , ACIKLAMA'
      'FROM PROGRAM')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 262
    Top = 106
  end
  object dts_Prg: TIB_DataSource
    AutoEdit = False
    Dataset = qry_Prg
    Left = 354
    Top = 106
  end
end
