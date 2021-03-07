object frmFastRe_Giris: TfrmFastRe_Giris
  Left = 210
  Top = 161
  Caption = 'Kullan'#305'c'#305' Rapor Tan'#305'mlama'
  ClientHeight = 453
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 208
    Width = 688
    Height = 215
    CustomGlyphsSupplied = []
    DataSource = dts_Kul_Rep
    Align = alBottom
    ReadOnly = True
    TabOrder = 7
    RowSelect = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 423
    Width = 688
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
      Left = 608
      Top = 3
      Width = 61
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
  object IB_Edit1: TIB_Edit
    Left = 80
    Top = 16
    Width = 121
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'ID'
    DataSource = dts_Kul_Rep
    Enabled = False
    ReadOnly = True
    TabOrder = 0
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit2: TIB_Edit
    Left = 80
    Top = 43
    Width = 121
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'ADI'
    DataSource = dts_Kul_Rep
    TabOrder = 1
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit4: TIB_Edit
    Left = 308
    Top = 70
    Width = 121
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'UST_ID'
    DataSource = dts_Kul_Rep
    TabOrder = 6
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit5: TIB_Edit
    Left = 308
    Top = 43
    Width = 121
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'ESKI_RAPOR_NO'
    DataSource = dts_Kul_Rep
    TabOrder = 5
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit6: TIB_Edit
    Left = 308
    Top = 16
    Width = 121
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'MODUL_ID'
    DataSource = dts_Kul_Rep
    TabOrder = 4
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit7: TIB_Edit
    Left = 80
    Top = 97
    Width = 417
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'RAPOR_YERI_ADI'
    DataSource = dts_Kul_Rep
    TabOrder = 3
    OnEnter = IB_Edit7Enter
    OnExit = IB_Edit7Exit
    ButtonStyle = ebsEllipsis
    OnButtonClick = IB_Edit7ButtonClick
  end
  object IB_CheckBox1: TIB_CheckBox
    Left = 80
    Top = 70
    Width = 121
    Height = 17
    DataField = 'ISLEM_VAR'
    DataSource = dts_Kul_Rep
    TabOrder = 2
    Caption = 'Rapor A'#231
  end
  object btn_Rapor_Duz: TButton
    Left = 524
    Top = 95
    Width = 121
    Height = 25
    Caption = 'Raporu D'#252'zenle'
    TabOrder = 9
    OnClick = btn_Rapor_DuzClick
  end
  object IB_CheckBox2: TIB_CheckBox
    Left = 472
    Top = 70
    Width = 121
    Height = 17
    DataField = 'GOSTER'
    DataSource = dts_Kul_Rep
    TabOrder = 10
    Caption = 'G'#246'ster'
  end
  object dts_Kul_Rep: TIB_DataSource
    AutoInsert = False
    Dataset = qry_Kul_Rep
    OnStateChanged = dts_Kul_RepStateChanged
    Left = 136
    Top = 288
  end
  object qry_Kul_Rep: TIB_Query
    ColumnAttributes.Strings = (
      'ISLEM_VAR=BOOLEAN=1,0'
      'GOSTER=BOOLEAN=1,0')
    DatabaseName = 'C:\Musteriler\ekinci\main.FDB'
    FieldsDisplayLabel.Strings = (
      'ID=S'#305'ra No'
      'ADI=Men'#252' Ba'#351'l'#305#287#305
      'UST_ID='#220'st Men'#252' No'
      'ISLEM_VAR=Rapor A'#231
      'RAPOR_YERI_ADI=Rapor Yeri'
      'MODUL_ID=Modul No'
      'ESKI_RAPOR_NO=Eski Rapor No'
      'GOSTER=G'#246'ster')
    FieldsDisplayWidth.Strings = (
      'ADI=118'
      'ID=46'
      'ISLEM_VAR=55'
      'UST_ID=70'
      'ESKI_RAPOR_NO=81'
      'MODUL_ID=52'
      'RAPOR_YERI_ADI=220')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT ID'
      '     , ADI'
      '     , UST_ID'
      '     , ISLEM_VAR'
      '     , RAPOR_YERI_ADI'
      '     , MODUL_ID'
      '     , ESKI_RAPOR_NO'
      '     , GOSTER'
      'FROM KULLANICI_MENU')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qry_Kul_RepAfterInsert
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 240
    Top = 272
  end
  object Od: TOpenDialog
    Left = 572
    Top = 24
  end
end
