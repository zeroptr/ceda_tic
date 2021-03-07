object Form1: TForm1
  Left = 276
  Top = 107
  Width = 696
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 256
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    Visible = False
    OnClick = Button1Click
  end
  object IB_Grid1: TIB_Grid
    Left = 360
    Top = 16
    Width = 297
    Height = 241
    CustomGlyphsSupplied = []
    DataSource = IB_DataSource1
    Visible = False
    TabOrder = 1
  end
  object Button2: TButton
    Left = 256
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 2
    Visible = False
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 256
    Top = 248
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 3
    Visible = False
    OnClick = Button3Click
  end
  object DBGrid1: TDBGrid
    Left = 352
    Top = 296
    Width = 320
    Height = 120
    DataSource = DataSource1
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
  end
  object Button4: TButton
    Left = 32
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Cari Kart Aktar'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 32
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Ara'#231' Aktar'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 32
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Personel Aktar'
    TabOrder = 7
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 16
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Gruplar'#305' at'
    TabOrder = 8
    OnClick = Button7Click
  end
  object dbaMain: TIB_Connection
    PasswordStorage = psNotSecure
    SQLDialect = 3
    Params.Strings = (
      'PATH=C:\cedalite\berler\bos.FDB'
      'USER NAME=SYSDBA'
      'SQL DIALECT=3'
      'CHARACTER SET=WIN1254'
      'SWEEP INTERVAL=5000'
      'SERVER=cedaserver')
    Left = 330
    Top = 80
    SavedPassword = '.JuMbLe.01.432B0639073E0E4B49'
  end
  object trn_Uretim: TIB_Transaction
    IB_Connection = dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 316
    Top = 146
  end
  object IB_Query1: TIB_Query
    DatabaseName = 'C:\cedalite\berler\bos.FDB'
    IB_Connection = dbaMain
    IB_Transaction = trn_Uretim
    SQL.Strings = (
      'SELECT SAYAC_ADI'
      '     , SUBE_ID'
      '     , DEGER'
      'FROM SAYACLAR')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 104
    Top = 88
  end
  object IB_Query2: TIB_Query
    DatabaseName = 'C:\cedalite\berler\bos.FDB'
    IB_Connection = dbaMain
    IB_Transaction = trn_Uretim
    SQL.Strings = (
      'SELECT SAYAC_ADI'
      '     , SUBE_ID'
      '     , DEGER'
      'FROM SAYACLAR')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 248
    Top = 88
  end
  object IB_DataSource1: TIB_DataSource
    Dataset = IB_Query2
    Left = 256
    Top = 24
  end
  object qrydeg1: TIB_Query
    DatabaseName = 'C:\cedalite\berler\bos.FDB'
    IB_Connection = dbaMain
    IB_Transaction = trn_Uretim
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 248
    Top = 136
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 24
    Top = 40
  end
  object Query1: TQuery
    DatabaseName = 'MSACCESS1'
    SQL.Strings = (
      'select * from carikart')
    Left = 24
    Top = 88
  end
  object Query2: TQuery
    DatabaseName = 'MSACCESS1'
    SQL.Strings = (
      'select * from carikart')
    Left = 72
    Top = 136
  end
  object Ea1: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 200
    Top = 296
  end
  object Qry_Grup: TIB_Query
    DatabaseName = 'C:\cedalite\berler\bos.FDB'
    IB_Connection = dbaMain
    IB_Transaction = trn_Uretim
    SQL.Strings = (
      'SELECT CARI_GRUP_KOD'
      '     , CARI_GRUP_SID'
      '     , CGADI'
      '     , CGACK'
      '     , TIP'
      'FROM CARI_GRUP')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 248
    Top = 384
  end
  object Qry_Grup_Uye: TIB_Query
    DatabaseName = 'C:\cedalite\berler\bos.FDB'
    IB_Connection = dbaMain
    IB_Transaction = trn_Uretim
    SQL.Strings = (
      'SELECT CARI_GRUP_KOD'
      '     , CARI_KOD'
      '     , VARSAY'
      'FROM CARI_GRUP_UYE')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 296
    Top = 392
  end
end
