object frmParameters: TfrmParameters
  Left = 437
  Top = 291
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Parametre Tan'#305'mlamalar'#305
  ClientHeight = 326
  ClientWidth = 530
  Color = clBtnFace
  Font.Charset = TURKISH_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 530
    Height = 295
    Align = alClient
    TabOrder = 0
    object Label4: TLabel
      Left = 12
      Top = 188
      Width = 107
      Height = 13
      Caption = 'Parametre A'#231#305'klamas'#305' :'
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 4
      Width = 205
      Height = 181
      Caption = 'Tan'#305'mlanm'#305#351' Mod'#252'ller'
      TabOrder = 0
      object IB_Grid1: TIB_Grid
        Left = 8
        Top = 12
        Width = 189
        Height = 161
        CustomGlyphsSupplied = []
        DataSource = dts_Modul
        BorderStyle = bsNone
        PreventDeleting = True
        PreventEditing = True
        PreventInserting = True
        ReadOnly = True
        TabOrder = 0
        RowSelect = True
        Ctl3DShallow = True
      end
    end
    object Panel3: TPanel
      Left = 216
      Top = 8
      Width = 297
      Height = 177
      BevelInner = bvRaised
      BevelOuter = bvLowered
      TabOrder = 1
      object IB_Grid2: TIB_Grid
        Left = 8
        Top = 8
        Width = 281
        Height = 161
        CustomGlyphsSupplied = []
        DataSource = dts_Parameters
        BorderStyle = bsNone
        PreventInserting = True
        TabOrder = 0
        OnKeyUp = IB_Grid2KeyUp
        FixedDataCols = 2
        Ctl3DShallow = True
      end
    end
    object IB_Memo1: TIB_Memo
      Left = 12
      Top = 204
      Width = 501
      Height = 85
      DataField = 'PARAM_ACK'
      DataSource = dts_Parameters
      BorderStyle = bsNone
      TabOrder = 2
      AutoSize = False
      MaxLength = 250
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 295
    Width = 530
    Height = 31
    Align = alBottom
    TabOrder = 1
    object btnExit: TBitBtn
      Left = 439
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
  end
  object qry_Modul: TIB_Query
    DatabaseName = 'c:\project13100\DB\MAIN.FDB'
    FieldsDisplayLabel.Strings = (
      'MODUL_ADI=Mod'#252'l Ad'#305)
    FieldsDisplayWidth.Strings = (
      'DB_KEY=125'
      'MODUL_ADI=155')
    FieldsVisible.Strings = (
      'MODUL_ID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT MODUL_ID,MODUL_ADI'
      'FROM MODUL')
    ColorScheme = False
    DefaultValues.Strings = (
      'MODUL_ID=0')
    KeyLinks.Strings = (
      'MODUL.MODUL_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 36
    Top = 52
  end
  object dts_Modul: TIB_DataSource
    Dataset = qry_Modul
    Left = 116
    Top = 56
  end
  object qry_Parameters: TIB_Query
    DatabaseName = 'C:\project13100\DB\bos.FDB'
    FieldsDisplayLabel.Strings = (
      'PARAM_NAME=Parametre Ad'#305
      'DEGER=Parametre De'#287'eri'
      'SUBE_ID='#350'ube No')
    FieldsDisplayWidth.Strings = (
      'SUBE_ID=47'
      'PARAM_NAME=110'
      'DEGER=88')
    FieldsVisible.Strings = (
      'MODUL_ID=FALSE'
      'PARAM_ACK=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT SUBE_ID'
      '     , MODUL_ID'
      '     , PARAM_NAME'
      '     , DEGER'
      '     , PARAM_ACK'
      'FROM PARAMETERS WHERE KODLAMA = 0 AND PARAM_NAME NOT LIKE '#39'KOD%'#39)
    ColorScheme = False
    KeyLinks.Strings = (
      'PARAMETERS.MODUL_ID'
      'PARAMETERS.PARAM_NAME')
    MasterSource = dts_Modul
    MasterLinks.Strings = (
      'MODUL_ID=MODUL.MODUL_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 202
    Top = 226
    ParamValues = (
      'MLNK_MODUL_ID_0=0')
  end
  object dts_Parameters: TIB_DataSource
    Dataset = qry_Parameters
    Left = 106
    Top = 232
  end
  object dlgColor: TColorDialog
    Left = 304
    Top = 96
  end
end
