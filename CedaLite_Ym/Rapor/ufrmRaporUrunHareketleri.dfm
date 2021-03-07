object frmRaporUrunHareketleri: TfrmRaporUrunHareketleri
  Left = 343
  Top = 207
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #220'r'#252'n Hareketleri Listesi'
  ClientHeight = 355
  ClientWidth = 286
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
    Width = 286
    Height = 321
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object Label1: TLabel
        Left = 8
        Top = 248
        Width = 58
        Height = 13
        Caption = 'Hareket Tipi'
      end
      object chkSirket: TCheckBox
        Left = 42
        Top = 274
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnEnter = chkSirketEnter
        OnExit = chkSirketExit
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 278
        Height = 43
        Align = alTop
        Caption = #220'r'#252'n Kod Aral'#305#287#305
        TabOrder = 0
        object txtUrunKod1: TEdit
          Left = 6
          Top = 16
          Width = 101
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
          Width = 101
          Height = 21
          TabOrder = 2
          OnEnter = txtUrunKod1Enter
          OnExit = txtUrunKod1Exit
          OnKeyDown = txtUrunKod2KeyDown
          OnKeyPress = txtUrunKod1KeyPress
        end
        object btnUrunKod1: TButton
          Left = 108
          Top = 16
          Width = 19
          Height = 21
          Caption = '...'
          TabOrder = 1
          TabStop = False
          OnClick = btnUrunKod1Click
        end
        object btnUrunKod2: TButton
          Left = 252
          Top = 16
          Width = 19
          Height = 21
          Caption = '...'
          TabOrder = 3
          TabStop = False
          OnClick = btnUrunKod2Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 187
        Width = 278
        Height = 48
        Caption = 'Tarih Aral'#305#287#305
        TabOrder = 1
        object dtpTarih1: TDateTimePicker
          Left = 6
          Top = 18
          Width = 121
          Height = 21
          Date = 38121.617936157410000000
          Time = 38121.617936157410000000
          TabOrder = 0
          OnEnter = dtpTarih1Enter
          OnExit = dtpTarih1Exit
        end
        object dtpTarih2: TDateTimePicker
          Left = 150
          Top = 18
          Width = 121
          Height = 21
          Date = 38121.617936157410000000
          Time = 38121.617936157410000000
          TabOrder = 1
          OnEnter = dtpTarih1Enter
          OnExit = dtpTarih1Exit
        end
      end
      object cmbFaturaTip: TComboBox
        Left = 72
        Top = 244
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
        OnEnter = cmbFaturaTipEnter
        OnExit = cmbFaturaTipExit
        Items.Strings = (
          'Al'#305#351
          'Sat'#305#351' '
          #220'retim'
          'Hepsi')
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 116
        Width = 278
        Height = 73
        Align = alTop
        Caption = 'Depo Kod Aral'#305#287#305
        TabOrder = 4
        object BtnDep1: TButton
          Left = 8
          Top = 38
          Width = 113
          Height = 25
          Caption = '&Depo Listesi'
          TabOrder = 0
          TabStop = False
          OnClick = BtnDep1Click
        end
        object BtnDep2: TButton
          Left = 156
          Top = 38
          Width = 113
          Height = 25
          Caption = 'D&epo Listesi'
          TabOrder = 1
          TabStop = False
          OnClick = BtnDep2Click
        end
        object txtDepo_Kod1: TEdit
          Left = 8
          Top = 16
          Width = 113
          Height = 21
          TabOrder = 2
        end
        object txtDepo_Kod2: TEdit
          Left = 156
          Top = 16
          Width = 113
          Height = 21
          TabOrder = 3
        end
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 43
        Width = 278
        Height = 73
        Align = alTop
        Caption = 'Cari Kod Aral'#305#287#305
        TabOrder = 5
        object Button3: TButton
          Left = 8
          Top = 38
          Width = 113
          Height = 25
          Caption = '&Cari Listesi'
          TabOrder = 0
          TabStop = False
          OnClick = Button1Click
        end
        object Button4: TButton
          Left = 156
          Top = 38
          Width = 113
          Height = 25
          Caption = 'C&ari Listesi'
          TabOrder = 1
          TabStop = False
          OnClick = Button4Click
        end
        object txtCariKod1: TEdit
          Left = 8
          Top = 16
          Width = 113
          Height = 21
          TabOrder = 2
        end
        object txtCariKod2: TEdit
          Left = 156
          Top = 16
          Width = 113
          Height = 21
          TabOrder = 3
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 322
    Width = 286
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 3
      Top = 4
      Width = 94
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object btnCikis: TButton
      Left = 206
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = btnCikisClick
    end
    object btn_Fast: TButton
      Left = 105
      Top = 4
      Width = 88
      Height = 25
      Caption = 'Rapor Olu'#351'tur'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object qryRapor: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    Left = 136
    Top = 240
  end
  object qryDekontD: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT BA,MIKTAR FROM DEKONT_D '
      'WHERE DEKONT_D.KARSI_KOD = :PRM_KARSI_KOD'
      'AND DEKONT_D.MC='#39'U'#39)
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 156
    Top = 18
  end
  object qryFAT_IRS_MUH_CARI: TIB_Query
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    FieldsDisplayLabel.Strings = (
      'CARI_AD=Cari Ad'#305
      'YETKISI=Yetkilisi'
      'VERDAIRE=V. Dairesi'
      'VERNO=V. Nosu'
      'ADRES_1=Adres 1'
      'ADRES_2=Adres 2'
      'ILCE='#304'l'#231'e'
      'SEHIR='#350'ehir'
      'POSTA_KOD=P.K.'
      'TEL_NO_1=Tel 1'
      'TEL_NO_2=Tel 2'
      'FAX=Fax'
      'E_MAIL=E-Mail')
    FieldsVisible.Strings = (
      'FATURA_ID=FALSE'
      'FATURA_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT FAT_IRS_SEP'
      '     , FAT_IRS_ID'
      '     , FAT_IRS_SID'
      '     , CARI_AD'
      '     , YETKISI'
      '     , VERDAIRE'
      '     , VERNO'
      '     , ADRES_1'
      '     , ADRES_2'
      '     , ILCE'
      '     , SEHIR'
      '     , POSTA_KOD'
      '     , TEL_NO_1'
      '     , TEL_NO_2'
      '     , FAX'
      '     , E_MAIL'
      'FROM FAT_IRS_MUH_CARI '
      'WHERE FAT_IRS_SEP=:PRM_FAT_IRS_SEP AND '
      '      FAT_IRS_ID=:PRM_FAT_IRS_ID AND '
      '      FAT_IRS_SID=:PRM_FAT_IRS_SID;')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 214
    Top = 219
    ParamValues = (
      'PRM_FAT_IRS_SEP=0')
  end
  object frxIBODts_UrunHarList: TfrxIBODataset
    UserName = 'frxIBODts_UrunHarList'
    CloseDataSource = False
    FieldAliases.Strings = (
      'URUN_KOD=URUN_KOD'
      'URUN_AD=URUN_AD'
      'TARIH=TARIH'
      'URUNHAR_ID=URUNHAR_ID'
      'BELGE_TUR=BELGE_TUR'
      'BELGE_ID=BELGE_ID'
      'TIP=TIP'
      'MIKTAR=MIKTAR'
      'OLCUBIRIM=OLCUBIRIM'
      'BIRIM_FIY=BIRIM_FIY'
      'BIRIM_FIY_VPB=BIRIM_FIY_VPB'
      'DOVKOD=DOVKOD'
      'TUTAR=TUTAR'
      'TUTAR_VPB=TUTAR_VPB'
      'CARI_KOD=CARI_KOD'
      'CARI_AD=CARI_AD'
      'DEPO_KOD=DEPO_KOD'
      'DB_KEY=DB_KEY'
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
    ReportOptions.LastChange = 39162.408984189820000000
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
        DataSet = frxIBODts_UrunHarList
        DataSetName = 'frxIBODts_UrunHarList'
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
            #195#339'r'#195#188'n Hareket Listesi')
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
        object Memo_Batar: TfrxMemoView
          Left = 18.385900000000000000
          Top = 107.000000000000000000
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
          Left = 17.000000000000000000
          Top = 81.000000000000000000
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
          Left = 123.000000000000000000
          Top = 107.000000000000000000
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
        Top = 319.008040000000000000
        Width = 1084.725110000000000000
        DataSet = frxIBODts_UrunHarList
        DataSetName = 'frxIBODts_UrunHarList'
        RowCount = 0
        object Shape3: TfrxShapeView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 22.677180000000000000
        end
        object Memo7: TfrxMemoView
          Left = 2.779530000000000000
          Top = 1.999999999999994000
          Width = 80.220470000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_UrunHarList
          DataSetName = 'frxIBODts_UrunHarList'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd.mm.yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_UrunHarList."TARIH"]')
          ParentFont = False
          Style = 'Data'
        end
        object Memo18: TfrxMemoView
          Left = 90.417440000000000000
          Top = 1.999999999999994000
          Width = 124.047310000000000000
          Height = 18.897650000000000000
          DataField = 'CALC_BELGE_TUR'
          DataSet = frxIBODts_UrunHarList
          DataSetName = 'frxIBODts_UrunHarList'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_UrunHarList."CALC_BELGE_TUR"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 662.181510000000000000
          Top = 1.999999999999994000
          Width = 35.661410000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_UrunHarList
          DataSetName = 'frxIBODts_UrunHarList'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_UrunHarList."TIP"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 710.228820000000000000
          Top = 1.999999999999994000
          Width = 79.661410000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_UrunHarList
          DataSetName = 'frxIBODts_UrunHarList'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxIBODts_UrunHarList."MIKTAR"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 354.590910000000000000
          Top = 1.999999999999994000
          Width = 297.661410000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_UrunHarList
          DataSetName = 'frxIBODts_UrunHarList'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_UrunHarList."CARI_AD"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 800.583180000000000000
          Top = 1.999999999999994000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_UrunHarList
          DataSetName = 'frxIBODts_UrunHarList'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_UrunHarList."OLCUBIRIM"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 993.630490000000000000
          Top = 1.999999999999994000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DataField = 'TUTAR_VPB'
          DataSet = frxIBODts_UrunHarList
          DataSetName = 'frxIBODts_UrunHarList'
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
            '[frxIBODts_UrunHarList."TUTAR_VPB"]')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Left = 990.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line21: TfrxLineView
          Left = 219.000000000000000000
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
          Left = 701.000000000000000000
          Top = -0.000000000000005940
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Memo11: TfrxMemoView
          Left = 898.000000000000000000
          Top = 1.991960000000000000
          Width = 89.661410000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_UrunHarList
          DataSetName = 'frxIBODts_UrunHarList'
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
            '[frxIBODts_UrunHarList."BIRIM_FIY_VPB"]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          Left = 893.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line10: TfrxLineView
          Left = 656.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line20: TfrxLineView
          Left = 86.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line17: TfrxLineView
          Left = 351.000000000000000000
          Top = 0.991960000000000000
          Height = 23.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Memo16: TfrxMemoView
          Left = 223.244280000000000000
          Top = 1.999999999999994000
          Width = 122.826840000000000000
          Height = 18.897650000000000000
          DataField = 'CARI_KOD'
          DataSet = frxIBODts_UrunHarList
          DataSetName = 'frxIBODts_UrunHarList'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_UrunHarList."CARI_KOD"]')
          ParentFont = False
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
        Top = 382.157700000000000000
        Width = 1084.725110000000000000
        object Shape6: TfrxShapeView
          Left = 1.000000000000000000
          Top = -0.000000000000022926
          Width = 1086.000000000000000000
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
        Top = 252.000000000000000000
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
            'Birim Fiyat'#196#177)
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
            #195#8211'l'#195#167#195#188' Birimi')
          ParentFont = False
          Style = 'Header'
        end
        object Memo31: TfrxMemoView
          Left = 90.417440000000000000
          Top = 2.000000000000000000
          Width = 122.047310000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Belge T'#195#188'r'#195#188)
          ParentFont = False
          Style = 'Header'
        end
        object Memo4: TfrxMemoView
          Left = 2.779530000000000000
          Top = 2.000000000000000000
          Width = 79.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Tarihi')
          ParentFont = False
          Style = 'Header'
        end
        object Memo2: TfrxMemoView
          Left = 354.590910000000000000
          Top = 2.000000000000000000
          Width = 295.661410000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Cari Ad')
          ParentFont = False
          Style = 'Header'
        end
        object Memo24: TfrxMemoView
          Left = 662.181510000000000000
          Top = 2.000000000000000000
          Width = 31.661410000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Tip')
          ParentFont = False
          Style = 'Header'
        end
        object Memo25: TfrxMemoView
          Left = 713.228820000000000000
          Top = 2.000000000000000000
          Width = 79.661410000000000000
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
            'Miktar')
          ParentFont = False
          Style = 'Header'
        end
        object Line9: TfrxLineView
          Left = 656.000000000000000000
          Top = 1.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line16: TfrxLineView
          Left = 351.000000000000000000
          Top = 1.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line18: TfrxLineView
          Left = 219.000000000000000000
          Top = 1.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line19: TfrxLineView
          Left = 86.000000000000000000
          Top = 0.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Memo23: TfrxMemoView
          Left = 223.244280000000000000
          Top = 2.000000000000000000
          Width = 122.826840000000000000
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
            'Tutar'#196#177)
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
          Left = 701.000000000000000000
          Top = 0.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
      end
      object GroupHeader1: TfrxGroupHeader
        Height = 23.000000000000000000
        Top = 181.000000000000000000
        Width = 1084.725110000000000000
        Condition = '<frxIBODts_UrunHarList."URUN_KOD">'
        object Shape4: TfrxShapeView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 23.000000000000000000
        end
        object Memo13: TfrxMemoView
          Left = 5.000000000000000000
          Top = 2.000000000000000000
          Width = 94.220470000000000000
          Height = 18.897650000000000000
          DataField = 'URUN_KOD'
          DataSet = frxIBODts_UrunHarList
          DataSetName = 'frxIBODts_UrunHarList'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_UrunHarList."URUN_KOD"]')
          ParentFont = False
          Style = 'Data'
        end
        object Memo14: TfrxMemoView
          Left = 171.637910000000000000
          Top = 2.000000000000000000
          Width = 309.047310000000000000
          Height = 18.897650000000000000
          DataField = 'URUN_AD'
          DataSet = frxIBODts_UrunHarList
          DataSetName = 'frxIBODts_UrunHarList'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_UrunHarList."URUN_AD"]')
          ParentFont = False
        end
      end
    end
  end
  object IB_Query1: TIB_Query
    CalculatedFields.Strings = (
      'CALC_BELGE_TUR=CHAR(100)')
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'select * from urunhar_view'
      'ORDER BY URUN_KOD,TARIH,URUNHAR_ID')
    OnCalculateField = IB_Query1CalculateField
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 208
    Top = 72
  end
end
