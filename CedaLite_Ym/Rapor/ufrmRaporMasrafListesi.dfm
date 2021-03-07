object frmRaporMasrafListesi: TfrmRaporMasrafListesi
  Left = 289
  Top = 213
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Masraf Listesi'
  ClientHeight = 233
  ClientWidth = 263
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
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 263
    Height = 349
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object chk_Sirket: TCheckBox
        Left = 24
        Top = 148
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnEnter = chkDEVIREnter
        OnExit = chkDEVIRExit
      end
      object chkDEVIR: TCheckBox
        Left = 24
        Top = 128
        Width = 205
        Height = 17
        Caption = '    Raporda devir bakiyesi kullan'#305'ls'#305'n'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnEnter = chkDEVIREnter
        OnExit = chkDEVIRExit
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 255
        Height = 73
        Align = alTop
        Caption = 'Masraf Kod Aral'#305#287#305
        TabOrder = 0
        object txtMasrafKod2: TEdit
          Left = 128
          Top = 16
          Width = 113
          Height = 21
          TabOrder = 1
          OnEnter = txtMasrafKod1Enter
          OnExit = txtMasrafKod1Exit
          OnKeyDown = txtMasrafKod2KeyDown
        end
        object txtMasrafKod1: TEdit
          Left = 8
          Top = 16
          Width = 113
          Height = 21
          TabOrder = 0
          OnEnter = txtMasrafKod1Enter
          OnExit = txtMasrafKod1Exit
          OnKeyDown = txtMasrafKod1KeyDown
        end
        object Button1: TButton
          Left = 8
          Top = 38
          Width = 113
          Height = 25
          Caption = '&Masraf Listesi'
          TabOrder = 2
          TabStop = False
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 128
          Top = 38
          Width = 113
          Height = 25
          Caption = 'M&asraf Listesi'
          TabOrder = 3
          TabStop = False
          OnClick = Button2Click
        end
      end
      object grpSube: TGroupBox
        Left = 0
        Top = 73
        Width = 255
        Height = 49
        Align = alTop
        Caption = #350'ube Ad'#305
        TabOrder = 1
        object cmbSube: TComboBox
          Left = 64
          Top = 18
          Width = 129
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnEnter = cmbSubeEnter
          OnExit = cmbSubeExit
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 200
    Width = 263
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 5
      Top = 4
      Width = 76
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object Button3: TButton
      Left = 184
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object Btn_Fast: TButton
      Left = 94
      Top = 4
      Width = 77
      Height = 25
      Caption = '&Rapor'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object qryYaz: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 144
    Top = 18
  end
  object frxIBODts_Masraf: TfrxIBODataset
    UserName = 'frxIBODts_Masraf'
    CloseDataSource = False
    FieldAliases.Strings = (
      'MASRAF_KOD=MASRAF_KOD'
      'ADI=ADI'
      'ACIKLAMA=ACIKLAMA'
      'TOPLAM_BORC=TOPLAM_BORC'
      'TOPLAM_ALACAK=TOPLAM_ALACAK'
      'CALC_BA=CALC_BA'
      'CALC_BAKIYE=CALC_BAKIYE')
    DataSet = IB_Query1
    Left = 24
    Top = 49
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
    ReportOptions.LastChange = 39163.668594652780000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 24
    Top = 97
    Datasets = <
      item
        DataSet = frxIBODts_Masraf
        DataSetName = 'frxIBODts_Masraf'
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
  end
  object IB_Query1: TIB_Query
    CalculatedFields.Strings = (
      'CALC_BA=CHAR(2)'
      'CALC_BAKIYE=NUMERIC(15,4)')
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      
        'SELECT MASRAF_KOD,ADI,ACIKLAMA,BORC AS TOPLAM_BORC,ALACAK AS TOP' +
        'LAM_ALACAK FROM MASRAF')
    OnCalculateField = IB_Query1CalculateField
    ColorScheme = False
    KeyLinks.Strings = (
      'MASRAF.MASRAF_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 96
    Top = 24
  end
end
