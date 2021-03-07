object WebModule1: TWebModule1
  OldCreateOrder = False
  Actions = <
    item
      Default = True
      Name = 'waDefault'
      PathInfo = '/'
      OnAction = WebModule1waDefaultAction
    end>
  Left = 205
  Top = 282
  Height = 98
  Width = 189
  object se: TIB_Session
    DefaultConnection = cn
    FocusedConnection = cn
    FocusedDataset = cr
    EditingColor = clYellow
    InsertingColor = clLime
    DeletingColor = clRed
    SearchingColor = clAqua
    ReadOnlyColor = clSilver
    SelectedColor = clBlue
    InvalidColor = clNone
    PreparedColor = clGrayText
    BrowsingColor = clWindow
    StoreActive = False
    TimerInterval = 0
    Left = 16
    Top = 16
  end
  object cn: TIB_Connection
    DefaultTransaction = tr
    Params.Strings = (
      'SERVER=localhost'
      
        'PATH=c:\Program Files\Common Files\Borland Shared\Data\employee.' +
        'gdb'
      'USER NAME=SYSDBA'
      'PASSWORD=masterkey'
      'PROTOCOL=TCP/IP')
    Left = 56
    Top = 16
  end
  object tr: TIB_Transaction
    IB_Connection = cn
    Isolation = tiConcurrency
    Left = 96
    Top = 16
  end
  object cr: TIB_Cursor
    DatabaseName = 
      'localhost:c:\Program Files\Common Files\Borland Shared\Data\empl' +
      'oyee.gdb'
    IB_Connection = cn
    SQL.Strings = (
      'SELECT * FROM CUSTOMER')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 136
    Top = 16
  end
end
