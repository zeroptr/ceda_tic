object frmRaporGrupCBakiyeliHar: TfrmRaporGrupCBakiyeliHar
  Left = 383
  Top = 230
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Grup Baz'#305'nda Cari Bakiyeli Hareket Raporu'
  ClientHeight = 311
  ClientWidth = 242
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
    Width = 242
    Height = 271
    ActivePage = TabSheet1
    Align = alTop
    Style = tsButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object GroupBox1: TGroupBox
        Left = 0
        Top = 49
        Width = 234
        Height = 49
        Align = alTop
        Caption = 'Tarih Aral'#305#287#305
        TabOrder = 1
        object dtpIslemTar1: TDateTimePicker
          Left = 7
          Top = 18
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
          Left = 123
          Top = 18
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
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 234
        Height = 49
        Align = alTop
        Caption = 'Grup Se'#231'imi'
        TabOrder = 0
        object txtGrpKod: TEdit
          Left = 5
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
          Left = 207
          Top = 16
          Width = 18
          Height = 21
          Caption = '...'
          TabOrder = 1
          TabStop = False
          OnClick = btnCariGrpListeClick
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 98
        Width = 234
        Height = 45
        Align = alTop
        Caption = 'Para Birimi'
        TabOrder = 2
        object cmbParaBirimi: TComboBox
          Left = 57
          Top = 16
          Width = 130
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnEnter = cmbParaBirimiEnter
          OnExit = cmbParaBirimiExit
        end
      end
      object grpSube: TGroupBox
        Left = 0
        Top = 143
        Width = 234
        Height = 49
        Align = alTop
        Caption = #350'ube Ad'#305
        TabOrder = 3
        object cmbSube: TComboBox
          Left = 58
          Top = 18
          Width = 129
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnEnter = cmbParaBirimiEnter
          OnExit = cmbParaBirimiExit
        end
      end
      object chk_Sirket: TCheckBox
        Left = 16
        Top = 221
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnEnter = chk_devirEnter
        OnExit = chk_devirExit
      end
      object chk_devir: TCheckBox
        Left = 16
        Top = 198
        Width = 199
        Height = 17
        Caption = '   Raporda devir bakiyesi kullan'#305'ls'#305'n'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnEnter = chk_devirEnter
        OnExit = chk_devirExit
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 278
    Width = 242
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
    object btnCikis: TButton
      Left = 160
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = btnCikisClick
    end
    object Btn_Fast: TButton
      Left = 84
      Top = 4
      Width = 72
      Height = 25
      Caption = '&Rapor'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object qryCariGrup: TIB_Cursor
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_fidan.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 25
    Top = 115
  end
  object qryRapor: TIB_Cursor
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_fidan.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    Left = 104
    Top = 111
  end
  object qryToplam: TIB_Cursor
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_fidan.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 183
    Top = 111
  end
  object frxReport1: TfrxReport
    Version = '4.0.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.MDIChild = True
    PreviewOptions.Modal = False
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmPageWidth
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39139.806122685200000000
    ReportOptions.LastChange = 39143.680171435200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnBeforePrint = frxReport1BeforePrint
    Left = 44
    Top = 163
    Datasets = <
      item
        DataSet = frxIBOdetailg
        DataSetName = 'frxIBOdetailg'
      end
      item
        DataSet = frxIBOmasterg
        DataSetName = 'frxIBOmasterg'
      end>
    Variables = <>
    Style = <>
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
        Height = 102.047310000000000000
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 102.047310000000000000
        end
        object Memo_Sirket_adi: TfrxMemoView
          Left = 7.559060000000000000
          Top = 3.779530000000000000
          Width = 506.457020000000000000
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
          Left = 400.630180000000000000
          Top = 30.236240000000000000
          Width = 272.126160000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Grup Baz'#196#177'nda Cari Hareketleri Raporu')
          ParentFont = False
        end
        object Memo_Bit_Tar: TfrxMemoView
          Left = 967.559680000000000000
          Top = 26.456710000000000000
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
        object Memo12: TfrxMemoView
          Left = 861.732840000000000000
          Top = 26.456710000000000000
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
          Left = 861.732840000000000000
          Top = 49.133889999999990000
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
          Left = 861.732840000000000000
          Top = 71.811070000000000000
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
          Left = 861.732840000000000000
          Top = 3.779530000000000000
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
      end
      object PageFooter1: TfrxPageFooter
        Height = 22.677180000000000000
        Top = 430.866420000000000000
        Width = 1084.725110000000000000
        object Shape5: TfrxShapeView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 22.677180000000000000
        end
        object SysMemo1: TfrxSysMemoView
          Align = baCenter
          Left = 495.118430000000100000
          Top = 0.000000000000005079
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
        Height = 75.590600000000000000
        Top = 204.094620000000000000
        Width = 1084.725110000000000000
        DataSet = frxIBOmasterg
        DataSetName = 'frxIBOmasterg'
        RowCount = 0
        object Shape2: TfrxShapeView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 75.590600000000000000
        end
        object Memo1: TfrxMemoView
          Left = 3.779530000000000000
          Top = 26.456709999999980000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          DataField = 'PRM_CARI_KOD'
          DataSet = frxIBOmasterg
          DataSetName = 'frxIBOmasterg'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBOmasterg."PRM_CARI_KOD"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 147.401670000000000000
          Top = 26.456709999999980000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
          DataField = 'PRM_CARI_AD'
          DataSet = frxIBOmasterg
          DataSetName = 'frxIBOmasterg'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBOmasterg."PRM_CARI_AD"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 3.779530000000000000
          Top = 52.913419999999990000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Tarihi')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 98.267780000000000000
          Top = 52.913419999999990000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Belge T'#195#188'r'#195#188)
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 241.889920000000000000
          Top = 52.913419999999990000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Fi'#197#376' No')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 302.362400000000000000
          Top = 52.913419999999990000
          Width = 283.464750000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'A'#195#167#196#177'klama')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 589.606680000000000000
          Top = 52.913419999999990000
          Width = 98.267780000000000000
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
        object Memo20: TfrxMemoView
          Left = 691.653990000000000000
          Top = 52.913419999999990000
          Width = 98.267780000000000000
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
        object Memo21: TfrxMemoView
          Left = 3.779530000000000000
          Top = -0.000000000000008063
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
          Left = 147.401670000000000000
          Top = -0.000000000000008063
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
        object Memo29: TfrxMemoView
          Left = 793.701300000000000000
          Top = 52.913419999999990000
          Width = 117.165430000000000000
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
            'Borc Bakiyesi')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 918.425790000000000000
          Top = 52.913419999999990000
          Width = 124.724490000000000000
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
            'Alacak Bakiyesi')
          ParentFont = False
        end
      end
      object DetailData1: TfrxDetailData
        Height = 22.677180000000000000
        Top = 302.362400000000000000
        Width = 1084.725110000000000000
        DataSet = frxIBOdetailg
        DataSetName = 'frxIBOdetailg'
        RowCount = 0
        object Shape4: TfrxShapeView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 22.677180000000000000
        end
        object Memo3: TfrxMemoView
          Left = 3.779530000000000000
          Top = -0.000000000000020373
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataSet = frxIBOdetailg
          DataSetName = 'frxIBOdetailg'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd.mm.yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBOdetailg."PRM_TARIH"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 98.267780000000000000
          Top = -0.000000000000020373
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          DataField = 'CALC_BELGE_TUR'
          DataSet = frxIBOdetailg
          DataSetName = 'frxIBOdetailg'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBOdetailg."CALC_BELGE_TUR"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 241.889920000000000000
          Top = -0.000000000000020373
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          DataField = 'PRM_FIS_NO'
          DataSet = frxIBOdetailg
          DataSetName = 'frxIBOdetailg'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBOdetailg."PRM_FIS_NO"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 302.362400000000000000
          Top = -0.000000000000020373
          Width = 283.464750000000000000
          Height = 18.897650000000000000
          DataField = 'PRM_ACIKLAMA'
          DataSet = frxIBOdetailg
          DataSetName = 'frxIBOdetailg'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBOdetailg."PRM_ACIKLAMA"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 589.606680000000000000
          Top = -0.000000000000020373
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'PRM_BORC'
          DataSet = frxIBOdetailg
          DataSetName = 'frxIBOdetailg'
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
            '[frxIBOdetailg."PRM_BORC"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 691.653990000000000000
          Top = -0.000000000000020373
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'PRM_ALACAK'
          DataSet = frxIBOdetailg
          DataSetName = 'frxIBOdetailg'
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
            '[frxIBOdetailg."PRM_ALACAK"]')
          ParentFont = False
        end
        object Memo31: TfrxMemoView
          Left = 793.701300000000000000
          Top = -0.000000000000020373
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          DataField = 'PRM_CARI_BORC_BAKIYE'
          DataSet = frxIBOdetailg
          DataSetName = 'frxIBOdetailg'
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
            '[frxIBOdetailg."PRM_CARI_BORC_BAKIYE"]')
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 918.425790000000000000
          Top = -0.000000000000020373
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DataField = 'PRM_CARI_ALACAK_BAKIYE'
          DataSet = frxIBOdetailg
          DataSetName = 'frxIBOdetailg'
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
            '[frxIBOdetailg."PRM_CARI_ALACAK_BAKIYE"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        Top = 181.417440000000000000
        Width = 1084.725110000000000000
        Condition = '<frxIBOmasterg."PRM_CARI_KOD">'
      end
      object GroupFooter1: TfrxGroupFooter
        Height = 22.677180000000000000
        Top = 347.716760000000000000
        Width = 1084.725110000000000000
        object Shape3: TfrxShapeView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 22.677180000000000000
        end
        object Memo37: TfrxMemoView
          Left = 589.606680000000000000
          Top = 0.000000000000022038
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataSet = frmRaporSkAracHareketleriRaporu.frxIBODataset2
          DataSetName = 'frxIBODataset2'
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
            '[SUM(<frxIBOdetailg."PRM_BORC">,DetailData1)]')
          ParentFont = False
        end
        object Memo38: TfrxMemoView
          Left = 691.653990000000000000
          Top = 0.000000000000022038
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataSet = frmRaporSkAracHareketleriRaporu.frxIBODataset2
          DataSetName = 'frxIBODataset2'
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
            '[SUM(<frxIBOdetailg."PRM_ALACAK">,DetailData1)]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 793.701300000000000000
          Top = 0.000000000000022038
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          DataSet = frmRaporSkAracHareketleriRaporu.frxIBODataset2
          DataSetName = 'frxIBODataset2'
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
            '[SUM(<frxIBOdetailg."PRM_CARI_BORC_BAKIYE">,DetailData1)]')
          ParentFont = False
        end
        object Memo36: TfrxMemoView
          Left = 918.425790000000000000
          Top = 0.000000000000022038
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DataSet = frmRaporSkAracHareketleriRaporu.frxIBODataset2
          DataSetName = 'frxIBODataset2'
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
            '[SUM(<frxIBOdetailg."PRM_CARI_ALACAK_BAKIYE">,DetailData1)]')
          ParentFont = False
        end
      end
    end
  end
  object IB_Query3: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_fidan.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'select '
      '    prm_cari_kod,'
      '    prm_cari_ad,'
      '    prm_cari_borc,'
      '    prm_cari_alacak,'
      '    prm_cari_dev_borc,'
      '    prm_cari_dev_alacak,'
      '    prm_cari_borc_bakiye,'
      '    prm_cari_alacak_bakiye'
      ''
      ' from cari_liste(0,'#39#39','#39#39','#39#39',1,null,null)')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 112
    Top = 205
  end
  object frxIBOmasterg: TfrxIBODataset
    UserName = 'frxIBOmasterg'
    CloseDataSource = False
    FieldAliases.Strings = (
      'PRM_CARI_KOD=PRM_CARI_KOD'
      'PRM_CARI_AD=PRM_CARI_AD'
      'PRM_CARI_BORC=PRM_CARI_BORC'
      'PRM_CARI_ALACAK=PRM_CARI_ALACAK'
      'PRM_CARI_DEV_BORC=PRM_CARI_DEV_BORC'
      'PRM_CARI_DEV_ALACAK=PRM_CARI_DEV_ALACAK'
      'PRM_CARI_BORC_BAKIYE=PRM_CARI_BORC_BAKIYE'
      'PRM_CARI_ALACAK_BAKIYE=PRM_CARI_ALACAK_BAKIYE')
    DataSet = IB_Query3
    Left = 136
    Top = 249
  end
  object IB_DataSource2: TIB_DataSource
    Dataset = IB_Query3
    Left = 32
    Top = 229
  end
  object frxIBOdetailg: TfrxIBODataset
    UserName = 'frxIBOdetailg'
    CloseDataSource = False
    FieldAliases.Strings = (
      'PRM_CARI_KOD=PRM_CARI_KOD'
      'PRM_TARIH=PRM_TARIH'
      'PRM_BELGE_TUR=PRM_BELGE_TUR'
      'PRM_FIS_NO=PRM_FIS_NO'
      'PRM_ACIKLAMA=PRM_ACIKLAMA'
      'PRM_TIP=PRM_TIP'
      'PRM_BORC=PRM_BORC'
      'PRM_ALACAK=PRM_ALACAK'
      'PRM_CARI_BORC_BAKIYE=PRM_CARI_BORC_BAKIYE'
      'PRM_CARI_ALACAK_BAKIYE=PRM_CARI_ALACAK_BAKIYE'
      'PRM_CARI_DEV_BORC_BAKIYE=PRM_CARI_DEV_BORC_BAKIYE'
      'PRM_CARI_DEV_ALACAK_BAKIYE=PRM_CARI_DEV_ALACAK_BAKIYE'
      'CALC_BELGE_TUR=CALC_BELGE_TUR')
    DataSet = IB_Query4
    Left = 200
    Top = 173
  end
  object IB_Query4: TIB_Query
    CalculatedFields.Strings = (
      'CALC_BELGE_TUR=VARCHAR(30)')
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_fidan.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'select '
      '    prm_cari_kod,'
      '    prm_tarih,'
      '    prm_belge_tur,'
      '    prm_fis_no,'
      '    prm_aciklama,'
      '    prm_tip,'
      '    prm_borc,'
      '    prm_alacak,'
      '    prm_cari_borc_bakiye,'
      '    prm_cari_alacak_bakiye,'
      '    prm_cari_dev_borc_bakiye,'
      '    prm_cari_dev_alacak_bakiye'
      ''
      
        ' from cari_liste_har(1,:prm_cari_kod,null,'#39'01.01.2001'#39','#39'01.01.20' +
        '08'#39',1,1,0)')
    ColorScheme = False
    MasterSource = IB_DataSource2
    MasterLinks.Strings = (
      'prm_cari_kod=prm_cari_kod')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 196
    Top = 219
    ParamValues = (
      'PRM_CARI_KOD='
      'MLNK_PRM_CARI_KOD_0=BNK03')
  end
end
