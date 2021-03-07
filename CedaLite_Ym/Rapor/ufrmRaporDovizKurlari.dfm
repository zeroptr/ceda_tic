object frmRaporDovizKurlari: TfrmRaporDovizKurlari
  Left = 409
  Top = 204
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'D'#246'viz Kurlar'#305' Raporu'
  ClientHeight = 200
  ClientWidth = 218
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
    Width = 218
    Height = 163
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object chk_Sirket: TCheckBox
        Left = 0
        Top = 110
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnEnter = chk_SirketEnter
        OnExit = chk_SirketExit
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 210
        Height = 55
        Align = alTop
        Caption = 'Para Birimi'
        TabOrder = 0
        object cmbParaBirimi: TComboBox
          Left = 6
          Top = 20
          Width = 193
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnEnter = cmbParaBirimiEnter
          OnExit = cmbParaBirimiExit
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 55
        Width = 210
        Height = 46
        Align = alTop
        Caption = 'Tarih Aral'#305#287#305
        TabOrder = 1
        object IslemTar1: TDateTimePicker
          Left = 8
          Top = 16
          Width = 91
          Height = 21
          Date = 37554.733220983800000000
          Time = 37554.733220983800000000
          Checked = False
          TabOrder = 0
          OnEnter = IslemTar1Enter
          OnExit = IslemTar1Exit
        end
        object IslemTar2: TDateTimePicker
          Left = 113
          Top = 15
          Width = 88
          Height = 21
          Date = 37554.733416122690000000
          Time = 37554.733416122690000000
          Checked = False
          TabOrder = 1
          OnEnter = IslemTar1Enter
          OnExit = IslemTar1Exit
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 167
    Width = 218
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 4
      Top = 4
      Width = 69
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object Button3: TButton
      Left = 160
      Top = 4
      Width = 51
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object btn_Fast: TButton
      Left = 81
      Top = 4
      Width = 72
      Height = 25
      Caption = 'Rapor Olu'#351'tur'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object qryDoviz: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 60
    Top = 70
  end
  object qryRapor: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 122
    Top = 84
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
    ReportOptions.LastChange = 39162.439497604170000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnBeforePrint = frxReport1BeforePrint
    Left = 104
    Top = 1
    Datasets = <
      item
        DataSet = frxIBODts_DovKur
        DataSetName = 'frxIBODts_DovKur'
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
        Top = 20.000000000000000000
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
            'D'#195#182'viz Kurlar'#196#177' Listesi')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 567.291900000000100000
          Top = 64.252010000000000000
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
          Top = 86.929190000000000000
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
        object Memo_Batar: TfrxMemoView
          Left = 16.385900000000000000
          Top = 105.000000000000000000
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
            'Bas Tar')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 14.000000000000000000
          Top = 79.000000000000000000
          Width = 134.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Rapor Tarihi Aral'#196#177#196#376#196#177)
          ParentFont = False
          Style = 'Header'
        end
        object Memo_Bitar: TfrxMemoView
          Left = 120.000000000000000000
          Top = 105.000000000000000000
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
        object Memo3: TfrxMemoView
          Left = 278.000000000000000000
          Top = 103.000000000000000000
          Width = 58.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Kur Tipi:')
          ParentFont = False
          Style = 'Header'
        end
        object Memo_Kur_Tip: TfrxMemoView
          Left = 341.000000000000000000
          Top = 103.000000000000000000
          Width = 58.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Style = 'Header'
        end
      end
      object MasterData1: TfrxMasterData
        Height = 22.677180000000000000
        Top = 312.008040000000000000
        Width = 755.901275587499900000
        DataSet = frxIBODts_DovKur
        DataSetName = 'frxIBODts_DovKur'
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
          DataField = 'DOVKOD'
          DataSet = frxIBODts_DovKur
          DataSetName = 'frxIBODts_DovKur'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_DovKur."DOVKOD"]')
          ParentFont = False
          Style = 'Data'
        end
        object Memo18: TfrxMemoView
          Left = 108.417440000000000000
          Top = 1.999999999999994000
          Width = 99.047310000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_DovKur
          DataSetName = 'frxIBODts_DovKur'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd.mm.yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_DovKur."TARIH"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 466.181510000000000000
          Top = 1.999999999999994000
          Width = 118.826840000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_DovKur
          DataSetName = 'frxIBODts_DovKur'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxIBODts_DovKur."EF_ALISKUR"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 592.228820000000000000
          Top = 1.999999999999994000
          Width = 118.826840000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_DovKur
          DataSetName = 'frxIBODts_DovKur'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxIBODts_DovKur."EF_SATISKUR"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 339.590910000000000000
          Top = 1.999999999999994000
          Width = 118.826840000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_DovKur
          DataSetName = 'frxIBODts_DovKur'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxIBODts_DovKur."SATISKUR"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 215.244280000000000000
          Top = 1.999999999999994000
          Width = 118.826840000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_DovKur
          DataSetName = 'frxIBODts_DovKur'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxIBODts_DovKur."ALISKUR"]')
          ParentFont = False
        end
        object Line10: TfrxLineView
          Left = 462.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line17: TfrxLineView
          Left = 337.000000000000000000
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
          Left = 211.000000000000000000
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
          Left = 588.000000000000000000
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
        Top = 246.000000000000000000
        Width = 755.901275587499900000
        object Shape2: TfrxShapeView
          Align = baClient
          Width = 755.901275587499900000
          Height = 22.677180000000000000
        end
        object Memo31: TfrxMemoView
          Left = 108.417440000000000000
          Top = 2.000000000000000000
          Width = 99.047310000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Tarih')
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
            'D'#195#182'viz Tipi')
          ParentFont = False
          Style = 'Header'
        end
        object Memo2: TfrxMemoView
          Left = 341.590910000000000000
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
            'Sat'#196#177#197#376' Kuru')
          ParentFont = False
          Style = 'Header'
        end
        object Memo24: TfrxMemoView
          Left = 467.181510000000000000
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
            'Efektif Al'#196#177#197#376' Kuru')
          ParentFont = False
          Style = 'Header'
        end
        object Memo25: TfrxMemoView
          Left = 594.228820000000000000
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
            'Efektif Al'#196#177#197#376' Kuru')
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
          Left = 588.000000000000000000
          Top = 0.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line9: TfrxLineView
          Left = 462.000000000000000000
          Top = 1.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line16: TfrxLineView
          Left = 337.000000000000000000
          Top = 1.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line18: TfrxLineView
          Left = 211.000000000000000000
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
          Left = 216.244280000000000000
          Top = 2.000000000000000000
          Width = 118.826840000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Al'#196#177#197#376' Kuru')
          ParentFont = False
          Style = 'Header'
        end
      end
    end
  end
  object frxIBODts_DovKur: TfrxIBODataset
    UserName = 'frxIBODts_DovKur'
    CloseDataSource = False
    FieldAliases.Strings = (
      'DOVKOD=DOVKOD'
      'TARIH=TARIH'
      'ALISKUR=ALISKUR'
      'SATISKUR=SATISKUR'
      'EF_ALISKUR=EF_ALISKUR'
      'EF_SATISKUR=EF_SATISKUR'
      'DB_KEY=DB_KEY')
    DataSet = IB_Query1
    Left = 96
    Top = 33
  end
  object IB_Query1: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      
        'SELECT DOVKUR.DOVKOD,DOVKUR.TARIH,DOVKUR.ALISKUR,DOVKUR.SATISKUR' +
        ',DOVKUR.EF_ALISKUR,DOVKUR.EF_SATISKUR FROM DOVKUR')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 168
    Top = 8
  end
end
