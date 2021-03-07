object frmRaporUrunFiyatListesi: TfrmRaporUrunFiyatListesi
  Left = 464
  Top = 278
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #220'r'#252'n Fiyat Listesi'
  ClientHeight = 277
  ClientWidth = 300
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
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 300
    Height = 225
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object Label1: TLabel
        Left = 8
        Top = 115
        Width = 71
        Height = 13
        Caption = 'Al'#305#351'/Sat'#305#351' Fiyat'#305
      end
      object Label2: TLabel
        Left = 8
        Top = 139
        Width = 43
        Height = 13
        Caption = #220'r'#252'n Tipi'
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 292
        Height = 79
        Align = alTop
        Caption = #220'r'#252'n Kod Aral'#305#287#305
        TabOrder = 0
        object txtUrunKod1: TEdit
          Left = 6
          Top = 16
          Width = 133
          Height = 21
          TabOrder = 0
          OnEnter = txtUrunKod1Enter
          OnExit = txtUrunKod1Exit
          OnKeyDown = txtUrunKod1KeyDown
          OnKeyPress = txtUrunKod1KeyPress
        end
        object txtUrunKod2: TEdit
          Left = 150
          Top = 16
          Width = 133
          Height = 21
          TabOrder = 1
          OnEnter = txtUrunKod1Enter
          OnExit = txtUrunKod2Exit
          OnKeyDown = txtUrunKod2KeyDown
          OnKeyPress = txtUrunKod2KeyPress
        end
        object Button1: TButton
          Left = 6
          Top = 42
          Width = 133
          Height = 25
          Caption = '&'#220'r'#252'n Listesi'
          TabOrder = 2
          TabStop = False
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 150
          Top = 42
          Width = 133
          Height = 25
          Caption = #220'&r'#252'n Listesi'
          TabOrder = 3
          TabStop = False
          OnClick = Button2Click
        end
      end
      object chk_Sirket: TCheckBox
        Left = 42
        Top = 86
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnEnter = chk_SirketEnter
        OnExit = chk_SirketExit
      end
      object ComboBox1: TComboBox
        Left = 104
        Top = 112
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 1
        TabOrder = 2
        Text = 'Sat'#305#351' Fiyati'
        Items.Strings = (
          'Al'#305#351' Fiyat'#305
          'Sat'#305#351' Fiyati'
          'Al'#305#351'-Sat'#305#351' Fiyat'#305)
      end
      object CbUrun_Tipi: TComboBox
        Left = 104
        Top = 136
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 3
        TabOrder = 3
        Text = 'Hepsi'
        Items.Strings = (
          'Mamul'
          'Yar'#305' Mamul'
          'Ham Madde'
          'Hepsi')
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Ko'#351'ullar'
      ImageIndex = 1
      object Label5: TLabel
        Left = 4
        Top = 2
        Width = 56
        Height = 13
        Caption = 'Gruplamalar'
      end
      object Label3: TLabel
        Left = 6
        Top = 46
        Width = 51
        Height = 13
        Caption = 'S'#305'ralamalar'
      end
      object cmbGrup: TComboBox
        Left = 4
        Top = 16
        Width = 273
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 2
        TabOrder = 0
        Text = 'Gruplama Yapma'
        Items.Strings = (
          'Varsay'#305'lan '#220'r'#252'n Grubuna G'#246're Gruplama'
          'Hi'#231'bir '#220'r'#252'n Grubuna '#220'ye Olmayanlar'
          'Gruplama Yapma')
      end
      object cmb_sirala: TComboBox
        Left = 4
        Top = 60
        Width = 273
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 1
        Text = #220'r'#252'n Koduna G'#246're'
        Items.Strings = (
          #220'r'#252'n Koduna G'#246're'
          #220'r'#252'n Ad'#305'na G'#246're')
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 244
    Width = 300
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 7
      Top = 4
      Width = 90
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object Button3: TButton
      Left = 218
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object btn_Fast: TButton
      Left = 115
      Top = 4
      Width = 88
      Height = 25
      Caption = 'Rapor Olu'#351'tur'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object qryUrun: TIB_Query
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    FieldsVisible.Strings = (
      'DB_KEY=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT FIELD_NAME AS ALAN_ADI'
      '     , FIELD_NAME_TR AS ALAN_ADI_TR'
      'FROM TABLE_DEFS'
      'WHERE TABLE_DEFS.TABLE_NAME ='#39'CARI'#39)
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 22
    Top = 144
  end
  object qryUrunHareket: TIB_Query
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      '')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 124
    Top = 144
  end
  object qryRapor: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    Left = 250
    Top = 146
  end
  object IB_Query1: TIB_Query
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      
        'select URUN.OLCUBIRIM, URUN.BIRIMFIY, URUN.SATISFIY, URUN.URUN_K' +
        'OD,URUN_GRUP.UGADI,URUN.URUN_AD,URUN.DOVKOD,URUN.BORC,URUN.ALACA' +
        'K,URUN.ALACAK_VPB,URUN.BORC_VPB,URUN.MIKTAR_BORC,URUN.MIKTAR_ALA' +
        'CAK from urun'
      
        'LEFT OUTER JOIN URUN_GRUP_UYE ON (URUN.URUN_KOD = URUN_GRUP_UYE.' +
        'URUN_KOD)'
      
        'LEFT OUTER JOIN URUN_GRUP ON (URUN_GRUP_UYE.URUN_GRUP_KOD=URUN_G' +
        'RUP.URUN_GRUP_KOD)')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 256
    Top = 16
  end
  object frxIBODts_UrunFiyList: TfrxIBODataset
    UserName = 'frxIBODts_UrunFiyList'
    CloseDataSource = False
    FieldAliases.Strings = (
      'OLCUBIRIM=OLCUBIRIM'
      'BIRIMFIY=BIRIMFIY'
      'SATISFIY=SATISFIY'
      'URUN_KOD=URUN_KOD'
      'UGADI=UGADI'
      'URUN_AD=URUN_AD'
      'DOVKOD=DOVKOD'
      'BORC=BORC'
      'ALACAK=ALACAK'
      'ALACAK_VPB=ALACAK_VPB'
      'BORC_VPB=BORC_VPB'
      'MIKTAR_BORC=MIKTAR_BORC'
      'MIKTAR_ALACAK=MIKTAR_ALACAK')
    DataSet = IB_Query1
    Left = 184
    Top = 41
  end
  object frxReport1: TfrxReport
    Version = '4.0.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39136.775302905100000000
    ReportOptions.LastChange = 39162.405753391210000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnBeforePrint = frxReport1BeforePrint
    Left = 184
    Top = 89
    Datasets = <
      item
        DataSet = frxIBODts_UrunFiyList
        DataSetName = 'frxIBODts_UrunFiyList'
      end>
    Variables = <>
    Style = <
      item
        Name = 'Title'
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Header'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Group header'
        Color = 16053492
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Data'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
      end
      item
        Name = 'Group footer'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Header line'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftBottom]
        Frame.Width = 2.000000000000000000
      end>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000625000000000000
      RightMargin = 5.000625000000000000
      TopMargin = 5.000625000000000000
      BottomMargin = 5.000625000000000000
      object ReportTitle1: TfrxReportTitle
        Height = 132.283550000000000000
        Top = 10.000000000000000000
        Width = 755.901275587499900000
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 755.901275587499900000
          Height = 132.283550000000000000
        end
        object Memo_Sirket_adi: TfrxMemoView
          Left = 18.897650000000000000
          Top = 22.677180000000000000
          Width = 372.575140000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #197#158'irket Ad'#196#177)
          ParentFont = False
        end
        object Memo_Rapor_Adi: TfrxMemoView
          Left = 279.173470000000000000
          Top = 60.133890000000000000
          Width = 166.299320000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #195#339'r'#195#188'n Fiyat Listesi')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 567.291900000000100000
          Top = 65.252010000000000000
          Width = 96.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Revizyon Tarihi')
          ParentFont = False
          Style = 'Header'
        end
        object Memo6: TfrxMemoView
          Left = 567.291900000000100000
          Top = 87.929190000000000000
          Width = 96.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Revizyon No:')
          ParentFont = False
          Style = 'Header'
        end
        object Memo8: TfrxMemoView
          Left = 567.291900000000000000
          Top = 14.897650000000000000
          Width = 96.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'D'#195#182'k'#195#188'man No:')
          ParentFont = False
          Style = 'Header'
        end
        object Memo12: TfrxMemoView
          Left = 567.291900000000000000
          Top = 41.472480000000000000
          Width = 96.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Yay'#196#177'n Tarihi:')
          ParentFont = False
          Style = 'Header'
        end
        object Memo_Bit_Tar: TfrxMemoView
          Left = 669.118740000000000000
          Top = 41.472480000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd.mm.yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            'Bit Tar')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        Height = 22.677180000000000000
        Top = 317.008040000000000000
        Width = 755.901275587499900000
        DataSet = frxIBODts_UrunFiyList
        DataSetName = 'frxIBODts_UrunFiyList'
        RowCount = 0
        object Shape3: TfrxShapeView
          Align = baClient
          Width = 755.901275587499900000
          Height = 22.677180000000000000
        end
        object Memo7: TfrxMemoView
          Left = 4.779530000000000000
          Top = 1.999999999999994000
          Width = 94.220470000000000000
          Height = 18.897650000000000000
          DataField = 'URUN_KOD'
          DataSet = frxIBODts_UrunFiyList
          DataSetName = 'frxIBODts_UrunFiyList'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_UrunFiyList."URUN_KOD"]')
          ParentFont = False
          Style = 'Data'
        end
        object Memo18: TfrxMemoView
          Left = 108.417440000000000000
          Top = 1.999999999999994000
          Width = 265.047310000000000000
          Height = 18.897650000000000000
          DataField = 'URUN_AD'
          DataSet = frxIBODts_UrunFiyList
          DataSetName = 'frxIBODts_UrunFiyList'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_UrunFiyList."URUN_AD"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 567.181510000000000000
          Top = 1.999999999999994000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DataField = 'BIRIMFIY'
          DataSet = frxIBODts_UrunFiyList
          DataSetName = 'frxIBODts_UrunFiyList'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxIBODts_UrunFiyList."BIRIMFIY"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 662.228820000000000000
          Top = 1.999999999999994000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DataField = 'SATISFIY'
          DataSet = frxIBODts_UrunFiyList
          DataSetName = 'frxIBODts_UrunFiyList'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxIBODts_UrunFiyList."SATISFIY"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 469.590910000000000000
          Top = 1.999999999999994000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_UrunFiyList
          DataSetName = 'frxIBODts_UrunFiyList'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_UrunFiyList."OLCUBIRIM"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 387.244280000000000000
          Top = 1.999999999999994000
          Width = 75.826840000000000000
          Height = 18.897650000000000000
          DataField = 'DOVKOD'
          DataSet = frxIBODts_UrunFiyList
          DataSetName = 'frxIBODts_UrunFiyList'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_UrunFiyList."DOVKOD"]')
          ParentFont = False
        end
        object Line10: TfrxLineView
          Left = 564.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line17: TfrxLineView
          Left = 467.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line20: TfrxLineView
          Left = 102.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line21: TfrxLineView
          Left = 382.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line6: TfrxLineView
          Left = 797.000000000000000000
          Top = -0.000000000000005940
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          Left = 659.000000000000000000
          Top = -0.000000000000005940
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
      end
      object PageFooter1: TfrxPageFooter
        Height = 18.897650000000000000
        Top = 495.677490000000000000
        Width = 755.901275587499900000
        object SysMemo3: TfrxSysMemoView
          Align = baCenter
          Left = 330.706512793750000000
          Top = -0.000000000000022510
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[PAGE#] / [TOTALPAGES#]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        Height = 31.519790000000000000
        Top = 382.157700000000000000
        Width = 755.901275587499900000
        object Shape6: TfrxShapeView
          Top = -0.000000000000022926
          Width = 1085.000000000000000000
          Height = 32.000000000000000000
        end
        object SysMemo1: TfrxSysMemoView
          Left = 139.842610000000000000
          Top = 7.559059999999965000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[LINE#]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 7.559060000000000000
          Top = 7.559059999999965000
          Width = 129.000000000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Toplam Sat'#196#177'r Say'#196#177's'#196#177)
          ParentFont = False
          Style = 'Header'
        end
      end
      object PageHeader1: TfrxPageHeader
        Height = 22.677180000000000000
        Top = 242.000000000000000000
        Width = 755.901275587499900000
        object Shape2: TfrxShapeView
          Align = baClient
          Width = 755.901275587499900000
          Height = 22.677180000000000000
        end
        object Memo31: TfrxMemoView
          Left = 108.417440000000000000
          Top = 2.000000000000000000
          Width = 270.047310000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #195#339'r'#195#188'n Ad'#196#177)
          ParentFont = False
          Style = 'Header'
        end
        object Memo4: TfrxMemoView
          Left = 4.779530000000000000
          Top = 2.000000000000000000
          Width = 94.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #195#339'r'#195#188'n Kodu')
          ParentFont = False
          Style = 'Header'
        end
        object Memo2: TfrxMemoView
          Left = 469.590910000000000000
          Top = 2.000000000000000000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #195#8211'l'#195#167#195#188' Birimi')
          ParentFont = False
          Style = 'Header'
        end
        object Memo24: TfrxMemoView
          Left = 567.181510000000000000
          Top = 2.000000000000000000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Al'#196#177#197#376' fiyat'#196#177)
          ParentFont = False
          Style = 'Header'
        end
        object Memo25: TfrxMemoView
          Left = 662.228820000000000000
          Top = 2.000000000000000000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Sat'#196#177#197#376' Fiyat'#196#177)
          ParentFont = False
          Style = 'Header'
        end
        object Line5: TfrxLineView
          Left = 797.000000000000000000
          Top = 0.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line7: TfrxLineView
          Left = 659.000000000000000000
          Top = 0.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line9: TfrxLineView
          Left = 563.000000000000000000
          Top = 1.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line16: TfrxLineView
          Left = 467.000000000000000000
          Top = 0.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line18: TfrxLineView
          Left = 382.000000000000000000
          Top = 1.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line19: TfrxLineView
          Left = 102.000000000000000000
          Top = 0.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Memo23: TfrxMemoView
          Left = 387.244280000000000000
          Top = 2.000000000000000000
          Width = 75.826840000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Para Birimi')
          ParentFont = False
          Style = 'Header'
        end
      end
      object GroupHeader1: TfrxGroupHeader
        Height = 23.000000000000000000
        Top = 183.000000000000000000
        Width = 755.901275587499900000
        Condition = '<frxIBODts_UrunFiyList."UGADI">'
        object Shape4: TfrxShapeView
          Align = baClient
          Width = 755.901275587499900000
          Height = 23.000000000000000000
        end
        object Memo13: TfrxMemoView
          Left = 5.000000000000000000
          Top = 2.000000000000000000
          Width = 94.220470000000000000
          Height = 18.900000000000000000
          DataSet = frxIBODts_UrunFiyList
          DataSetName = 'frxIBODts_UrunFiyList'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[(<frxIBODts_UrunFiyList."UGADI">)]')
          ParentFont = False
          Style = 'Data'
        end
      end
    end
  end
end
