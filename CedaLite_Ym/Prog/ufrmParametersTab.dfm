object frmParametersTab: TfrmParametersTab
  Left = 393
  Top = 281
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Parametre Tan'#305'mlamalar'#305' - [ 2 ]'
  ClientHeight = 365
  ClientWidth = 570
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 570
    Height = 334
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Genel Parametreler'
      object Label3: TLabel
        Left = 120
        Top = 24
        Width = 118
        Height = 13
        Caption = 'Kod Doldurma Karakteri :'
      end
      object Label4: TLabel
        Left = 120
        Top = 48
        Width = 73
        Height = 13
        Caption = 'Kod Uzunlu'#287'u :'
      end
      object Label5: TLabel
        Left = 120
        Top = 72
        Width = 144
        Height = 13
        Caption = #350'ube Koda Dahil Edilecek Mi :'
      end
      object Label6: TLabel
        Left = 120
        Top = 96
        Width = 149
        Height = 13
        Caption = #350'ube De'#287'erinin Kod Uzunlu'#287'u :'
      end
      object Edit1: TEdit
        Left = 270
        Top = 18
        Width = 121
        Height = 21
        TabOrder = 0
        OnExit = Edit1Exit
      end
      object Edit2: TEdit
        Left = 270
        Top = 42
        Width = 121
        Height = 21
        TabOrder = 1
        OnExit = Edit2Exit
      end
      object CheckBox1: TCheckBox
        Left = 326
        Top = 69
        Width = 13
        Height = 17
        TabOrder = 2
      end
      object Edit3: TEdit
        Left = 270
        Top = 90
        Width = 121
        Height = 21
        TabOrder = 3
        OnExit = Edit3Exit
      end
      object btn_Kaydet: TButton
        Left = 259
        Top = 120
        Width = 133
        Height = 25
        Caption = 'Kaydet'
        TabOrder = 4
        OnClick = btn_KaydetClick
      end
      object btn_Iptal: TButton
        Left = 120
        Top = 120
        Width = 133
        Height = 25
        Caption = #304'ptal'
        TabOrder = 5
        OnClick = btn_IptalClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Mod'#252'l Parametreleri'
      ImageIndex = 1
      object Label1: TLabel
        Left = 13
        Top = 201
        Width = 107
        Height = 13
        Caption = 'Parametre A'#231#305'klamas'#305' :'
      end
      object GroupBox2: TGroupBox
        Left = 14
        Top = 5
        Width = 205
        Height = 194
        Caption = 'Tan'#305'mlanm'#305#351' Mod'#252'ller'
        TabOrder = 0
        object IB_Grid3: TIB_Grid
          Left = 8
          Top = 20
          Width = 189
          Height = 167
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
      object Panel1: TPanel
        Left = 224
        Top = 10
        Width = 297
        Height = 189
        BevelInner = bvRaised
        BevelOuter = bvLowered
        TabOrder = 1
        object IB_Grid4: TIB_Grid
          Left = 8
          Top = 8
          Width = 281
          Height = 173
          CustomGlyphsSupplied = []
          DataSource = dts_Parameters
          BorderStyle = bsNone
          PreventInserting = True
          TabOrder = 0
          FixedDataCols = 1
          Ctl3DShallow = True
        end
      end
      object IB_Memo2: TIB_Memo
        Left = 14
        Top = 217
        Width = 509
        Height = 87
        DataField = 'PARAM_ACK'
        DataSource = dts_Parameters
        BorderStyle = bsNone
        TabOrder = 2
        AutoSize = False
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 334
    Width = 570
    Height = 31
    Align = alBottom
    TabOrder = 1
    object btnExit: TBitBtn
      Left = 469
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
    DatabaseName = 'c:\CedaLite\Db\MAIN.FDB'
    FieldsDisplayLabel.Strings = (
      'MODUL_ADI=Mod'#252'l Ad'#305
      'MODUL_DESC=Mod'#252'l A'#231#305'klamas'#305
      'PROGRAM_ID=Program No'
      'MODUL_ID=Mod'#252'l No')
    FieldsDisplayWidth.Strings = (
      'DB_KEY=125'
      'MODUL_ADI=119'
      'PROGRAM_ID=65')
    FieldsVisible.Strings = (
      'MODUL_ID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT * FROM MODUL')
    ColorScheme = False
    DefaultValues.Strings = (
      'MODUL_ID=0')
    KeyLinks.Strings = (
      'MODUL.MODUL_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 432
    Top = 40
  end
  object dts_Modul: TIB_DataSource
    Dataset = qry_Modul
    Left = 439
    Top = 100
  end
  object dts_Parameters: TIB_DataSource
    Dataset = qry_Parameters
    Left = 146
    Top = 268
  end
  object qry_Parameters: TIB_Query
    DatabaseName = 'c:\CedaLite\Db\CEVRESEL_2006.FDB'
    FieldsDisplayLabel.Strings = (
      'DEGER=Parametre De'#287'eri'
      'PARAM_NAME=Parametre Ad'#305)
    FieldsVisible.Strings = (
      'MODUL_ID=FALSE'
      'PARAM_ACK=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT PARAM_NAME,DEGER,MODUL_ID'
      'FROM PARAMETERS'
      'WHERE KODLAMA = 0'
      'AND  MODUL_ID = 0'
      'AND   PARAM_NAME '
      'LIKE '#39'KOD%'#39'      ')
    ColorScheme = False
    KeyLinks.Strings = (
      'PARAMETERS.MODUL_ID'
      'PARAMETERS.PARAM_NAME')
    MasterSource = dts_Modul
    MasterLinks.Strings = (
      'MODUL_ID=MODUL.MODUL_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 64
    Top = 268
  end
end
