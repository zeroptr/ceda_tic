object frmTERM_FF: TfrmTERM_FF
  Left = 277
  Top = 167
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #350'irket D'#246'nem '#304#351'lemleri'
  ClientHeight = 449
  ClientWidth = 464
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object grdSIRKET: TIB_Grid
    Left = 0
    Top = 0
    Width = 456
    Height = 117
    CustomGlyphsSupplied = []
    DataSource = dtsSIRKET
    Ctl3D = True
    ParentCtl3D = False
    PreventDeleting = True
    PreventEditing = True
    PreventInserting = True
    ReadOnly = True
    TabOrder = 0
    RowSelect = True
    Ctl3DShallow = True
  end
  object grdTERMS: TIB_Grid
    Left = 0
    Top = 117
    Width = 456
    Height = 117
    CustomGlyphsSupplied = []
    DataSource = dtsTERMS
    Ctl3D = True
    ParentCtl3D = False
    PreventDeleting = True
    PreventEditing = True
    PreventInserting = True
    ReadOnly = True
    TabOrder = 1
    RowSelect = True
    Ctl3DShallow = True
  end
  object IB_Edit1: TIB_Edit
    Left = 8
    Top = 256
    Width = 61
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'DONEM_NO'
    DataSource = dtsTERMS
    Enabled = False
    TabOrder = 2
  end
  object IB_Date1: TIB_Date
    Left = 76
    Top = 256
    Width = 100
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'DONEM_BAS'
    DataSource = dtsTERMS
    TabOrder = 3
    IncCellHeight = 1
    IncCellWidth = 2
    DrawYearArrow = False
  end
  object IB_Date2: TIB_Date
    Left = 176
    Top = 256
    Width = 100
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'DONEM_SON'
    DataSource = dtsTERMS
    TabOrder = 4
    IncCellHeight = 1
    IncCellWidth = 2
    DrawYearArrow = False
  end
  object IB_Edit2: TIB_Edit
    Left = 8
    Top = 296
    Width = 161
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'SERVER_NAME'
    DataSource = dtsTERMS
    TabOrder = 6
  end
  object IB_CheckBox1: TIB_CheckBox
    Left = 280
    Top = 256
    Width = 97
    Height = 17
    DataField = 'CONN_LOCAL'
    DataSource = dtsTERMS
    OnClick = IB_CheckBox1Click
    BorderStyle = bsNone
    TabOrder = 5
    Caption = 'Yerel Ba'#287'lant'#305
  end
  object Panel1: TPanel
    Left = 0
    Top = 419
    Width = 464
    Height = 30
    Align = alBottom
    TabOrder = 8
    TabStop = True
    object btnYeni: TBitBtn
      Left = 5
      Top = 3
      Width = 62
      Height = 25
      Caption = 'Yeni (INS)'
      TabOrder = 0
      OnClick = btnYeniClick
      NumGlyphs = 2
    end
    object btnKaydet: TButton
      Left = 69
      Top = 3
      Width = 91
      Height = 25
      Caption = 'Kaydet (CTRL+S)'
      TabOrder = 1
      OnClick = btnKaydetClick
    end
    object btnIPTAL: TButton
      Left = 162
      Top = 3
      Width = 80
      Height = 25
      Caption = #304'ptal(CTRL+P)'
      TabOrder = 2
      OnClick = btnIPTALClick
    end
    object btnSil: TButton
      Left = 246
      Top = 3
      Width = 87
      Height = 25
      Caption = 'Sil (CTRL+DEL)'
      TabOrder = 3
      OnClick = btnSilClick
    end
    object btnCikis: TBitBtn
      Left = 387
      Top = 3
      Width = 72
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 4
      OnClick = btnCikisClick
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
  object txtPath: TIB_Edit
    Left = 175
    Top = 296
    Width = 273
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'DB_PATH'
    DataSource = dtsTERMS
    TabOrder = 7
    ButtonStyle = ebsEllipsis
    OnButtonClick = txtPathButtonClick
  end
  object IB_Edit3: TIB_Edit
    Left = 8
    Top = 332
    Width = 161
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'USER_NAME'
    DataSource = dtsTERMS
    TabOrder = 10
  end
  object IB_Edit4: TIB_Edit
    Left = 175
    Top = 331
    Width = 161
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'PASS_WORD'
    DataSource = dtsTERMS
    TabOrder = 11
    PasswordChar = '#'
  end
  object IB_CheckBox2: TIB_CheckBox
    Left = 337
    Top = 332
    Width = 53
    Height = 17
    DataField = 'AKTIF'
    DataSource = dtsTERMS
    BorderStyle = bsNone
    TabOrder = 12
    Caption = 'Aktif'
  end
  object mnuTEST: TButton
    Left = 384
    Top = 328
    Width = 75
    Height = 25
    Caption = 'TEST !'
    TabOrder = 9
    OnClick = mnuTESTClick
  end
  object btnSirketYarat: TButton
    Left = 6
    Top = 360
    Width = 223
    Height = 25
    Caption = 'Yeni D'#246'nem Olu'#351'tur'
    TabOrder = 13
    Visible = False
    OnClick = btnSirketYaratClick
  end
  object btnDonemDevir: TButton
    Left = 235
    Top = 359
    Width = 229
    Height = 25
    Caption = #214'nceki D'#246'nemden Devir'
    TabOrder = 14
    Visible = False
    OnClick = btnDonemDevirClick
  end
  object qrySIRKET: TIB_Query
    FieldsDisplayLabel.Strings = (
      'SIRKET_AD='#350'irketler')
    FieldsDisplayWidth.Strings = (
      'SIRKET_AD=372')
    FieldsVisible.Strings = (
      'SIRKET_ID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT SIRKET_ID'
      '     , SIRKET_AD'
      'FROM SIRKET')
    ColorScheme = False
    KeyLinks.Strings = (
      'SIRKET.SIRKET_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 164
    Top = 88
  end
  object qryTERMS: TIB_Query
    ColumnAttributes.Strings = (
      'CONN_LOCAL=BOOLEAN=1,0'
      'AKTIF=BOOLEAN=1,0')
    FieldsDisplayLabel.Strings = (
      'DONEM_NO=D'#246'nem No'
      'DONEM_BAS=D'#246'nem Ba'#351#305
      'DONEM_SON=D'#246'nem Sonu'
      'DB_PATH=Veri Taban'#305' Yolu'
      'SERVER_NAME=Sunucu Ad'#305' / IP'
      'CONN_LOCAL=Yerel Ba'#287'lant'#305
      'USER_NAME=DB Kullan'#305'c'#305' Ad'#305
      'PASS_WORD=DB Parola')
    FieldsDisplayWidth.Strings = (
      'DONEM_BAS=83'
      'DONEM_SON=100')
    FieldsVisible.Strings = (
      'SIRKET_ID=FALSE'
      'DB_PATH=FALSE'
      'SERVER_NAME=FALSE'
      'CONN_LOCAL=FALSE'
      'PASS_WORD=FALSE'
      'USER_NAME=FALSE'
      'AKTIF=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT SIRKET_ID'
      '     , DONEM_NO'
      '     , DONEM_BAS'
      '     , DONEM_SON'
      '     , DB_PATH'
      '     , SERVER_NAME'
      '     , CONN_LOCAL'
      '     , USER_NAME'
      '     , PASS_WORD'
      '     , AKTIF'
      'FROM TERMS')
    ColorScheme = False
    DefaultValues.Strings = (
      'SIRKET_ID=0')
    KeyLinks.Strings = (
      'TERMS.SIRKET_ID'
      'TERMS.DONEM_NO')
    MasterSource = dtsSIRKET
    MasterLinks.Strings = (
      'TERMS.SIRKET_ID=SIRKET.SIRKET_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryTERMSAfterInsert
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 158
    Top = 146
    ParamValues = (
      'MLNK_SIRKET_ID_0=0')
  end
  object dtsSIRKET: TIB_DataSource
    AutoEdit = False
    Dataset = qrySIRKET
    Left = 252
    Top = 90
  end
  object dtsTERMS: TIB_DataSource
    Dataset = qryTERMS
    OnStateChanged = dtsTERMSStateChanged
    Left = 220
    Top = 144
  end
  object dlgFileOpen: TOpenDialog
    Filter = 'Firebird Dosyalar'#305'|*.fdb|Interbase Dosyalar'#305'|*.gdb'
    Left = 318
    Top = 126
  end
end
