object frmRaporCariBakiyeliHareketToplam: TfrmRaporCariBakiyeliHareketToplam
  Left = 416
  Top = 207
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cari Bakiyeli Hareket (TOPLAM)'
  ClientHeight = 313
  ClientWidth = 254
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
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 49
    Width = 254
    Height = 79
    Align = alTop
    Caption = 'Cari Kod Aral'#305#287#305
    TabOrder = 1
    object txtCariKod1: TEdit
      Left = 12
      Top = 19
      Width = 115
      Height = 21
      TabOrder = 0
      OnEnter = txtCariKod1Enter
      OnExit = txtCariKod1Exit
      OnKeyDown = txtCariKod1KeyDown
    end
    object txtCariKod2: TEdit
      Left = 132
      Top = 19
      Width = 115
      Height = 21
      TabOrder = 1
      OnEnter = txtCariKod2Enter
      OnExit = txtCariKod2Exit
      OnKeyDown = txtCariKod2KeyDown
    end
    object Button1: TButton
      Left = 13
      Top = 44
      Width = 114
      Height = 25
      Caption = '&Cari Listesi'
      TabOrder = 2
      TabStop = False
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 132
      Top = 44
      Width = 115
      Height = 25
      Caption = 'C&ari Listesi'
      TabOrder = 3
      TabStop = False
      OnClick = Button2Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 128
    Width = 254
    Height = 46
    Align = alTop
    Caption = 'Tarih Aral'#305#287#305
    TabOrder = 2
    object dtpIslemTar1: TDateTimePicker
      Left = 12
      Top = 16
      Width = 100
      Height = 21
      Date = 37554.733220983800000000
      Time = 37554.733220983800000000
      Checked = False
      TabOrder = 0
      OnEnter = dtpIslemTar1Enter
      OnExit = dtpIslemTar1Exit
    end
    object dtpIslemTar2: TDateTimePicker
      Left = 145
      Top = 15
      Width = 100
      Height = 21
      Date = 37554.733416122690000000
      Time = 37554.733416122690000000
      Checked = False
      TabOrder = 1
      OnEnter = dtpIslemTar1Enter
      OnExit = dtpIslemTar1Exit
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 280
    Width = 254
    Height = 33
    Align = alBottom
    TabOrder = 4
    object btnRapor: TButton
      Left = 6
      Top = 4
      Width = 77
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object Button3: TButton
      Left = 173
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object Btn_Fast: TButton
      Left = 89
      Top = 4
      Width = 77
      Height = 25
      Caption = '&Rapor'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object grpSube: TGroupBox
    Left = 0
    Top = 174
    Width = 254
    Height = 44
    Align = alTop
    Caption = #350'ube Ad'#305
    TabOrder = 3
    object cmbSube: TComboBox
      Left = 64
      Top = 12
      Width = 129
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnEnter = cmbSubeEnter
      OnExit = cmbSubeExit
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 218
    Width = 254
    Height = 60
    Align = alTop
    TabOrder = 5
    object chk_devir: TCheckBox
      Left = 18
      Top = 34
      Width = 199
      Height = 17
      Caption = 'Raporda devir bakiyesi kullan'#305'ls'#305'n'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnEnter = chk_devirEnter
      OnExit = chk_devirExit
    end
    object chk_Sirket: TCheckBox
      Left = 18
      Top = 10
      Width = 213
      Height = 17
      Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnEnter = chk_devirEnter
      OnExit = chk_devirExit
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 0
    Width = 254
    Height = 49
    Align = alTop
    Caption = 'Grup Se'#231'imi'
    TabOrder = 0
    object txtGrpKod: TEdit
      Left = 11
      Top = 16
      Width = 200
      Height = 21
      TabOrder = 0
      OnEnter = txtGrpKodEnter
      OnExit = txtGrpKodExit
      OnKeyDown = txtGrpKodKeyDown
      OnKeyPress = txtGrpKodKeyPress
    end
    object btnCariGrpListe: TButton
      Left = 213
      Top = 16
      Width = 19
      Height = 21
      Caption = '...'
      TabOrder = 1
      TabStop = False
      OnClick = btnCariGrpListeClick
    end
  end
  object qryCariHareket: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      
        'SELECT CARIHAR.CARI_KOD,CARI.CARI_AD,CARIHAR.TIP,SUM(CARIHAR.TUT' +
        'AR_VPB) AS TUTAR,CARI.DEVREDEN_ALACAK,CARI.DEVREDEN_BORC FROM CA' +
        'RIHAR'
      'INNER JOIN CARI ON (CARI.CARI_KOD=CARIHAR.CARI_KOD)'
      
        'GROUP BY CARIHAR.CARI_KOD,CARI.CARI_AD,CARIHAR.TIP,CARI.DEVREDEN' +
        '_ALACAK,CARI.DEVREDEN_BORC ORDER BY CARIHAR.CARI_KOD')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 140
    Top = 54
  end
  object frxReport1: TfrxReport
    Version = '4.0.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmPageWidth
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39139.806122685200000000
    ReportOptions.LastChange = 39147.687441759260000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnBeforePrint = frxReport1BeforePrint
    Left = 100
    Top = 99
    Datasets = <
      item
        DataSet = frxIBOToplam
        DataSetName = 'frxIBOToplam'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object ReportTitle1: TfrxReportTitle
        Height = 137.622140000000000000
        Top = 72.897650000000000000
        Width = 755.906000000000000000
        object Shape4: TfrxShapeView
          Top = 113.102350000000000000
          Width = 756.000000000000000000
          Height = 25.000000000000000000
        end
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 755.906000000000000000
          Height = 137.622140000000000000
        end
        object Memo_Sirket_adi: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779529999999993000
          Width = 472.441250000000000000
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
          Left = 231.133890000000000000
          Top = 37.795300000000000000
          Width = 185.196970000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Cari Hareketleri Raporu')
          ParentFont = False
        end
        object Memo_Bit_Tar: TfrxMemoView
          Left = 657.638220000000000000
          Top = 22.677180000000010000
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
          HAlign = haRight
          Memo.UTF8 = (
            'Bit Tar')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 551.811380000000000000
          Top = 22.677180000000010000
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
        object Memo11: TfrxMemoView
          Left = 551.811380000000000000
          Top = 45.354360000000000000
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
        object Memo13: TfrxMemoView
          Left = 551.811380000000000000
          Top = 68.031540000000010000
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
        object Memo14: TfrxMemoView
          Left = 551.811380000000000000
          Top = -0.000000000000001277
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
        object Memo21: TfrxMemoView
          Left = 3.779530000000000000
          Top = 117.165430000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Cari Kodu')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 122.944960000000000000
          Top = 117.165430000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Ad'#196#177' Soyad'#196#177)
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          Left = 379.953000000000000000
          Top = 117.165430000000000000
          Width = 82.929190000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            'Borc')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Left = 470.661720000000000000
          Top = 117.165430000000000000
          Width = 82.929190000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            'Alacak')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 561.370440000000000000
          Top = 117.165430000000000000
          Width = 86.708720000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            'Borc  Bakiyesi')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 653.858690000000000000
          Top = 117.165430000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            'Alacak  Bakiyesi')
          ParentFont = False
        end
        object Line6: TfrxLineView
          Left = 120.000000000000000000
          Top = 113.102350000000000000
          Height = 26.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line7: TfrxLineView
          Left = 376.000000000000000000
          Top = 113.102350000000000000
          Height = 26.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          Left = 466.000000000000000000
          Top = 113.102350000000000000
          Height = 26.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line9: TfrxLineView
          Left = 558.000000000000000000
          Top = 113.102350000000000000
          Height = 26.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line10: TfrxLineView
          Left = 652.000000000000000000
          Top = 113.102350000000000000
          Height = 26.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Memo_Batar: TfrxMemoView
          Left = 7.385900000000000000
          Top = 89.102350000000000000
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
        object Memo38: TfrxMemoView
          Left = 6.000000000000000000
          Top = 63.102350000000000000
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
          Left = 112.000000000000000000
          Top = 89.102350000000000000
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
      object PageFooter1: TfrxPageFooter
        Height = 22.677180000000000000
        Top = 445.275820000000000000
        Width = 755.906000000000000000
        object Shape5: TfrxShapeView
          Align = baClient
          Width = 755.906000000000000000
          Height = 22.677180000000000000
        end
        object SysMemo1: TfrxSysMemoView
          Align = baCenter
          Left = 330.708875000000000000
          Top = 0.000000000000010159
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8 = (
            '[PAGE#] / [TOTALPAGES#]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        Height = 26.456710000000000000
        Top = 282.992270000000000000
        Width = 755.906000000000000000
        DataSet = frxIBOToplam
        DataSetName = 'frxIBOToplam'
        RowCount = 0
        object Shape2: TfrxShapeView
          Align = baClient
          Width = 755.906000000000000000
          Height = 26.456710000000000000
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.779529999999985000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DataSet = frxIBOToplam
          DataSetName = 'frxIBOToplam'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd.mm.yyyy'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBOToplam."PRM_CARI_KOD"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 124.944960000000000000
          Top = 3.779529999999985000
          Width = 247.228510000000000000
          Height = 18.897650000000000000
          DataField = 'PRM_CARI_AD'
          DataSet = frxIBOToplam
          DataSetName = 'frxIBOToplam'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBOToplam."PRM_CARI_AD"]')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 379.953000000000000000
          Top = 3.779529999999985000
          Width = 82.929190000000000000
          Height = 18.897650000000000000
          DataField = 'HAR_BORC'
          DataSet = frxIBOToplam
          DataSetName = 'frxIBOToplam'
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
            '[frxIBOToplam."HAR_BORC"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 470.661720000000000000
          Top = 3.779529999999985000
          Width = 82.929190000000000000
          Height = 18.897650000000000000
          DataField = 'HAR_ALACAK'
          DataSet = frxIBOToplam
          DataSetName = 'frxIBOToplam'
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
            '[frxIBOToplam."HAR_ALACAK"]')
          ParentFont = False
        end
        object Memo34: TfrxMemoView
          Left = 561.370440000000000000
          Top = 3.779529999999985000
          Width = 86.708720000000000000
          Height = 18.897650000000000000
          DataField = 'HAR_BAK_BORC'
          DataSet = frxIBOToplam
          DataSetName = 'frxIBOToplam'
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
            '[frxIBOToplam."HAR_BAK_BORC"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 653.858690000000000000
          Top = 3.779529999999985000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'HAR_BAK_ALACAK'
          DataSet = frxIBOToplam
          DataSetName = 'frxIBOToplam'
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
            '[frxIBOToplam."HAR_BAK_ALACAK"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 120.000000000000000000
          Top = 1.007730000000000000
          Height = 26.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line2: TfrxLineView
          Left = 376.000000000000000000
          Top = 1.007730000000000000
          Height = 26.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line3: TfrxLineView
          Left = 466.000000000000000000
          Top = 1.007730000000000000
          Height = 26.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line4: TfrxLineView
          Left = 558.000000000000000000
          Top = 1.007730000000000000
          Height = 26.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          Left = 652.000000000000000000
          Top = 1.007730000000000000
          Height = 26.000000000000000000
          Frame.Typ = [ftLeft]
        end
      end
      object ReportSummary1: TfrxReportSummary
        Height = 22.677180000000000000
        Top = 359.921460000000000000
        Width = 755.906000000000000000
        object Shape3: TfrxShapeView
          Align = baClient
          Width = 755.906000000000000000
          Height = 22.677180000000000000
        end
        object SysMemo2: TfrxSysMemoView
          Left = 379.953000000000000000
          Top = 0.000000000000024591
          Width = 82.929190000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            '[SUM(<frxIBOToplam."HAR_BORC">,MasterData1,2)]')
          ParentFont = False
        end
        object SysMemo3: TfrxSysMemoView
          Left = 470.661720000000000000
          Top = 0.000000000000024591
          Width = 82.929190000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            '[SUM(<frxIBOToplam."HAR_ALACAK">,MasterData1,2)]')
          ParentFont = False
        end
        object SysMemo4: TfrxSysMemoView
          Left = 561.370440000000000000
          Top = 0.000000000000024591
          Width = 86.708720000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            '[SUM(<frxIBOToplam."HAR_BAK_BORC">,MasterData1,2)]')
          ParentFont = False
        end
        object SysMemo5: TfrxSysMemoView
          Left = 653.858690000000000000
          Top = 0.000000000000024591
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            '[SUM(<frxIBOToplam."HAR_BAK_ALACAK">,MasterData1)]')
          ParentFont = False
        end
        object Line11: TfrxLineView
          Left = 376.000000000000000000
          Top = 0.078540000000000000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line12: TfrxLineView
          Left = 466.000000000000000000
          Top = 0.078540000000000000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line13: TfrxLineView
          Left = 558.000000000000000000
          Top = 0.078540000000000000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line14: TfrxLineView
          Left = 652.000000000000000000
          Top = 0.078540000000000000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
      end
    end
  end
  object IB_Query1: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    FieldsDisplayWidth.Strings = (
      'PRM_CARI_BORC=80'
      'PRM_CARI_ALACAK=85'
      'PRM_CARI_DEV_BORC=95'
      'PRM_CARI_DEV_ALACAK=95'
      'PRM_CARI_BORC_BAKIYE=86'
      'PRM_CARI_ALACAK_BAKIYE=113')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'select'
      '    cari_liste.prm_cari_kod,'
      '    cari_liste.prm_cari_ad,'
      '    sum(cari_liste_har.prm_borc) as har_borc,'
      '    sum(cari_liste_har.prm_alacak) as har_alacak,'
      '    (CASE'
      
        '    WHEN (sum(cari_liste_har.prm_borc)>sum(cari_liste_har.prm_al' +
        'acak)) THEN'
      '    sum(cari_liste_har.prm_borc)-sum(cari_liste_har.prm_alacak)'
      '    ELSE 0'
      '    END) har_bak_borc'
      '    ,(CASE'
      
        '    WHEN (sum(cari_liste_har.prm_alacak)>sum(cari_liste_har.prm_' +
        'borc)) THEN'
      '    sum(cari_liste_har.prm_alacak)-sum(cari_liste_har.prm_borc)'
      '    ELSE 0'
      '    END) har_bak_alacak'
      ''
      'from cari_liste(1,null,null,null,1,null)'
      ''
      'left outer join'
      'cari_liste_har(1,null,null,'#39'01.01.2001'#39','#39'01.01.2008'#39',2,1)'
      'on (cari_liste.prm_cari_kod=cari_liste_har.prm_Cari_kod)'
      ''
      'group by'
      '    cari_liste.prm_cari_kod,'
      '    cari_liste.prm_cari_ad'
      ''
      'having (not sum(cari_liste_har.prm_borc) is null)'
      'or (not sum(cari_liste_har.prm_alacak) is null)')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 160
    Top = 120
  end
  object frxIBOToplam: TfrxIBODataset
    UserName = 'frxIBOToplam'
    CloseDataSource = False
    FieldAliases.Strings = (
      'PRM_CARI_KOD=PRM_CARI_KOD'
      'PRM_CARI_AD=PRM_CARI_AD'
      'HAR_BORC=HAR_BORC'
      'HAR_ALACAK=HAR_ALACAK'
      'HAR_BAK_BORC=HAR_BAK_BORC'
      'HAR_BAK_ALACAK=HAR_BAK_ALACAK')
    DataSet = IB_Query1
    Left = 216
    Top = 120
  end
end
