object DataMod: TDataMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 451
  Width = 549
  object dbaMain: TIB_Connection
    PasswordStorage = psNotSecure
    SQLDialect = 3
    Params.Strings = (
      'USER NAME=SYSDBA'
      'SQL DIALECT=3'
      'CHARACTER SET=WIN1254'
      'SWEEP INTERVAL=5000'
      'SERVER=cedaserver'
      'PATH=C:\ekinci_data\EKINCI2020.FDB')
    AfterConnect = dbaMainAfterConnect
    Left = 330
    Top = 80
    SavedPassword = '.JuMbLe.01.432B0639073E0E4B49'
  end
  object qryGENEL: TIB_Query
    DatabaseName = 'C:\ekinci_data\EKINCI2020.FDB'
    IB_Connection = dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 98
    Top = 74
  end
  object FBMon: TIB_MonitorDialog
    Caption = 'Veri Taban'#305' G'#246'zetleyici'
    BaseConnection = dbaMain
    Left = 246
    Top = 78
  end
  object SP_GET_URUN_FAT_BILGI: TIB_StoredProc
    DatabaseName = 'C:\ekinci_data\EKINCI2020.FDB'
    IB_Connection = dbaMain
    SQL.Strings = (
      'EXECUTE PROCEDURE GET_URUN_FAT_BILGI'
      '  ?PRM_URUN_KOD,'
      '  ?PRM_CARI_KOD,'
      '  ?PRM_TIP,'
      '  ?ISN')
    ParamNames.Strings = (
      'PRM_URUN_KOD'
      'PRM_CARI_KOD'
      'PRM_TIP'
      'ISN')
    StoredProcName = 'GET_URUN_FAT_BILGI'
    Left = 250
    Top = 12
  end
  object SP_GET_SERVER_DATE_TIME: TIB_StoredProc
    DatabaseName = 'C:\ekinci_data\EKINCI2020.FDB'
    IB_Connection = dbaANA
    SQL.Strings = (
      'EXECUTE PROCEDURE GET_SERVER_DATE_TIME')
    StoredProcName = 'GET_SERVER_DATE_TIME'
    Left = 94
    Top = 12
  end
  object IB_SessionProps1: TIB_SessionProps
    AllowDefaultConnection = True
    AllowDefaultTransaction = True
    BusyCursor = -17
    StoreActive = False
    TimerInterval = 5000
    UseCursor = True
    YieldCursor = -19
    EditingColor = clYellow
    InsertingColor = clLime
    DeletingColor = clRed
    SearchingColor = clAqua
    ReadOnlyColor = clSilver
    SelectedColor = clBlue
    InvalidColor = clNone
    PreparedColor = clGrayText
    BrowsingColor = clWindow
    Left = 392
    Top = 12
  end
  object dbaANA: TIB_Connection
    PasswordStorage = psNotSecure
    SQLDialect = 3
    Params.Strings = (
      'USER NAME=SYSDBA'
      'SQL DIALECT=3'
      'CHARACTER SET=WIN1254'
      'SWEEP INTERVAL=5000'
      'SERVER=cedaserver'
      'PATH=C:\ekinci_data\EKINCI2020.FDB')
    Left = 402
    Top = 84
    SavedPassword = '.JuMbLe.01.432B0639073E0E4B49'
  end
  object qryGENEL1: TIB_Query
    DatabaseName = 'C:\ekinci_data\EKINCI2020.FDB'
    IB_Connection = dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 98
    Top = 138
  end
  object trnUpd: TIB_Transaction
    IB_Connection = dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 156
    Top = 98
  end
end
