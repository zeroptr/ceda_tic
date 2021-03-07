object frmBakiyeDevret: TfrmBakiyeDevret
  Left = 233
  Top = 9
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Bakiye Devir '#304#351'lemleri'
  ClientHeight = 680
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox5: TGroupBox
    Left = 0
    Top = 578
    Width = 482
    Height = 67
    Align = alBottom
    Caption = 'Hedef Bakiye S'#305'f'#305'rlama Se'#231'enekleri'
    TabOrder = 6
    ExplicitTop = 603
    ExplicitWidth = 475
    object chkCariRst: TCheckBox
      Left = 7
      Top = 18
      Width = 42
      Height = 17
      Caption = 'Cari'
      TabOrder = 0
    end
    object chkUrunRst: TCheckBox
      Left = 7
      Top = 42
      Width = 42
      Height = 17
      Caption = #220'r'#252'n'
      TabOrder = 1
    end
    object chkMasrafRst: TCheckBox
      Left = 58
      Top = 18
      Width = 55
      Height = 17
      Caption = 'Masraf'
      TabOrder = 2
    end
    object chkKasaRst: TCheckBox
      Left = 58
      Top = 42
      Width = 47
      Height = 17
      Caption = 'Kasa'
      TabOrder = 3
    end
    object btnSifirla: TButton
      Left = 317
      Top = 18
      Width = 145
      Height = 39
      Caption = 'Se'#231'ili Se'#231'enekleri S'#305'f'#305'rla'
      TabOrder = 4
      OnClick = btnSifirlaClick
    end
    object chkProjeRst: TCheckBox
      Left = 117
      Top = 18
      Width = 44
      Height = 17
      BiDiMode = bdLeftToRight
      Caption = 'Proje'
      ParentBiDiMode = False
      TabOrder = 5
    end
    object chkPlasiyerRst: TCheckBox
      Left = 116
      Top = 42
      Width = 59
      Height = 17
      Caption = 'Plasiyer'
      TabOrder = 6
    end
    object chkAracRst: TCheckBox
      Left = 189
      Top = 18
      Width = 44
      Height = 17
      BiDiMode = bdLeftToRight
      Caption = 'Ara'#231
      ParentBiDiMode = False
      TabOrder = 7
    end
    object chkPersonelRst: TCheckBox
      Left = 189
      Top = 41
      Width = 68
      Height = 17
      BiDiMode = bdLeftToRight
      Caption = 'Personel'
      ParentBiDiMode = False
      TabOrder = 8
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 482
    Height = 118
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 475
    object IB_Grid1: TIB_Grid
      Left = 2
      Top = 15
      Width = 478
      Height = 101
      CustomGlyphsSupplied = []
      DataSource = dtsSIRKET
      Align = alClient
      PreventDeleting = True
      PreventEditing = True
      PreventInserting = True
      TabOrder = 0
      RowSelect = True
      ExplicitWidth = 471
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 274
    Width = 482
    Height = 155
    Align = alTop
    Caption = 'Hedef D'#246'nem'
    TabOrder = 2
    ExplicitWidth = 475
    object IB_Grid2: TIB_Grid
      Left = 2
      Top = 15
      Width = 478
      Height = 138
      CustomGlyphsSupplied = []
      DataSource = dtsHedef
      Align = alClient
      PreventDeleting = True
      PreventEditing = True
      PreventInserting = True
      TabOrder = 0
      RowSelect = True
      ExplicitWidth = 471
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 645
    Width = 482
    Height = 35
    Align = alBottom
    TabOrder = 5
    ExplicitTop = 670
    ExplicitWidth = 475
    object btnCikis: TButton
      Left = 389
      Top = 4
      Width = 67
      Height = 28
      Caption = #199#305'k'#305#351
      TabOrder = 0
      OnClick = btnCikisClick
    end
    object btnAktar: TButton
      Left = 6
      Top = 6
      Width = 79
      Height = 23
      Caption = 'Aktar'
      TabOrder = 1
      Visible = False
      OnClick = btnAktarClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 118
    Width = 482
    Height = 156
    Align = alTop
    Caption = 'Kaynak D'#246'nem'
    TabOrder = 1
    ExplicitWidth = 475
    object IB_Grid3: TIB_Grid
      Left = 2
      Top = 15
      Width = 478
      Height = 139
      CustomGlyphsSupplied = []
      DataSource = dtsKaynak
      Align = alClient
      PreventDeleting = True
      PreventEditing = True
      PreventInserting = True
      TabOrder = 0
      RowSelect = True
      ExplicitWidth = 471
    end
  end
  object MemoCikti: TMemo
    Left = 0
    Top = 497
    Width = 482
    Height = 76
    Align = alTop
    ScrollBars = ssVertical
    TabOrder = 4
    ExplicitWidth = 475
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 429
    Width = 482
    Height = 68
    Align = alTop
    Caption = 'Devir Se'#231'enekleri'
    TabOrder = 3
    ExplicitWidth = 475
    object chkUrun: TCheckBox
      Left = 6
      Top = 40
      Width = 59
      Height = 17
      Caption = #220'r'#252'n'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chkCari: TCheckBox
      Left = 6
      Top = 18
      Width = 55
      Height = 17
      Caption = 'Cari'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object chkMasraf: TCheckBox
      Left = 62
      Top = 40
      Width = 67
      Height = 17
      Caption = 'Masraf'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object chkKasa: TCheckBox
      Left = 133
      Top = 16
      Width = 67
      Height = 17
      Caption = 'Kasa'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object chk_Plasiyer: TCheckBox
      Left = 62
      Top = 16
      Width = 59
      Height = 17
      Caption = 'Plasiyer'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object chk_Proje: TCheckBox
      Left = 133
      Top = 40
      Width = 67
      Height = 17
      Caption = 'Proje'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object chk_Arac: TCheckBox
      Left = 205
      Top = 16
      Width = 67
      Height = 17
      Caption = 'Ara'#231
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object chk_Personel: TCheckBox
      Left = 205
      Top = 40
      Width = 67
      Height = 17
      Caption = 'Personel'
      Checked = True
      State = cbChecked
      TabOrder = 7
    end
    object CheckBox3: TCheckBox
      Left = 285
      Top = 16
      Width = 76
      Height = 17
      Caption = 'Servis Ara'#231
      Checked = True
      State = cbChecked
      TabOrder = 8
      Visible = False
    end
    object cb_Karsi: TCheckBox
      Left = 285
      Top = 39
      Width = 124
      Height = 17
      Caption = 'Kar'#351#305'la'#351't'#305'rma Yap'
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
  end
  object qryHedef: TIB_Query
    FieldsDisplayLabel.Strings = (
      'DONEM_NO=D'#246'nem No'
      'DONEM_BAS=D'#246'nem Ba'#351#305
      'DONEM_SON=D'#246'nem Sonu')
    FieldsDisplayWidth.Strings = (
      'DONEM_BAS=83'
      'DONEM_SON=100')
    FieldsVisible.Strings = (
      'SIRKET_ID=FALSE'
      'DB_PATH=FALSE'
      'SERVER_NAME=FALSE'
      'CONN_LOCAL=FALSE'
      'USER_NAME=FALSE'
      'PASS_WORD=FALSE'
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
      'FROM TERMS '
      '')
    ColorScheme = False
    KeyLinks.Strings = (
      'TERMS.SIRKET_ID'
      'TERMS.DONEM_NO')
    MasterSource = dtsSIRKET
    MasterLinks.Strings = (
      'TERMS.SIRKET_ID=SIRKET.SIRKET_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 296
    Top = 214
    ParamValues = (
      'MLNK_SIRKET_ID_0=1')
  end
  object dtsHedef: TIB_DataSource
    Dataset = qryHedef
    Left = 362
    Top = 214
  end
  object qrySIRKET: TIB_Query
    FieldsDisplayLabel.Strings = (
      'SIRKET_AD='#350#304'RKETLER')
    FieldsDisplayWidth.Strings = (
      'SIRKET_AD=372')
    FieldsVisible.Strings = (
      'SIRKET_ID=FALSE'
      'KULLANICI_ID=FALSE'
      'KULLANICI_SID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      
        'SELECT SIRKETHAK.KULLANICI_ID,SIRKETHAK.KULLANICI_SID,SIRKET.SIR' +
        'KET_ID,SIRKET.SIRKET_AD FROM SIRKETHAK'
      
        'LEFT OUTER JOIN SIRKET ON (SIRKETHAK.SIRKET_ID = SIRKET.SIRKET_I' +
        'D)'
      
        'LEFT OUTER JOIN KULLANICI ON (SIRKETHAK.KULLANICI_ID=KULLANICI.K' +
        'ULLANICI_ID AND SIRKETHAK.KULLANICI_SID=KULLANICI.KULLANICI_SID)'
      'WHERE '
      'SIRKETHAK.KULLANICI_ID = :PRM_KULLANICI_ID'
      'AND'
      'SIRKETHAK.KULLANICI_SID = :PRM_KULLANICI_SID'
      '/*'
      'SELECT SIRKET_ID'
      '     , SIRKET_AD'
      'FROM SIRKET'
      '*/')
    ColorScheme = False
    KeyLinks.Strings = (
      'SIRKET.SIRKET_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 164
    Top = 34
  end
  object qryKaynak: TIB_Query
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
      'FROM TERMS'
      '')
    ColorScheme = False
    KeyLinks.Strings = (
      'TERMS.SIRKET_ID'
      'TERMS.DONEM_NO')
    MasterSource = dtsSIRKET
    MasterLinks.Strings = (
      'TERMS.SIRKET_ID=SIRKET.SIRKET_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 170
    Top = 128
    ParamValues = (
      'MLNK_SIRKET_ID_0=1')
  end
  object dtsSIRKET: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = qrySIRKET
    Left = 246
    Top = 36
  end
  object dtsKaynak: TIB_DataSource
    Dataset = qryKaynak
    Left = 256
    Top = 132
  end
  object dbaHedef: TIB_Connection
    Left = 168
    Top = 216
  end
  object scriptBakiye: TIB_Script
    IB_Connection = dbaHedef
    IB_Transaction = trnHedef
    Left = 96
    Top = 216
  end
  object dbaKaynak: TIB_Connection
    Left = 98
    Top = 130
  end
  object trnHedef: TIB_Transaction
    IB_Connection = dbaHedef
    Isolation = tiCommitted
    Left = 224
    Top = 215
  end
  object trnKaynak: TIB_Transaction
    IB_Connection = dbaKaynak
    Isolation = tiCommitted
    Left = 338
    Top = 131
  end
  object qryHedef1: TIB_Query
    IB_Connection = dbaHedef
    SQL.Strings = (
      ''
      '')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 288
    Top = 302
    ParamValues = (
      'MLNK_SIRKET_ID_0=1')
  end
end
