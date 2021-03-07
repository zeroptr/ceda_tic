object frmProgramHizmetleri: TfrmProgramHizmetleri
  Left = 354
  Top = 296
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Program Hizmetleri'
  ClientHeight = 408
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 377
    Width = 427
    Height = 31
    Align = alBottom
    TabOrder = 0
    object btnExit: TBitBtn
      Left = 348
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
    object btnTRN_KAYDET: TButton
      Left = 227
      Top = 3
      Width = 119
      Height = 25
      Caption = 'Kaydet ( CTRL + END)'
      TabOrder = 1
      OnClick = btnTRN_KAYDETClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 427
    Height = 121
    Align = alTop
    Caption = 'Dizin Yollar'#305
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 32
      Width = 41
      Height = 13
      Caption = 'Dosyalar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 15
      Top = 59
      Width = 30
      Height = 13
      Caption = 'Script '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 15
      Top = 89
      Width = 29
      Height = 13
      Caption = 'Rapor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object txtFiles: TEdit
      Left = 66
      Top = 27
      Width = 317
      Height = 21
      TabOrder = 0
    end
    object btnFiles: TButton
      Left = 387
      Top = 27
      Width = 31
      Height = 20
      Caption = '...'
      TabOrder = 1
      OnClick = btnFilesClick
    end
    object txtScripts: TEdit
      Left = 66
      Top = 54
      Width = 317
      Height = 21
      TabOrder = 2
    end
    object btnScript: TButton
      Left = 386
      Top = 54
      Width = 31
      Height = 20
      Caption = '...'
      TabOrder = 3
      OnClick = btnScriptClick
    end
    object txtReports: TEdit
      Left = 66
      Top = 84
      Width = 317
      Height = 21
      TabOrder = 4
    end
    object btnReports: TButton
      Left = 386
      Top = 85
      Width = 31
      Height = 20
      Caption = '...'
      TabOrder = 5
      OnClick = btnReportsClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 248
    Width = 427
    Height = 127
    Align = alTop
    Caption = 'LOG DB Ba'#287'lant'#305' Bilgileri'
    TabOrder = 2
    object Label8: TLabel
      Left = 8
      Top = 36
      Width = 37
      Height = 13
      Caption = 'Sunucu'
    end
    object Label9: TLabel
      Left = 132
      Top = 36
      Width = 54
      Height = 13
      Caption = 'Veri Taban'#305
    end
    object Label10: TLabel
      Left = 8
      Top = 80
      Width = 57
      Height = 13
      Caption = 'Kullan'#305'c'#305' Ad'#305
    end
    object Label11: TLabel
      Left = 132
      Top = 80
      Width = 30
      Height = 13
      Caption = 'Parola'
    end
    object txtLOG_SERVER: TEdit
      Left = 8
      Top = 52
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object chkLOG_CONNLOCAL: TCheckBox
      Left = 12
      Top = 16
      Width = 193
      Height = 17
      Caption = 'Yerel Ba'#287'lant'#305' Kullanarak Ba'#287'lan'
      TabOrder = 0
    end
    object txtLOG_DB_PATH: TEdit
      Left = 132
      Top = 52
      Width = 253
      Height = 21
      TabOrder = 2
    end
    object Button2: TButton
      Left = 390
      Top = 53
      Width = 21
      Height = 20
      Caption = '...'
      TabOrder = 3
      OnClick = Button2Click
    end
    object txtLOG_USER_NAME: TEdit
      Left = 8
      Top = 96
      Width = 121
      Height = 21
      TabOrder = 4
    end
    object txtLOG_PASS_WORD: TEdit
      Left = 132
      Top = 96
      Width = 121
      Height = 21
      PasswordChar = '#'
      TabOrder = 5
    end
    object btnLOG_TEST: TButton
      Left = 332
      Top = 94
      Width = 75
      Height = 25
      Caption = 'TEST !'
      TabOrder = 6
      OnClick = btnLOG_TESTClick
    end
  end
  object grpMAINDB: TGroupBox
    Left = 0
    Top = 121
    Width = 427
    Height = 127
    Align = alTop
    Caption = 'Main DB Ba'#287'lant'#305' Bilgileri'
    TabOrder = 3
    object Label4: TLabel
      Left = 8
      Top = 36
      Width = 37
      Height = 13
      Caption = 'Sunucu'
    end
    object Label5: TLabel
      Left = 132
      Top = 36
      Width = 54
      Height = 13
      Caption = 'Veri Taban'#305
    end
    object Label6: TLabel
      Left = 8
      Top = 80
      Width = 57
      Height = 13
      Caption = 'Kullan'#305'c'#305' Ad'#305
    end
    object Label7: TLabel
      Left = 132
      Top = 80
      Width = 30
      Height = 13
      Caption = 'Parola'
    end
    object txtSERVER: TEdit
      Left = 8
      Top = 52
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object chkCONNLOCAL: TCheckBox
      Left = 12
      Top = 16
      Width = 193
      Height = 17
      Caption = 'Yerel Ba'#287'lant'#305' Kullanarak Ba'#287'lan'
      TabOrder = 0
    end
    object txtDB_PATH: TEdit
      Left = 132
      Top = 52
      Width = 253
      Height = 21
      TabOrder = 2
    end
    object Button1: TButton
      Left = 390
      Top = 53
      Width = 21
      Height = 20
      Caption = '...'
      TabOrder = 3
      OnClick = Button1Click
    end
    object txtUSER_NAME: TEdit
      Left = 8
      Top = 96
      Width = 121
      Height = 21
      TabOrder = 4
    end
    object txtPASS_WORD: TEdit
      Left = 132
      Top = 96
      Width = 121
      Height = 21
      PasswordChar = '#'
      TabOrder = 5
    end
    object mnuTEST: TButton
      Left = 332
      Top = 94
      Width = 75
      Height = 25
      Caption = 'TEST !'
      TabOrder = 6
      OnClick = mnuTESTClick
    end
  end
  object dlgFileOpen: TOpenDialog
    FileName = 'D:\Project\DB\MAIN.FDB'
    Filter = 'Firebird Dosyalar'#305'|*.fdb|Interbase Dosyalar'#305'|*.gdb'
    Left = 200
    Top = 88
  end
end
