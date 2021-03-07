object frmRaporCariAylikBA: TfrmRaporCariAylikBA
  Left = 338
  Top = 138
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Ay Baz'#305'nda Cari Bor'#231' Alacak Raporu'
  ClientHeight = 299
  ClientWidth = 278
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 278
    Height = 265
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object chk_Sirket: TCheckBox
        Left = 36
        Top = 177
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnEnter = chk_SirketEnter
        OnExit = chk_SirketExit
      end
      object grb1: TGroupBox
        Left = 0
        Top = 0
        Width = 270
        Height = 73
        Align = alTop
        Caption = 'Cari Kod Aral'#305#287#305
        TabOrder = 0
        object txtCariKod1: TEdit
          Left = 11
          Top = 16
          Width = 122
          Height = 21
          TabOrder = 0
          OnEnter = txtCariKod1Enter
          OnExit = txtCariKod1Exit
          OnKeyDown = txtCariKod1KeyDown
          OnKeyPress = txtCariKod1KeyPress
        end
        object txtCariKod2: TEdit
          Left = 138
          Top = 16
          Width = 121
          Height = 21
          TabOrder = 1
          OnEnter = txtCariKod1Enter
          OnExit = txtCariKod2Exit
          OnKeyDown = txtCariKod2KeyDown
          OnKeyPress = txtCariKod1KeyPress
        end
        object btnCariListe1: TButton
          Left = 12
          Top = 38
          Width = 121
          Height = 25
          Caption = '&Cari Listesi'
          TabOrder = 2
          TabStop = False
          OnClick = btnCariListe1Click
        end
        object btnCariListe2: TButton
          Left = 138
          Top = 38
          Width = 121
          Height = 25
          Caption = 'C&ari Listesi'
          TabOrder = 3
          TabStop = False
          OnClick = btnCariListe2Click
        end
      end
      object grb2: TGroupBox
        Left = 0
        Top = 73
        Width = 270
        Height = 48
        Align = alTop
        Caption = 'Cari Kod'
        TabOrder = 1
        object txtCariKod3: TEdit
          Left = 8
          Top = 16
          Width = 119
          Height = 21
          TabOrder = 0
          OnEnter = txtCariKod1Enter
          OnExit = txtCariKod3Exit
          OnKeyDown = txtCariKod3KeyDown
          OnKeyPress = txtCariKod1KeyPress
        end
        object btnCariListe3: TButton
          Left = 146
          Top = 14
          Width = 119
          Height = 25
          Caption = '&Cari Listesi'
          TabOrder = 1
          TabStop = False
          OnClick = btnCariListe3Click
        end
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 121
        Width = 270
        Height = 52
        Align = alTop
        TabOrder = 2
        object cmbParaBirimi: TComboBox
          Left = 9
          Top = 18
          Width = 130
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnEnter = cmbParaBirimiEnter
          OnExit = cmbParaBirimiExit
        end
        object cmbAy: TComboBox
          Left = 142
          Top = 17
          Width = 123
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 1
          Text = 'Ocak'
          OnEnter = cmbParaBirimiEnter
          OnExit = cmbParaBirimiExit
          Items.Strings = (
            'Ocak'
            #350'ubat'
            'Mart'
            'Nisan'
            'May'#305's'
            'Haziran'
            'Temmuz'
            'A'#287'ustos'
            'Eyl'#252'l'
            'Ekim'
            'Kas'#305'm'
            'Aral'#305'k')
        end
      end
      object cb_Devir: TCheckBox
        Left = 36
        Top = 198
        Width = 149
        Height = 17
        Caption = 'Devir Bakiyelerini Dahil Et'
        TabOrder = 4
        OnEnter = chk_SirketEnter
        OnExit = chk_SirketExit
      end
      object chk_Sefer: TCheckBox
        Left = 36
        Top = 217
        Width = 157
        Height = 17
        Caption = 'Sefer ve Mazot Kay'#305'tlar'#305' Dahil'
        TabOrder = 5
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Ko'#351'ullar'
      ImageIndex = 1
      object Label5: TLabel
        Left = 8
        Top = 20
        Width = 62
        Height = 13
        Caption = 'Gruplamalar :'
      end
      object cmbGrup: TComboBox
        Left = 76
        Top = 16
        Width = 197
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = #304'ki Cari Aras'#305'nda Tek Bir Ay '#304#231'in'
        OnChange = cmbGrupChange
        Items.Strings = (
          #304'ki Cari Aras'#305'nda Tek Bir Ay '#304#231'in'
          'Tek Bir Carinin B'#252't'#252'n Aylar'#305)
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 266
    Width = 278
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 4
      Top = 4
      Width = 77
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object Button3: TButton
      Left = 198
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object btn_Fast: TButton
      Left = 97
      Top = 4
      Width = 88
      Height = 25
      Caption = 'Rapor Olu'#351'tur'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object qryRapor: TIB_Cursor
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    Left = 126
    Top = 100
  end
  object qryRapora: TIB_Cursor
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    Left = 174
    Top = 148
  end
  object frxIBODts_Cari_Ay: TfrxIBODataset
    UserName = 'frxIBODts_Cari_Ay'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CARI_KOD=CARI_KOD'
      'CARI_AD=CARI_AD'
      'AY=AY'
      'BORC=BORC'
      'ALACAK=ALACAK'
      'BAKIYE=BAKIYE'
      'TIP=TIP')
    DataSet = IB_Query1
    Left = 48
    Top = 57
  end
  object frxReport1: TfrxReport
    Version = '4.3'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39136.775302905100000000
    ReportOptions.LastChange = 39162.416805729200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnBeforePrint = frxReport1BeforePrint
    Left = 48
    Top = 105
    Datasets = <
      item
        DataSet = frxIBODts_Cari_Ay
        DataSetName = 'frxIBODts_Cari_Ay'
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
        Top = 16.000000000000000000
        Width = 755.901275587500000000
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 755.901275587500000000
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
          Left = 339.173470000000000000
          Top = 60.133890000000000000
          Width = 102.299320000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Cari Ayl'#196#177'k Liste')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 567.291900000000000000
          Top = 60.252010000000000000
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
          Left = 567.291900000000000000
          Top = 82.929190000000000000
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
        object Memo1: TfrxMemoView
          Left = 20.000000000000000000
          Top = 99.000000000000000000
          Width = 26.299320000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Ay:')
          ParentFont = False
        end
        object Memo_ay: TfrxMemoView
          Left = 54.000000000000000000
          Top = 99.000000000000000000
          Width = 123.299320000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        Height = 22.677180000000000000
        Top = 251.000000000000000000
        Width = 755.901275587500000000
        DataSet = frxIBODts_Cari_Ay
        DataSetName = 'frxIBODts_Cari_Ay'
        RowCount = 0
        object Shape3: TfrxShapeView
          Align = baClient
          Width = 755.901275587500000000
          Height = 22.677180000000000000
        end
        object Memo7: TfrxMemoView
          Left = 1.779530000000000000
          Top = 2.000000000000000000
          Width = 107.826840000000000000
          Height = 18.897650000000000000
          DataField = 'CARI_KOD'
          DataSet = frxIBODts_Cari_Ay
          DataSetName = 'frxIBODts_Cari_Ay'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_Cari_Ay."CARI_KOD"]')
          ParentFont = False
          Style = 'Data'
        end
        object Memo18: TfrxMemoView
          Left = 120.417440000000000000
          Top = 1.999999999999990000
          Width = 207.826840000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_Cari_Ay
          DataSetName = 'frxIBODts_Cari_Ay'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_Cari_Ay."CARI_AD"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 547.181510000000000000
          Top = 1.999999999999990000
          Width = 100.826840000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_Cari_Ay
          DataSetName = 'frxIBODts_Cari_Ay'
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
            '[frxIBODts_Cari_Ay."BAKIYE"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 653.228820000000000000
          Top = 1.999999999999990000
          Width = 100.826840000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_Cari_Ay
          DataSetName = 'frxIBODts_Cari_Ay'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_Cari_Ay."TIP"]')
          ParentFont = False
        end
        object frxMemoView1: TfrxMemoView
          Left = 440.590910000000000000
          Top = 1.999999999999990000
          Width = 100.826840000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_Cari_Ay
          DataSetName = 'frxIBODts_Cari_Ay'
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
            '[frxIBODts_Cari_Ay."ALACAK"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 334.244280000000000000
          Top = 1.999999999999990000
          Width = 100.826840000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_Cari_Ay
          DataSetName = 'frxIBODts_Cari_Ay'
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
            '[frxIBODts_Cari_Ay."BORC"]')
          ParentFont = False
        end
        object Line10: TfrxLineView
          Left = 438.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line17: TfrxLineView
          Left = 331.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line20: TfrxLineView
          Left = 113.000000000000000000
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
          Left = 544.000000000000000000
          Top = 0.999999999999994000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line2: TfrxLineView
          Left = 650.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
      end
      object PageFooter1: TfrxPageFooter
        Height = 18.897650000000000000
        Top = 334.000000000000000000
        Width = 755.901275587500000000
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
      object PageHeader1: TfrxPageHeader
        Height = 22.677180000000000000
        Top = 168.000000000000000000
        Width = 755.901275587500000000
        object Shape2: TfrxShapeView
          Align = baClient
          Width = 755.901275587500000000
          Height = 22.677180000000000000
        end
        object Memo31: TfrxMemoView
          Left = 120.417440000000000000
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
            'Cari Ad'#196#177)
          ParentFont = False
          Style = 'Header'
        end
        object Memo4: TfrxMemoView
          Left = 2.779530000000000000
          Top = 2.000000000000000000
          Width = 107.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Cari Kod')
          ParentFont = False
          Style = 'Header'
        end
        object Memo2: TfrxMemoView
          Left = 440.590910000000000000
          Top = 2.000000000000000000
          Width = 100.826840000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
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
        object Memo24: TfrxMemoView
          Left = 547.181510000000000000
          Top = 2.000000000000000000
          Width = 100.826840000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Bakiye')
          ParentFont = False
          Style = 'Header'
        end
        object Memo25: TfrxMemoView
          Left = 653.228820000000000000
          Top = 2.000000000000000000
          Width = 100.826840000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Borc/Alacak')
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
          Left = 544.000000000000000000
          Top = 0.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line9: TfrxLineView
          Left = 438.000000000000000000
          Top = 1.141619999999990000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line16: TfrxLineView
          Left = 331.000000000000000000
          Top = 1.141619999999990000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line19: TfrxLineView
          Left = 113.000000000000000000
          Top = 0.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Memo23: TfrxMemoView
          Left = 334.244280000000000000
          Top = 2.000000000000000000
          Width = 100.826840000000000000
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
        object Line1: TfrxLineView
          Left = 650.000000000000000000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
      end
    end
  end
  object IB_Query1: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'select * from CARI_AY_LISTE('
      ':PRM_YIL,'
      ':PRM_AY,'
      ':PRM_DOVKOD,'
      ':PRM_DEVIR,'
      ':PRM_SEFER_MAZOT,'
      ':PRM_BAS_TAR,'
      ':PRM_BIT_TAR)')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 120
    Top = 72
    ParamValues = ()
  end
end
