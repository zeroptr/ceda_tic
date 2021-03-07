object frmRaporKasaTekGunlukHareket: TfrmRaporKasaTekGunlukHareket
  Left = 501
  Top = 340
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Tek G'#252'nl'#252'k Kasa Raporu'
  ClientHeight = 301
  ClientWidth = 232
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
    Width = 232
    Height = 265
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object chk_Sirket: TCheckBox
        Left = 6
        Top = 215
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnEnter = chk_DevirEnter
        OnExit = chk_DevirExit
      end
      object rdCins: TRadioGroup
        Left = 0
        Top = 49
        Width = 224
        Height = 54
        Align = alTop
        ItemIndex = 0
        Items.Strings = (
          'Kasan'#305'n Para Birimi Cinsinden'
          'Varsay'#305'lan Para Birimi Cinsinden')
        TabOrder = 1
      end
      object chk_Devir: TCheckBox
        Left = 6
        Top = 193
        Width = 205
        Height = 17
        Caption = '    Raporda devir bakiyesi kullan'#305'ls'#305'n'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnEnter = chk_DevirEnter
        OnExit = chk_DevirExit
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 224
        Height = 49
        Align = alTop
        Caption = 'Kasa Kodu'
        TabOrder = 0
        object txt_KasaKod: TEdit
          Left = 8
          Top = 16
          Width = 107
          Height = 21
          TabOrder = 0
          OnEnter = txt_KasaKodEnter
          OnExit = txt_KasaKodExit
          OnKeyDown = txt_KasaKodKeyDown
          OnKeyPress = txt_KasaKodKeyPress
        end
        object btnKasa: TButton
          Left = 118
          Top = 15
          Width = 100
          Height = 22
          Caption = 'Kasa Listesi'
          TabOrder = 1
          TabStop = False
          OnClick = btnKasaClick
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 103
        Width = 224
        Height = 36
        Align = alTop
        TabOrder = 2
        object dtp_Tarih: TDateTimePicker
          Left = 38
          Top = 10
          Width = 137
          Height = 21
          Date = 37938.616184074070000000
          Time = 37938.616184074070000000
          TabOrder = 0
          OnEnter = dtp_TarihEnter
          OnExit = dtp_TarihExit
        end
      end
      object grpSube: TGroupBox
        Left = 0
        Top = 139
        Width = 224
        Height = 48
        Align = alTop
        Caption = #350'ube Ad'#305
        TabOrder = 3
        object cmbSube: TComboBox
          Left = 36
          Top = 16
          Width = 139
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnEnter = cmbSubeEnter
          OnExit = cmbSubeExit
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Ko'#351'ullar'
      ImageIndex = 1
      object Label12: TLabel
        Left = 6
        Top = 0
        Width = 64
        Height = 13
        Caption = #304#351'lem Merkezi'
      end
      object lblKOD1: TLabel
        Left = 114
        Top = -1
        Width = 29
        Height = 13
        Caption = 'KOD1'
      end
      object Label14: TLabel
        Left = 6
        Top = 41
        Width = 29
        Height = 13
        Caption = 'KOD2'
      end
      object Label15: TLabel
        Left = 114
        Top = 42
        Width = 29
        Height = 13
        Caption = 'KOD3'
      end
      object Label16: TLabel
        Left = 71
        Top = 85
        Width = 29
        Height = 13
        Caption = 'KOD4'
      end
      object txtISLEMMERKEZI: TEdit
        Left = 5
        Top = 14
        Width = 79
        Height = 21
        TabOrder = 0
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtISLEMMERKEZIExit
        OnKeyUp = txtISLEMMERKEZIKeyUp
      end
      object Button4: TButton
        Left = 85
        Top = 14
        Width = 17
        Height = 22
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = Button4Click
      end
      object txtKOD1: TEdit
        Left = 113
        Top = 14
        Width = 79
        Height = 21
        TabOrder = 2
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtKOD1Exit
        OnKeyUp = txtKOD1KeyUp
      end
      object btnKOD1: TButton
        Left = 193
        Top = 14
        Width = 17
        Height = 21
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        TabStop = False
        OnClick = btnKOD1Click
      end
      object txtKOD2: TEdit
        Left = 5
        Top = 55
        Width = 79
        Height = 21
        TabOrder = 4
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtKOD2Exit
        OnKeyUp = txtKOD2KeyUp
      end
      object Button6: TButton
        Left = 85
        Top = 55
        Width = 17
        Height = 22
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        TabStop = False
        OnClick = Button6Click
      end
      object txtKOD3: TEdit
        Left = 113
        Top = 55
        Width = 79
        Height = 21
        TabOrder = 6
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtKOD3Exit
        OnKeyUp = txtKOD3KeyUp
      end
      object Button7: TButton
        Left = 193
        Top = 55
        Width = 17
        Height = 22
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        TabStop = False
        OnClick = Button7Click
      end
      object txtKOD4: TEdit
        Left = 70
        Top = 99
        Width = 79
        Height = 21
        TabOrder = 8
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtKOD4Exit
        OnKeyUp = txtKOD4KeyUp
      end
      object Button8: TButton
        Left = 150
        Top = 100
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
        TabStop = False
        OnClick = Button8Click
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 268
    Width = 232
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 1
      Top = 4
      Width = 72
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object Button3: TButton
      Left = 160
      Top = 4
      Width = 71
      Height = 25
      Caption = #199#305'k'#305#351
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
  object qry_Kasa: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 215
    Top = 345
  end
  object qry_Rapor: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 33
    Top = 345
  end
  object qryDEVREDEN: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 122
    Top = 346
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
    ReportOptions.LastChange = 39162.427231979160000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  borc,borc_bak:Double;'
      '  alacak,alacak_bak:Double;'
      ''
      '//     a:=a+<frxIBODts_Kasa_Aylik."BORC">;'
      'procedure Memo1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '   // Memo1.memo.text:=Floattostr(A);'
      '   // Memo1.memo.text:='#39'12312'#39';'
      '   // Memo1.memo.text:=<frxIBODts_Kasa_Aylik."BORC">;'
      '   //  Memo1.memo.text:=Floattostr(borc_bak);'
      '     Memo1.memo.text:=FormatFloat('#39'#,.00'#39',borc_bak);'
      'end;'
      ''
      'procedure Memo2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '     //Memo2.memo.text:=Floattostr(alacak_bak);'
      '     Memo2.memo.text:=FormatFloat('#39'#,.00'#39',alacak_bak);'
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '     borc:=<frxIBODts_Kasa_Gunluk."BORC">;'
      '     alacak:=<frxIBODts_Kasa_Gunluk."ALACAK">;'
      ''
      '     if borc>alacak then'
      '     borc_bak:=borc_bak+(borc-alacak);'
      ''
      '     if alacak>borc then'
      '     alacak_bak:=alacak_bak+(alacak-borc);'
      ''
      '     if borc_bak>alacak_bak then'
      '     begin'
      '        borc_bak:=borc_bak-alacak_bak;'
      '        alacak_bak:=0;'
      '     end;'
      ''
      '     if alacak_bak>borc_bak then'
      '     begin'
      '        alacak_bak:=alacak_bak-borc_bak;'
      '        borc_bak:=0;'
      '     end;'
      ''
      'end;'
      ''
      ''
      'begin'
      ''
      'end.')
    OnBeforePrint = frxReport1BeforePrint
    Left = 112
    Top = 1
    Datasets = <
      item
        DataSet = frxIBODts_Kasa_Gunluk
        DataSetName = 'frxIBODts_Kasa_Gunluk'
      end>
    Variables = <
      item
        Name = ' New Category1'
        Value = Null
      end
      item
        Name = 'ssm'
        Value = '<ssm>+<frxIBODts_Kasa_Aylik."ALACAK">'
      end>
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
      LeftMargin = 5.000625000000000000
      RightMargin = 5.000625000000000000
      TopMargin = 5.000625000000000000
      BottomMargin = 5.000625000000000000
      object ReportTitle1: TfrxReportTitle
        Height = 132.283550000000000000
        Top = 20.000000000000000000
        Width = 1084.720385587500000000
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 1084.720385587500000000
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
          Width = 252.299320000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'G'#195#188'nl'#195#188'k Kasa Hareketleri Listesi')
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
        object Memo_Batar: TfrxMemoView
          Left = 19.385900000000000000
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
        object Memo_kasa: TfrxMemoView
          Left = 269.000000000000000000
          Top = 106.000000000000000000
          Width = 115.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            '')
          ParentFont = False
          Style = 'Header'
        end
        object Memo_kasa_ad: TfrxMemoView
          Left = 391.000000000000000000
          Top = 106.000000000000000000
          Width = 210.220470000000000000
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
        Top = 289.008040000000000000
        Width = 1084.720385587500000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxIBODts_Kasa_Gunluk
        DataSetName = 'frxIBODts_Kasa_Gunluk'
        RowCount = 0
        object Shape3: TfrxShapeView
          Align = baClient
          Width = 1084.720385587500000000
          Height = 22.677180000000000000
        end
        object Memo7: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.999999999999994000
          Width = 90.826840000000000000
          Height = 18.897650000000000000
          DataField = 'KASAHAR_ID'
          DataSet = frxIBODts_Kasa_Gunluk
          DataSetName = 'frxIBODts_Kasa_Gunluk'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_Kasa_Gunluk."KASAHAR_ID"]')
          ParentFont = False
          Style = 'Data'
        end
        object Memo18: TfrxMemoView
          Left = 216.417440000000000000
          Top = 1.999999999999994000
          Width = 310.826840000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo18OnBeforePrint'
          DataField = 'ACIKLAMA'
          DataSet = frxIBODts_Kasa_Gunluk
          DataSetName = 'frxIBODts_Kasa_Gunluk'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_Kasa_Gunluk."ACIKLAMA"]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 620.181510000000000000
          Top = 1.999999999999994000
          Width = 110.000000000000000000
          Height = 18.897650000000000000
          DataField = 'BORC'
          DataSet = frxIBODts_Kasa_Gunluk
          DataSetName = 'frxIBODts_Kasa_Gunluk'
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
            '[frxIBODts_Kasa_Gunluk."BORC"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 738.228820000000000000
          Top = 1.999999999999994000
          Width = 110.000000000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_Kasa_Gunluk
          DataSetName = 'frxIBODts_Kasa_Gunluk'
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
            '[frxIBODts_Kasa_Gunluk."ALACAK"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 535.244280000000000000
          Top = 1.999999999999994000
          Width = 77.000000000000000000
          Height = 18.897650000000000000
          DataField = 'DOVKOD'
          DataSet = frxIBODts_Kasa_Gunluk
          DataSetName = 'frxIBODts_Kasa_Gunluk'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[frxIBODts_Kasa_Gunluk."DOVKOD"]')
          ParentFont = False
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
          Left = 852.000000000000000000
          Top = 0.999999999999994000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          Left = 531.000000000000000000
          Top = -0.000000000000005940
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Memo1: TfrxMemoView
          Left = 856.000000000000000000
          Top = 1.991960000000000000
          Width = 110.000000000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo1OnBeforePrint'
          DataSet = frxIBODts_Kasa_Gunluk
          DataSetName = 'frxIBODts_Kasa_Gunluk'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 974.000000000000000000
          Top = 1.991960000000000000
          Width = 110.000000000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo2OnBeforePrint'
          DataSet = frxIBODts_Kasa_Gunluk
          DataSetName = 'frxIBODts_Kasa_Gunluk'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 107.000000000000000000
          Top = 1.991960000000000000
          Width = 100.826840000000000000
          Height = 18.897650000000000000
          OnBeforePrint = 'Memo18OnBeforePrint'
          DataField = 'TARIH'
          DataSet = frxIBODts_Kasa_Gunluk
          DataSetName = 'frxIBODts_Kasa_Gunluk'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd.mm.yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_Kasa_Gunluk."TARIH"]')
          ParentFont = False
        end
        object Line10: TfrxLineView
          Left = 970.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line17: TfrxLineView
          Left = 734.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line2: TfrxLineView
          Left = 617.000000000000000000
          Top = 0.991960000000000000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
      end
      object PageFooter1: TfrxPageFooter
        Height = 18.897650000000000000
        Top = 495.677490000000000000
        Width = 1084.720385587500000000
        object SysMemo3: TfrxSysMemoView
          Align = baCenter
          Left = 495.116067793750000000
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
        Top = 219.000000000000000000
        Width = 1084.720385587500000000
        OnBeforePrint = 'PageHeader1OnBeforePrint'
        object Shape2: TfrxShapeView
          Align = baClient
          Width = 1084.720385587500000000
          Height = 22.677180000000000000
        end
        object Memo31: TfrxMemoView
          Left = 216.417440000000000000
          Top = 2.000000000000000000
          Width = 279.047310000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
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
        object Memo4: TfrxMemoView
          Left = 4.779530000000000000
          Top = 2.000000000000000000
          Width = 93.220470000000000000
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
        object Memo24: TfrxMemoView
          Left = 620.181510000000000000
          Top = 2.000000000000000000
          Width = 110.000000000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.Kind = fkNumeric
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
        object Memo25: TfrxMemoView
          Left = 738.228820000000000000
          Top = 1.000000000000000000
          Width = 110.000000000000000000
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
        object Line5: TfrxLineView
          Left = 852.000000000000000000
          Top = 0.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line9: TfrxLineView
          Left = 617.000000000000000000
          Top = 1.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line16: TfrxLineView
          Left = 531.000000000000000000
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
          Left = 535.244280000000000000
          Top = 2.000000000000000000
          Width = 79.000000000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'D'#195#182'viz Kodu')
          ParentFont = False
          Style = 'Header'
        end
        object Line1: TfrxLineView
          Left = 734.000000000000000000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Memo3: TfrxMemoView
          Left = 856.000000000000000000
          Top = 2.000000000000000000
          Width = 110.000000000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Borc Bakiyesi')
          ParentFont = False
          Style = 'Header'
        end
        object Memo9: TfrxMemoView
          Left = 972.047310000000000000
          Top = 2.000000000000000000
          Width = 110.000000000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Alacak Bakiyesi')
          ParentFont = False
          Style = 'Header'
        end
        object Memo10: TfrxMemoView
          Left = 107.000000000000000000
          Top = 2.000000000000000000
          Width = 101.220470000000000000
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
        object Line7: TfrxLineView
          Left = 970.000000000000000000
          Top = 0.141619999999989000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
      end
      object ReportSummary1: TfrxReportSummary
        Height = 20.000000000000000000
        Top = 362.000000000000000000
        Width = 1084.720385587500000000
        object Memo13: TfrxMemoView
          Left = 622.000000000000000000
          Width = 110.000000000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_Kasa_Gunluk
          DataSetName = 'frxIBODts_Kasa_Gunluk'
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
            '[SUM(<frxIBODts_Kasa_Gunluk."BORC">,MasterData1,2)]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 740.047310000000000000
          Width = 110.000000000000000000
          Height = 18.897650000000000000
          DataSet = frxIBODts_Kasa_Gunluk
          DataSetName = 'frxIBODts_Kasa_Gunluk'
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
            '[SUM(<frxIBODts_Kasa_Gunluk."ALACAK">,MasterData1,2)]')
          ParentFont = False
        end
      end
    end
  end
  object frxIBODts_Kasa_Gunluk: TfrxIBODataset
    UserName = 'frxIBODts_Kasa_Gunluk'
    CloseDataSource = False
    FieldAliases.Strings = (
      'TARIH=TARIH'
      'KASA_KOD=KASA_KOD'
      'KASAHAR_ID=KASAHAR_ID'
      'BELGE_ID=BELGE_ID'
      'ACIKLAMA=ACIKLAMA'
      'DOVKOD=DOVKOD'
      'TIP=TIP'
      'TUTAR=TUTAR'
      'BORC=BORC'
      'ALACAK=ALACAK')
    DataSet = IB_Query1
    Left = 64
    Top = 17
  end
  object IB_Query1: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'select'
      'tarih,'
      'kasa_kod,'
      'kasahar_id,'
      'belge_id,'
      'aciklama,'
      'dovkod,'
      'tip,'
      ''
      'kasadeger Tutar,'
      'case'
      'when Tip='#39'G'#39' then'
      'kasadeger'
      'end borc'
      ''
      ',case'
      'when Tip='#39'C'#39' then'
      'kasadeger'
      'end alacak'
      ''
      'from kasahar'
      'where kasa_kod=:kasa_kod'
      '')
    ColorScheme = False
    KeyLinksAutoDefine = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 168
    Top = 8
    ParamValues = (
      'KASA_KOD=')
  end
end
