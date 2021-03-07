object dmLOGGER: TdmLOGGER
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 370
  Top = 133
  Height = 131
  Width = 319
  object dbaLOGGER: TIB_Connection
    PasswordStorage = psNotSecure
    SQLDialect = 3
    Params.Strings = (
      'CHARACTER SET=WIN1254'
      'PATH=D:\Project\DB\LOG.FDB'
      'USER NAME=SYSDBA'
      'SQL DIALECT=3'
      'FORCED WRITES=TRUE'
      'RESERVE PAGE SPACE=TRUE')
    Left = 36
    Top = 16
    SavedPassword = '.JuMbLe.01.432B0639073E0E4B49'
  end
  object dsqlLOGWRITER: TIB_DSQL
    DatabaseName = 'D:\Project\DB\LOG.FDB'
    IB_Connection = dbaLOGGER
    SQL.Strings = (
      'INSERT INTO LOGGER( LOGGER_ID,'
      '                 SIRKET_ID,'
      '                 DONEM_NO,'
      '                 MAKINA_ADI,'
      '                 IS_SIST_KULLANICI,'
      '                 KULLANICI_ID,'
      '                 KULLANICI_ADI,'
      '                 BELGE_TUR,'
      '                 BELGE_ID,'
      '                 BELGE_SID,'
      '                 SIRA_NO,'
      '                 TARIH,'
      '                 SAAT,'
      '                 ISLEM,'
      '                 KAYIT,'
      '                 TANIMLAMA) '
      '          '
      '          VALUES(:PRM_LOGGER_ID,'
      '                 :PRM_SIRKET_ID,'
      '                 :PRM_DONEM_NO,'
      '                 :PRM_MAKINA_ADI,'
      '                 :PRM_IS_SIST_KULLANICI,'
      '                 :PRM_KULLANICI_ID,'
      '                 :PRM_KULLANICI_ADI,'
      '                 :PRM_BELGE_TUR,'
      '                 :PRM_BELGE_ID,'
      '                 :PRM_BELGE_SID,'
      '                 :PRM_SIRA_NO,'
      '                 :PRM_TARIH,'
      '                 :PRM_SAAT,'
      '                 :PRM_ISLEM,'
      '                 :PRM_KAYIT,'
      '                 :PRM_TANIMLAMA);')
    Left = 144
    Top = 10
  end
  object dbaMAIN_LOGGER: TIB_Monitor
    ItemEnd = '----*/'
    MinTicks = 10
    MonitorGroups = [mgStatement, mgClientTrace]
    NewLineText = #13#10
    StatementGroups = [sgExecute, sgExecuteImmediate]
    OnMonitorOutputItem = dbaMAIN_LOGGERMonitorOutputItem
    ProfilerConnection = DataMod.dbaMain
    Left = 220
    Top = 24
  end
end
