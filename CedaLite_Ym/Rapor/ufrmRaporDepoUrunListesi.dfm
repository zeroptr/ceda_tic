object frmRaporDepoUrunListesi: TfrmRaporDepoUrunListesi
  Left = 308
  Top = 235
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Depo '#220'r'#252'n Listesi'
  ClientHeight = 225
  ClientWidth = 299
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
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 299
    Height = 187
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object chk_Sirket: TCheckBox
        Left = 50
        Top = 136
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
        Width = 291
        Height = 49
        Align = alTop
        Caption = 'Depo Kodu'
        TabOrder = 0
        object txtDepoKod: TEdit
          Left = 8
          Top = 14
          Width = 167
          Height = 21
          TabOrder = 0
          OnEnter = txtDepoKodEnter
          OnExit = txtDepoKodExit
          OnKeyDown = txtDepoKodKeyDown
          OnKeyPress = txtDepoKodKeyPress
        end
        object btnDepo: TButton
          Left = 181
          Top = 14
          Width = 102
          Height = 21
          Caption = 'Depo Listesi'
          TabOrder = 1
          TabStop = False
          OnClick = btnDepoClick
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 49
        Width = 291
        Height = 79
        Align = alTop
        Caption = #220'r'#252'n Kod Aral'#305#287#305
        TabOrder = 1
        object txtUrunKod1: TEdit
          Left = 6
          Top = 16
          Width = 133
          Height = 21
          TabOrder = 0
          OnEnter = txtDepoKodEnter
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
          OnEnter = txtDepoKodEnter
          OnExit = txtUrunKod2Exit
          OnKeyDown = txtUrunKod2KeyDown
          OnKeyPress = txtUrunKod2KeyPress
        end
        object Button4: TButton
          Left = 6
          Top = 42
          Width = 133
          Height = 25
          Caption = '&'#220'r'#252'n Listesi'
          TabOrder = 2
          TabStop = False
          OnClick = Button1Click
        end
        object Button5: TButton
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
    end
    object TabSheet2: TTabSheet
      Caption = 'Ko'#351'ullar'
      ImageIndex = 1
      object Label3: TLabel
        Left = 6
        Top = 6
        Width = 40
        Height = 13
        Caption = 'S'#305'ralama'
      end
      object cmb_sirala: TComboBox
        Left = 7
        Top = 20
        Width = 288
        Height = 21
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = #220'r'#252'n Koduna G'#246're'
        Items.Strings = (
          #220'r'#252'n Koduna G'#246're'
          #220'r'#252'n Ad'#305'na G'#246're')
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 192
    Width = 299
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 5
      Top = 4
      Width = 92
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object Button3: TButton
      Left = 216
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object btn_Fast: TButton
      Left = 113
      Top = 4
      Width = 88
      Height = 25
      Caption = 'Rapor Olu'#351'tur'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object qryUrunHareket: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      '')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 106
    Top = 50
  end
  object qryDepoUrun: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 196
    Top = 50
  end
  object frxIBODts_DepoUrun: TfrxIBODataset
    UserName = 'frxIBODts_DepoUrun'
    CloseDataSource = False
    FieldAliases.Strings = (
      'URUN_AD=URUN_AD'
      'URUN_KOD=URUN_KOD'
      'DOVKOD=DOVKOD'
      'BORC=BORC'
      'ALACAK=ALACAK'
      'BORC_VPB=BORC_VPB'
      'ALACAK_VPB=ALACAK_VPB'
      'MIKTAR_BORC=MIKTAR_BORC'
      'MIKTAR_ALACAK=MIKTAR_ALACAK'
      'CALC_BELGE_TUR=CALC_BELGE_TUR')
    DataSet = IB_Query1
    Left = 136
    Top = 97
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
    ReportOptions.LastChange = 39160.727319328700000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnBeforePrint = frxReport1BeforePrint
    Left = 136
    Top = 145
    Datasets = <
      item
        DataSet = frxIBODts_DepoUrun
        DataSetName = 'frxIBODts_DepoUrun'
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
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object ReportTitle1: TfrxReportTitle
        Height = 132.283550000000000000
        Top = 22.000000000000000000
        Width = 1084.725110000000000000
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 132.283550000000000000
        end
        object Memo_Sirket_adi: TfrxMemoView
          Left = 18.897650000000000000
          Top = 22.677180000000000000
          Width = 521.575140000000000000
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
          Left = 396.173470000000000000
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
            'Depo '#195#339'r'#195#188'n Listesi')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 869.291900000000000000
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
          Left = 869.291900000000000000
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
          Left = 869.291900000000000000
          Top = 18.897650000000000000
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
          Left = 869.291900000000000000
          Top = 45.472480000000010000
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
          Left = 971.118740000000000000
          Top = 45.472480000000010000
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
        object Memo_Depo_kod: TfrxMemoView
          Left = 9.000000000000000000
          Top = 101.000000000000000000
          Width = 94.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '')
          ParentFont = False
          Style = 'Data'
        end
        object Memo_Depo_Ad: TfrxMemoView
          Left = 175.637910000000000000
          Top = 101.000000000000000000
          Width = 309.047310000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        Height = 22.677180000000000000
        Top = 304.008040000000000000
        Width = 1084.725110000000000000
        DataSet = frxIBODts_DepoUrun
        DataSetName = 'frxIBODts_DepoUrun'
        RowCount = 0
        object Shape3: TfrxShapeView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 22.677180000000000000
        end
        object Memo7: TfrxMemoView
          Left = 4.779530000000000000
          Top = 1.999999999999994000
          Width = 113.220470000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_DepoUrun
          DataSetName = 'frxIBODts_DepoUrun'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_DepoUrun."URUN_KOD"]')
          ParentFont = False
          Style = 'Data'
        end
        object Memo18: TfrxMemoView
          Left = 124.417440000000000000
          Top = 1.999999999999994000
          Width = 295.047310000000000000
          Height = 18.897650000000000000
          DataField = 'URUN_AD'
          DataSet = frxIBODts_DepoUrun
          DataSetName = 'frxIBODts_DepoUrun'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_DepoUrun."URUN_AD"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 605.181510000000000000
          Top = 1.999999999999994000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_DepoUrun
          DataSetName = 'frxIBODts_DepoUrun'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_DepoUrun."ALACAK"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 704.228820000000000000
          Top = 1.999999999999994000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_DepoUrun
          DataSetName = 'frxIBODts_DepoUrun'
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
            '[frxIBODts_DepoUrun."BORC_VPB"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 508.590910000000000000
          Top = 2.999999999999994000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_DepoUrun
          DataSetName = 'frxIBODts_DepoUrun'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_DepoUrun."BORC"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 801.583180000000000000
          Top = 1.999999999999994000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_DepoUrun
          DataSetName = 'frxIBODts_DepoUrun'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_DepoUrun."ALACAK_VPB"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 992.630490000000000000
          Top = 1.999999999999994000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_DepoUrun
          DataSetName = 'frxIBODts_DepoUrun'
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
            '[frxIBODts_DepoUrun."MIKTAR_ALACAK"]')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Left = 990.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line21: TfrxLineView
          Left = 423.000000000000000000
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
          Left = 699.000000000000000000
          Top = -0.000000000000005940
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Memo11: TfrxMemoView
          Left = 896.000000000000000000
          Top = 1.991960000000000000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_DepoUrun
          DataSetName = 'frxIBODts_DepoUrun'
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
            '[frxIBODts_DepoUrun."MIKTAR_BORC"]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 893.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line10: TfrxLineView
          Left = 601.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line17: TfrxLineView
          Left = 506.000000000000000000
          Top = 0.991960000000000000
          Height = 23.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Memo16: TfrxMemoView
          Left = 427.244280000000000000
          Top = 1.999999999999994000
          Width = 75.826840000000000000
          Height = 18.897650000000000000
          DataField = 'DOVKOD'
          DataSet = frxIBODts_DepoUrun
          DataSetName = 'frxIBODts_DepoUrun'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_DepoUrun."DOVKOD"]')
          ParentFont = False
        end
        object Line20: TfrxLineView
          Left = 121.000000000000000000
          Top = 0.991960000000000000
          Height = 23.000000000000000000
          Frame.Typ = [ftLeft]
        end
      end
      object PageFooter1: TfrxPageFooter
        Height = 18.897650000000000000
        Top = 495.677490000000000000
        Width = 1084.725110000000000000
        object SysMemo3: TfrxSysMemoView
          Align = baCenter
          Left = 495.118430000000100000
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
        Top = 388.157700000000000000
        Width = 1084.725110000000000000
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
        object Shape4: TfrxShapeView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 31.519790000000000000
        end
      end
      object PageHeader1: TfrxPageHeader
        Height = 22.677180000000000000
        Top = 235.000000000000000000
        Width = 1084.725110000000000000
        object Shape2: TfrxShapeView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 22.677180000000000000
        end
        object Memo21: TfrxMemoView
          Left = 896.630490000000000000
          Top = 2.000000000000000000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DataSet = frmRaporSkAracHareketleriRaporu.frxIBODataset1
          DataSetName = 'frxIBODataset1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Miktar Borc')
          ParentFont = False
          Style = 'Header'
        end
        object Memo17: TfrxMemoView
          Left = 801.583180000000000000
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
            'Alacak Vpb')
          ParentFont = False
          Style = 'Header'
        end
        object Memo31: TfrxMemoView
          Left = 124.417440000000000000
          Top = 3.000000000000000000
          Width = 122.047310000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #195#339'r'#195#188'n Ad')
          ParentFont = False
          Style = 'Header'
        end
        object Memo4: TfrxMemoView
          Left = 2.779530000000000000
          Top = 2.000000000000000000
          Width = 114.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #195#339'r'#195#188'n Kod')
          ParentFont = False
          Style = 'Header'
        end
        object Memo2: TfrxMemoView
          Left = 508.590910000000000000
          Top = 3.000000000000000000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Borc')
          ParentFont = False
          Style = 'Header'
        end
        object Memo24: TfrxMemoView
          Left = 605.181510000000000000
          Top = 3.000000000000000000
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
            'Alacak')
          ParentFont = False
          Style = 'Header'
        end
        object Memo25: TfrxMemoView
          Left = 704.228820000000000000
          Top = 3.000000000000000000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DataSet = frmRaporSkAracHareketleriRaporu.frxIBODataset1
          DataSetName = 'frxIBODataset1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Borc Vpb')
          ParentFont = False
          Style = 'Header'
        end
        object Line9: TfrxLineView
          Left = 601.000000000000000000
          Top = 0.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line16: TfrxLineView
          Left = 506.000000000000000000
          Top = 1.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line18: TfrxLineView
          Left = 423.000000000000000000
          Top = 0.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Memo23: TfrxMemoView
          Left = 427.244280000000000000
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
        object Memo3: TfrxMemoView
          Left = 993.000000000000000000
          Top = 2.141619999999989000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DataSet = frmRaporSkAracHareketleriRaporu.frxIBODataset1
          DataSetName = 'frxIBODataset1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Miktar Alacak')
          ParentFont = False
          Style = 'Header'
        end
        object Line1: TfrxLineView
          Left = 990.000000000000000000
          Top = 2.141619999999989000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line3: TfrxLineView
          Left = 893.000000000000000000
          Top = 0.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          Left = 797.000000000000000000
          Top = 0.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line7: TfrxLineView
          Left = 699.000000000000000000
          Top = 0.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line19: TfrxLineView
          Left = 121.000000000000000000
          Top = 0.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
      end
    end
  end
  object IB_Query1: TIB_Query
    CalculatedFields.Strings = (
      'CALC_BELGE_TUR=CHAR(100)')
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      
        'SELECT URUN.URUN_AD,URUN.URUN_KOD,URUN.DOVKOD,DEPOURUN.BORC,DEPO' +
        'URUN.ALACAK,DEPOURUN.BORC_VPB,DEPOURUN.ALACAK_VPB,DEPOURUN.MIKTA' +
        'R_BORC,DEPOURUN.MIKTAR_ALACAK'
      ' FROM DEPOURUN '
      'LEFT OUTER JOIN URUN ON (URUN.URUN_KOD = DEPOURUN.URUN_KOD)')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 200
    Top = 96
  end
end
