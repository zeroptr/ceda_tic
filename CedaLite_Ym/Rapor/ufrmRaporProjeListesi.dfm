object frmRaporProjeListesi: TfrmRaporProjeListesi
  Left = 283
  Top = 260
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Genel Proje Listesi'
  ClientHeight = 215
  ClientWidth = 271
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
    Width = 271
    Height = 181
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object chk_Sirket: TCheckBox
        Left = 23
        Top = 128
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
        Width = 263
        Height = 73
        Align = alTop
        Caption = 'Proje Kod Aral'#305#287#305
        TabOrder = 0
        object txtProjeKod1: TEdit
          Left = 8
          Top = 16
          Width = 119
          Height = 21
          TabOrder = 0
          OnEnter = txtProjeKod1Enter
          OnExit = txtProjeKod1Exit
          OnKeyDown = txtProjeKod1KeyDown
          OnKeyPress = txtProjeKod1KeyPress
        end
        object Button1: TButton
          Left = 8
          Top = 38
          Width = 119
          Height = 25
          Caption = '&Proje Listesi'
          TabOrder = 2
          TabStop = False
          OnClick = Button1Click
        end
        object txtProjeKod2: TEdit
          Left = 134
          Top = 16
          Width = 119
          Height = 21
          TabOrder = 1
          OnEnter = txtProjeKod1Enter
          OnExit = txtProjeKod2Exit
          OnKeyDown = txtProjeKod2KeyDown
          OnKeyPress = txtProjeKod1KeyPress
        end
        object Button2: TButton
          Left = 134
          Top = 38
          Width = 119
          Height = 25
          Caption = 'P&roje Listesi'
          TabOrder = 3
          TabStop = False
          OnClick = Button2Click
        end
      end
      object grpSube: TGroupBox
        Left = 0
        Top = 73
        Width = 263
        Height = 49
        Align = alTop
        Caption = #350'ube Ad'#305
        TabOrder = 1
        object cmbSube: TComboBox
          Left = 70
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
    object TabSheet2: TTabSheet
      Caption = 'Ko'#351'ullar'
      ImageIndex = 1
      object Label3: TLabel
        Left = 6
        Top = -2
        Width = 40
        Height = 13
        Caption = 'S'#305'ralama'
      end
      object cmb_sirala: TComboBox
        Left = 6
        Top = 12
        Width = 250
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'Proje Koduna G'#246're'
        OnEnter = cmbSubeEnter
        OnExit = cmbSubeExit
        Items.Strings = (
          'Proje Koduna G'#246're'
          'Proje Ad'#305'na G'#246're')
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 182
    Width = 271
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
      Left = 190
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
  object qryRapor: TIB_Cursor
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_FIDAN.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 192
    Top = 56
  end
  object frxIBODts_Proje: TfrxIBODataset
    UserName = 'frxIBODts_Proje'
    CloseDataSource = False
    FieldAliases.Strings = (
      'PROJE_KOD=PROJE_KOD'
      'PROJE_AD=PROJE_AD'
      'ACIKLAMA=ACIKLAMA'
      'DOVKOD=DOVKOD'
      'BORC=BORC'
      'ALACAK=ALACAK'
      'BORC_VPB=BORC_VPB'
      'ALACAK_VPB=ALACAK_VPB'
      'DB_KEY=DB_KEY')
    DataSet = IB_Query1
    Left = 48
    Top = 57
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
    ReportOptions.LastChange = 39163.658084120370000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 48
    Top = 105
    Datasets = <
      item
        DataSet = frxIBODts_Proje
        DataSetName = 'frxIBODts_Proje'
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
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_FIDAN.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      
        'SELECT PROJE.PROJE_KOD,PROJE.PROJE_AD,PROJE.ACIKLAMA,PROJE.DOVKO' +
        'D,PROJE.BORC,PROJE.ALACAK,PROJE.BORC_VPB,PROJE.ALACAK_VPB FROM P' +
        'ROJE')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 120
    Top = 32
  end
end
