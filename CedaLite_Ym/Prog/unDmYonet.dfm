object DmYonet: TDmYonet
  OldCreateOrder = False
  Height = 366
  Width = 449
  object ScriptExecutive: TIB_Script
    OnError = ScriptExecutiveError
    IB_Connection = dbaCreate
    Left = 114
    Top = 30
  end
  object dbaCreate: TIB_Connection
    Left = 42
    Top = 30
  end
  object qryHedef1: TIB_Query
    IB_Connection = dbaCreate
    SQL.Strings = (
      ''
      '')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 88
    Top = 86
    ParamValues = (
      'MLNK_SIRKET_ID_0=1')
  end
  object Trn_Scrt: TIBOTransaction
    IB_Connection = dbaCreate
    Isolation = tiConsistency
    Left = 216
    Top = 152
  end
end
