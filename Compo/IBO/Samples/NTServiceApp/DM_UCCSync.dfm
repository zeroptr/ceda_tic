inherited svcUCCSync: TsvcUCCSync
  OldCreateOrder = True
  DisplayName = 'UCC_SyncSVC'
  Left = 285
  Top = 161
  Height = 276
  Width = 473
  inherited se: TIB_Session
    AllowDefaultConnection = False
    AllowDefaultTransaction = False
    DefaultConnection = cnUCCdb
    OnError = seError
    Left = 32
    Top = 7
  end
  inherited em: TNMSMTP
    Host = 'mail.sosaz.com'
    PostMessage.FromAddress = 'UCCSync@spock.computer'
    PostMessage.FromName = 'UCCSync Service'
    PostMessage.ToAddress.Strings = (
      'jwharton@mail.sosaz.com'
      'mtotherow@mail.sosaz.com')
    PostMessage.Subject = 'Check UCC_SyncSVC Log'
    Left = 80
  end
  object cnUCCdb: TIB_Connection
    PasswordStorage = psNotSecure
    DatabaseName = 'UCCdb_SVC'
    Params.Strings = (
      'PATH=d:\ibdb\UCCdb.GDB'
      'USER NAME=UCC_SYNC'
      'SERVER=spock'
      'PROTOCOL=TCP/IP')
    AfterConnect = cnAfterConnect
    Left = 128
    Top = 8
    SavedPassword = '.JuMbLe.01.5C2F05225678'
  end
  object cnUCCdb_Search: TIB_Connection
    PasswordStorage = psNotSecure
    DatabaseName = 'UCCdb_Search_SVC'
    Params.Strings = (
      'PATH=d:\ibdb\UCCdb_Search.GDB'
      'USER NAME=UCC_SYNC'
      'SERVER=spock'
      'PROTOCOL=TCP/IP')
    AfterConnect = cnAfterConnect
    Left = 200
    Top = 8
    SavedPassword = '.JuMbLe.01.5C2F05225678'
  end
  object Lien: TIB_RPL_Sync
    IB_Connection = cnUCCdb_Search
    Passive = True
    IB_ConnectionSrc = cnUCCdb
    ReplicatorIndexName = 'LIEN'
    Interval = 0
    OnLogItem = RPLLogItem
    OnWakeup = WakeupThread
    Left = 64
    Top = 80
  end
  object Filing: TIB_RPL_Sync
    IB_Connection = cnUCCdb_Search
    Passive = True
    IB_ConnectionSrc = cnUCCdb
    ReplicatorIndexName = 'FILING'
    Interval = 0
    OnLogItem = RPLLogItem
    OnWakeup = WakeupThread
    Left = 136
    Top = 80
  end
  object D_IND: TIB_RPL_Sync
    IB_Connection = cnUCCdb_Search
    Passive = True
    IB_ConnectionSrc = cnUCCdb
    ReplicatorIndexName = 'DEBTOR_IND'
    Interval = 0
    OnLogItem = RPLLogItem
    OnWakeup = WakeupThread
    Left = 32
    Top = 136
  end
  object D_ORG: TIB_RPL_Sync
    IB_Connection = cnUCCdb_Search
    Passive = True
    IB_ConnectionSrc = cnUCCdb
    ReplicatorIndexName = 'DEBTOR_ORG'
    Interval = 0
    OnLogItem = RPLLogItem
    OnWakeup = WakeupThread
    Left = 80
    Top = 136
  end
  object S_IND: TIB_RPL_Sync
    IB_Connection = cnUCCdb_Search
    Passive = True
    IB_ConnectionSrc = cnUCCdb
    ReplicatorIndexName = 'SECPRT_IND'
    Interval = 0
    OnLogItem = RPLLogItem
    OnWakeup = WakeupThread
    Left = 128
    Top = 136
  end
  object S_ORG: TIB_RPL_Sync
    IB_Connection = cnUCCdb_Search
    Passive = True
    IB_ConnectionSrc = cnUCCdb
    ReplicatorIndexName = 'SECPRT_ORG'
    Interval = 0
    OnLogItem = RPLLogItem
    OnWakeup = WakeupThread
    Left = 176
    Top = 136
  end
end
