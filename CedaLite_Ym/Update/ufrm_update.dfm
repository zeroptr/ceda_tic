object frm_update: Tfrm_update
  Left = 276
  Top = 107
  Width = 436
  Height = 177
  Caption = 'Update'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 57
    Height = 13
    Caption = 'Kullan'#305'c'#305' Ad'#305
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 21
    Height = 13
    Caption = 'Sifre'
  end
  object Label3: TLabel
    Left = 8
    Top = 64
    Width = 46
    Height = 13
    Caption = 'Database'
  end
  object Label4: TLabel
    Left = 8
    Top = 96
    Width = 53
    Height = 13
    Caption = 'Update Txt'
  end
  object Edit1: TEdit
    Left = 72
    Top = 32
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
    Text = 'masterkey'
  end
  object Edit2: TEdit
    Left = 72
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'SYSDBA'
  end
  object Edit3: TEdit
    Left = 72
    Top = 56
    Width = 305
    Height = 21
    TabOrder = 2
    Text = 'C:\Cedalite\Db\Bos.Fdb'
  end
  object Button1: TButton
    Left = 384
    Top = 54
    Width = 33
    Height = 25
    Caption = 'Se'#231
    TabOrder = 3
    OnClick = Button1Click
  end
  object Edit4: TEdit
    Left = 72
    Top = 88
    Width = 305
    Height = 21
    TabOrder = 4
    Text = 'Update.Txt'
  end
  object Button2: TButton
    Left = 384
    Top = 86
    Width = 33
    Height = 25
    Caption = 'Se'#231
    TabOrder = 5
    OnClick = Button2Click
  end
  object Uygula: TButton
    Left = 160
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Uygula'
    TabOrder = 6
    OnClick = UygulaClick
  end
  object dbaMain: TIB_Connection
    PasswordStorage = psNotSecure
    SQLDialect = 3
    Params.Strings = (
      'SQL DIALECT=3'
      'CHARACTER SET=WIN1254'
      'SWEEP INTERVAL=5000')
    Left = 330
    Top = 8
    SavedPassword = '.JuMbLe.01.432B0639073E0E4B49'
  end
  object trn_Uretim: TIB_Transaction
    IB_Connection = dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 332
    Top = 58
  end
  object IB_Query2: TIB_Query
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
    Left = 256
    Top = 16
  end
  object IB_Script1: TIB_Script
    Yield = False
    IB_Connection = dbaMain
    IB_Transaction = trn_Uretim
    Left = 208
    Top = 16
  end
  object Od: TOpenDialog
    DefaultExt = '*.fdb;*.txt'
    Left = 224
    Top = 64
  end
end
