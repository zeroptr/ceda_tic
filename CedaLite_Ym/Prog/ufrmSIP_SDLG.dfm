object frmSIP_SDLG: TfrmSIP_SDLG
  Left = 90
  Top = 90
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Sipari'#351' Listesi'
  ClientHeight = 533
  ClientWidth = 791
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 494
    Width = 791
    Height = 39
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      791
      39)
    object btnIPTAL: TBitBtn
      Left = 627
      Top = 8
      Width = 85
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #304'&ptal'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnIPTALClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object btnTAMAM: TBitBtn
      Left = 711
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Tamam'
      TabOrder = 1
      OnClick = btnTAMAMClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
    end
    object btnRapor: TButton
      Left = 6
      Top = 8
      Width = 123
      Height = 25
      Caption = 'Excel Rapor Olu'#351'tur'
      TabOrder = 2
      OnClick = btnRaporClick
    end
    object btn_Fast: TButton
      Left = 142
      Top = 9
      Width = 97
      Height = 25
      Caption = 'Rapor Olu'#351'tur'
      TabOrder = 3
      OnClick = btnRaporClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 49
    Width = 791
    Height = 96
    Align = alTop
    TabOrder = 1
    object btn_Ara: TButton
      Left = 709
      Top = 46
      Width = 77
      Height = 39
      Caption = '&Ara'
      TabOrder = 5
      OnClick = btn_AraClick
    end
    object GroupBox1: TGroupBox
      Left = 3
      Top = 1
      Width = 460
      Height = 39
      TabOrder = 0
      object lbl_CARIKOD: TLabel
        Left = 96
        Top = 15
        Width = 64
        Height = 13
        Caption = 'lbl_CARIKOD'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbl_CARI: TLabel
        Left = 176
        Top = 15
        Width = 41
        Height = 13
        Caption = 'lbl_CARI'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object btnCARI: TButton
        Left = 4
        Top = 12
        Width = 87
        Height = 21
        Caption = '&Cari Listesi'
        TabOrder = 0
        OnClick = btnCariClick
      end
      object chkCARI: TCheckBox
        Left = 443
        Top = 14
        Width = 14
        Height = 17
        TabOrder = 1
        OnClick = chkCariClick
        OnEnter = chkRAPKODEnter
        OnExit = chkRAPKODExit
      end
    end
    object GroupBox2: TGroupBox
      Left = 458
      Top = 41
      Width = 247
      Height = 45
      Caption = #304#351'lem Tarihi'
      TabOrder = 4
      object Label4: TLabel
        Left = 112
        Top = 18
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object dtpIslemTar: TDateTimePicker
        Left = 7
        Top = 15
        Width = 101
        Height = 21
        Date = 37554.733220983800000000
        Time = 37554.733220983800000000
        ShowCheckbox = True
        Checked = False
        TabOrder = 0
        OnEnter = dtpIslemTarEnter
        OnExit = dtpIslemTarExit
      end
      object dtpIslemTar2: TDateTimePicker
        Left = 137
        Top = 14
        Width = 100
        Height = 21
        Date = 37554.733416122690000000
        Time = 37554.733416122690000000
        ShowCheckbox = True
        Checked = False
        TabOrder = 1
        OnEnter = dtpIslemTarEnter
        OnExit = dtpIslemTarExit
      end
    end
    object GroupBox3: TGroupBox
      Left = 174
      Top = 41
      Width = 280
      Height = 45
      Caption = 'Tutar'
      TabOrder = 3
      object Label1: TLabel
        Left = 129
        Top = 17
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object Tutar1: TIB_Currency
        Left = 6
        Top = 14
        Width = 121
        Height = 21
        TabOrder = 0
        OnEnter = Tutar1Enter
        OnExit = Tutar1Exit
        AlwaysShowButton = True
      end
      object Tutar2: TIB_Currency
        Left = 152
        Top = 14
        Width = 121
        Height = 21
        TabOrder = 1
        OnEnter = Tutar1Enter
        OnExit = Tutar1Exit
        AlwaysShowButton = True
      end
    end
    object GroupBox4: TGroupBox
      Left = 466
      Top = 1
      Width = 321
      Height = 38
      TabOrder = 1
      object Fat_No: TEdit
        Left = 120
        Top = 12
        Width = 80
        Height = 21
        TabOrder = 1
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = Fat_NoExit
      end
      object cmbTIPSEC: TComboBox
        Left = 7
        Top = 12
        Width = 108
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'Fi'#351' Numaras'#305
        OnEnter = cmbTIPSECEnter
        OnExit = cmbTIPSECExit
        Items.Strings = (
          'Fi'#351' Numaras'#305
          'Fatura Numaras'#305)
      end
      object cmbSube: TComboBox
        Left = 204
        Top = 12
        Width = 109
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        OnEnter = cmbTIPSECEnter
        OnExit = cmbTIPSECExit
      end
    end
    object GroupBox6: TGroupBox
      Left = 2
      Top = 41
      Width = 166
      Height = 45
      Caption = #350'ipari'#351' Tipi'
      TabOrder = 2
      Visible = False
      object cmbFATURA_TIP: TComboBox
        Left = 10
        Top = 15
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnEnter = cmbTIPSECEnter
        OnExit = cmbTIPSECExit
      end
    end
  end
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 145
    Width = 791
    Height = 349
    CustomGlyphsSupplied = []
    DataSource = dtsFAT_IRS
    Align = alClient
    OnDblClick = btnTAMAMClick
    BorderStyle = bsNone
    ReadOnly = True
    TabOrder = 2
    OnKeyPress = IB_Grid1KeyPress
    RowSelect = True
    Ctl3DShallow = True
  end
  object pnlRAPKOD: TPanel
    Left = 0
    Top = 0
    Width = 791
    Height = 49
    Align = alTop
    TabOrder = 0
    object Label2: TLabel
      Left = 10
      Top = 7
      Width = 64
      Height = 13
      Caption = #304#351'lem Merkezi'
    end
    object Label3: TLabel
      Left = 152
      Top = 7
      Width = 29
      Height = 13
      Caption = 'KOD1'
    end
    object Label7: TLabel
      Left = 291
      Top = 7
      Width = 29
      Height = 13
      Caption = 'KOD2'
    end
    object Label8: TLabel
      Left = 432
      Top = 7
      Width = 29
      Height = 13
      Caption = 'KOD3'
    end
    object Label9: TLabel
      Left = 570
      Top = 7
      Width = 29
      Height = 13
      Caption = 'KOD4'
    end
    object txtISLEMMERKEZI: TEdit
      Left = 9
      Top = 20
      Width = 79
      Height = 21
      TabOrder = 0
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtISLEMMERKEZIExit
    end
    object txtKOD1: TEdit
      Left = 150
      Top = 20
      Width = 79
      Height = 21
      TabOrder = 2
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD1Exit
    end
    object txtKOD2: TEdit
      Left = 288
      Top = 19
      Width = 79
      Height = 21
      TabOrder = 4
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD2Exit
    end
    object txtKOD3: TEdit
      Left = 430
      Top = 20
      Width = 79
      Height = 21
      TabOrder = 6
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD3Exit
    end
    object txtKOD4: TEdit
      Left = 568
      Top = 20
      Width = 79
      Height = 21
      TabOrder = 8
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD4Exit
    end
    object Button1: TButton
      Left = 90
      Top = 20
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 231
      Top = 20
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 371
      Top = 20
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 511
      Top = 20
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 650
      Top = 20
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      OnClick = Button5Click
    end
    object chkRAPKOD: TCheckBox
      Left = 765
      Top = 22
      Width = 15
      Height = 17
      TabOrder = 10
      OnEnter = chkRAPKODEnter
      OnExit = chkRAPKODExit
    end
  end
  object qryFAT_IRS: TIB_Query
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    FieldsDisplayLabel.Strings = (
      'CARI_KOD=Cari Kod'
      'CARI_AD=Cari Ad'
      'FATURA_KOD=Fatura Kod'
      'FATSERI=Seri'
      'FATURA_NO=Fatura No'
      'TARIH=Tarih'
      'GENELTOP=Genel Toplam'
      'VADE_TARIH=Vad. Tarihi'
      'VADE_GUN=Vad. G'#252'n'
      'ACIKLAMA=A'#231#305'klama'
      'FATURA_ID=FIS NO'
      'FAT_IRS_ID=Fi'#351' No'
      'FAT_IRS_SERI=Seri No'
      'BELGE_NO=Belge No'
      'GENEL_TOP=Genel Toplam')
    FieldsDisplayWidth.Strings = (
      'GENELTOP=132'
      'FATURA_NO=53'
      'TARIH=62'
      'FATSERI=46'
      'ACIKLAMA=105'
      'VADE_TARIH=62'
      'CARI_KOD=73'
      'CARI_AD=148'
      'FATURA_KOD=100'
      'VADE_GUN=25'
      'FAT_IRS_ID=61'
      'FAT_IRS_SERI=60'
      'BELGE_NO=76')
    FieldsIndex.Strings = (
      'FAT_IRS_ID'
      'TARIH'
      'FAT_IRS_SERI'
      'BELGE_NO'
      'CARI_KOD'
      'CARI_AD'
      'ACIKLAMA'
      'FAT_IRS_SEP'
      'FAT_IRS_SID'
      'GENEL_TOP')
    FieldsVisible.Strings = (
      'FATURA_ID=TRUE'
      'FATURA_SID=FALSE'
      'CARI_ID=FALSE'
      'CARI_SID=FALSE'
      'FAT_IRS_SEP=FALSE'
      'FAT_IRS_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT FAT_IRS_SEP'
      '     , FAT_IRS_ID'
      '     , FAT_IRS_SID'
      '     , TARIH'
      '     , CARI_KOD '
      
        '     , (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=SIPARI' +
        'S.CARI_KOD ) As CARI_AD'
      '     , FAT_IRS_SERI     '
      '     , BELGE_NO'
      '     , GENEL_TOP'
      '     , ACIKLAMA'
      'FROM SIPARIS'
      '')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItemNo = 1
    OrderingItems.Strings = (
      'FIS_NO=FAT_IRS_ID;FAT_IRS_ID DESC'
      'Tarih=TARIH;TARIH DESC'
      'Belge No=BELGE_NO;BELGE_NO DESC'
      'Cari Kod=CARI_KOD;CARI_KOD DESC'
      'Genel Toplam=GENEL_TOP;GENEL_TOP DESC')
    OrderingLinks.Strings = (
      'FAT_IRS_ID=ITEM=1'
      'TARIH=ITEM=2'
      'BELGE_NO=ITEM=3'
      'CARI_KOD=ITEM=4'
      'GENEL_TOP=ITEM=5')
    ReadOnly = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 219
    Top = 240
  end
  object dtsFAT_IRS: TIB_DataSource
    Dataset = qryFAT_IRS
    Left = 148
    Top = 240
  end
  object frxIBODts_SiparisList: TfrxIBODataset
    UserName = 'frxIBODts_SiparisList'
    CloseDataSource = False
    FieldAliases.Strings = (
      'FAT_IRS_ID=FAT_IRS_ID'
      'TARIH=TARIH'
      'FAT_IRS_SERI=FAT_IRS_SERI'
      'BELGE_NO=BELGE_NO'
      'CARI_KOD=CARI_KOD'
      'CARI_AD=CARI_AD'
      'ACIKLAMA=ACIKLAMA'
      'FAT_IRS_SEP=FAT_IRS_SEP'
      'FAT_IRS_SID=FAT_IRS_SID'
      'GENEL_TOP=GENEL_TOP')
    DataSet = qryFAT_IRS
    Left = 352
    Top = 257
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
    ReportOptions.LastChange = 39160.470432754600000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnBeforePrint = frxReport1BeforePrint
    Left = 352
    Top = 305
    Datasets = <
      item
        DataSet = frxIBODts_SiparisList
        DataSetName = 'frxIBODts_SiparisList'
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
        Top = 18.897650000000000000
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
          Left = 376.173470000000000000
          Top = 49.133889999999990000
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
            'Sipari'#197#376' Listesi')
          ParentFont = False
        end
        object Memo_Bit_Tar: TfrxMemoView
          Left = 975.118740000000000000
          Top = 41.574830000000000000
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
          Left = 869.291900000000000000
          Top = 41.574830000000000000
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
        object Memo_Batar: TfrxMemoView
          Left = 17.385900000000000000
          Top = 105.102350000000000000
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
        object Memo26: TfrxMemoView
          Left = 16.000000000000000000
          Top = 79.102350000000000000
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
          Left = 122.000000000000000000
          Top = 105.102350000000000000
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
        Top = 255.008040000000000000
        Width = 1084.725110000000000000
        DataSet = frxIBODts_SiparisList
        DataSetName = 'frxIBODts_SiparisList'
        RowCount = 0
        object Shape3: TfrxShapeView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 22.677180000000000000
        end
        object Memo7: TfrxMemoView
          Left = 4.779530000000000000
          Top = 1.999999999999994000
          Width = 94.220470000000000000
          Height = 18.897650000000000000
          DataField = 'FAT_IRS_ID'
          DataSet = frxIBODts_SiparisList
          DataSetName = 'frxIBODts_SiparisList'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_SiparisList."FAT_IRS_ID"]')
          ParentFont = False
          Style = 'Data'
        end
        object Memo18: TfrxMemoView
          Left = 108.417440000000000000
          Top = 1.999999999999994000
          Width = 88.047310000000000000
          Height = 18.897650000000000000
          DataField = 'TARIH'
          DataSet = frxIBODts_SiparisList
          DataSetName = 'frxIBODts_SiparisList'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd.mm.yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_SiparisList."TARIH"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 323.181510000000000000
          Top = 1.999999999999994000
          Width = 127.984230000000000000
          Height = 18.897650000000000000
          DataField = 'CARI_KOD'
          DataSet = frxIBODts_SiparisList
          DataSetName = 'frxIBODts_SiparisList'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_SiparisList."CARI_KOD"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 461.228820000000000000
          Top = 1.999999999999994000
          Width = 237.661410000000000000
          Height = 18.897650000000000000
          DataField = 'CARI_AD'
          DataSet = frxIBODts_SiparisList
          DataSetName = 'frxIBODts_SiparisList'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_SiparisList."CARI_AD"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 242.590910000000000000
          Top = 1.999999999999994000
          Width = 73.527520000000000000
          Height = 18.897650000000000000
          DataField = 'BELGE_NO'
          DataSet = frxIBODts_SiparisList
          DataSetName = 'frxIBODts_SiparisList'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_SiparisList."BELGE_NO"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 704.583180000000000000
          Top = 1.999999999999994000
          Width = 247.984230000000000000
          Height = 18.897650000000000000
          DataField = 'ACIKLAMA'
          DataSet = frxIBODts_SiparisList
          DataSetName = 'frxIBODts_SiparisList'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_SiparisList."ACIKLAMA"]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 961.630490000000000000
          Top = 2.999999999999994000
          Width = 117.661410000000000000
          Height = 18.897650000000000000
          DataField = 'GENEL_TOP'
          DataSet = frxIBODts_SiparisList
          DataSetName = 'frxIBODts_SiparisList'
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
            '[frxIBODts_SiparisList."GENEL_TOP"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 203.244280000000000000
          Top = 1.999999999999994000
          Width = 33.826840000000000000
          Height = 18.897650000000000000
          DataField = 'FAT_IRS_SERI'
          DataSet = frxIBODts_SiparisList
          DataSetName = 'frxIBODts_SiparisList'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%g'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_SiparisList."FAT_IRS_SERI"]')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Left = 959.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line10: TfrxLineView
          Left = 318.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line17: TfrxLineView
          Left = 241.000000000000000000
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
          Left = 199.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line6: TfrxLineView
          Left = 703.000000000000000000
          Top = -0.000000000000005954
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          Left = 455.000000000000000000
          Top = -0.000000000000005954
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
      end
      object PageFooter1: TfrxPageFooter
        Height = 18.897650000000000000
        Top = 428.677490000000000000
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
        Top = 332.157700000000000000
        Width = 1084.725110000000000000
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
        object Memo14: TfrxMemoView
          Left = 963.630490000000000000
          Top = 6.559059999999965000
          Width = 117.661410000000000000
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
            '[SUM(<frxIBODts_SiparisList."GENEL_TOP">,MasterData1)]')
          ParentFont = False
        end
        object Line12: TfrxLineView
          Left = 959.000000000000000000
          Top = -0.000000000000022926
          Height = 32.000000000000000000
          Frame.Typ = [ftLeft]
        end
      end
      object PageHeader1: TfrxPageHeader
        Height = 22.677180000000000000
        Top = 185.858380000000000000
        Width = 1084.725110000000000000
        object Shape2: TfrxShapeView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 22.677180000000000000
        end
        object Memo31: TfrxMemoView
          Left = 107.417440000000000000
          Top = 0.000000000000011019
          Width = 88.047310000000000000
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
          Left = 3.779530000000000000
          Top = 0.000000000000011019
          Width = 94.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Fi'#197#376' No')
          ParentFont = False
          Style = 'Header'
        end
        object Memo2: TfrxMemoView
          Left = 242.590910000000000000
          Top = 2.000000000000011000
          Width = 73.527520000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Belge No')
          ParentFont = False
          Style = 'Header'
        end
        object Memo24: TfrxMemoView
          Left = 323.181510000000000000
          Top = 3.000000000000011000
          Width = 127.984230000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.Kind = fkNumeric
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
        object Memo25: TfrxMemoView
          Left = 461.228820000000000000
          Top = 3.000000000000011000
          Width = 237.661410000000000000
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
            'Cari Ad')
          ParentFont = False
          Style = 'Header'
        end
        object Memo17: TfrxMemoView
          Left = 705.583180000000000000
          Top = 2.000000000000011000
          Width = 247.984230000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'A'#195#167#196#177'klama')
          ParentFont = False
          Style = 'Header'
        end
        object Memo21: TfrxMemoView
          Left = 963.630490000000000000
          Top = 2.000000000000011000
          Width = 117.661410000000000000
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
            'Genel Toplam')
          ParentFont = False
          Style = 'Header'
        end
        object Line3: TfrxLineView
          Left = 959.000000000000000000
          Top = 0.141620000000000000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          Left = 703.000000000000000000
          Top = 0.141620000000000000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line7: TfrxLineView
          Left = 455.000000000000000000
          Top = 1.141620000000000000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line9: TfrxLineView
          Left = 318.000000000000000000
          Top = 1.141620000000000000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line16: TfrxLineView
          Left = 241.000000000000000000
          Top = 1.141620000000000000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line18: TfrxLineView
          Left = 199.000000000000000000
          Top = 0.141620000000000000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line19: TfrxLineView
          Left = 102.000000000000000000
          Top = 0.141620000000000000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Memo23: TfrxMemoView
          Left = 203.244280000000000000
          Top = 1.000000000000011000
          Width = 33.826840000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Seri')
          ParentFont = False
          Style = 'Header'
        end
      end
    end
  end
end
