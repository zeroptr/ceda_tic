object frmRaporKasaAylik: TfrmRaporKasaAylik
  Left = 547
  Top = 286
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Ayl'#305'k Kasa Raporu'
  ClientHeight = 143
  ClientWidth = 235
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
    Width = 235
    Height = 109
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object chk_Sirket: TCheckBox
        Left = 6
        Top = 56
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnEnter = chk_SirketEnter
        OnExit = chk_SirketExit
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 227
        Height = 49
        Align = alTop
        Caption = 'Kasa Kodu'
        TabOrder = 0
        object txtKasaKod: TEdit
          Left = 8
          Top = 16
          Width = 107
          Height = 21
          TabOrder = 0
          OnEnter = txtKasaKodEnter
          OnExit = txtKasaKodExit
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
    end
  end
  object Memo1: TMemo
    Left = 6
    Top = 156
    Width = 223
    Height = 77
    Lines.Strings = (
      '')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 110
    Width = 235
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 5
      Top = 4
      Width = 68
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object Button3: TButton
      Left = 165
      Top = 4
      Width = 65
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object btn_Fast: TButton
      Left = 84
      Top = 4
      Width = 72
      Height = 25
      Caption = 'Rapor Olu'#351'tur'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object qryKasaAlan: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_FIDAN.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 80
    Top = 68
  end
  object qryRapor: TIB_Cursor
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_FIDAN.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 140
    Top = 68
  end
  object frxIBODts_Kasa_Aylik: TfrxIBODataset
    UserName = 'frxIBODts_Kasa_Aylik'
    CloseDataSource = False
    FieldAliases.Strings = (
      'DOVKOD=DOVKOD'
      'AY=AY'
      'BORC=BORC'
      'ALACAK=ALACAK'
      'BORC_VPB=BORC_VPB'
      'ALACAK_VPB=ALACAK_VPB'
      'TIP=TIP'
      'BAKIYE=BAKIYE')
    DataSet = IB_Query1
    Left = 64
    Top = 17
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
    ReportOptions.LastChange = 39162.423152662040000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 112
    Top = 1
    Datasets = <
      item
        DataSet = frxIBODts_Kasa_Aylik
        DataSetName = 'frxIBODts_Kasa_Aylik'
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
      'CALC_AYLAR=CHAR(30)')
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_FIDAN.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT KASA.DOVKOD,'
      'KASA_AY.AY,'
      'KASA_AY.BORC,'
      'KASA_AY.ALACAK,'
      'KASA_AY.BORC_VPB,'
      'KASA_AY.ALACAK_VPB,'
      '(case'
      'when'
      '(KASA_AY.BORC_VPB>KASA_AY.ALACAK_VPB)'
      'then '#39'B'#39
      'when'
      '(KASA_AY.ALACAK_VPB>KASA_AY.BORC_VPB)'
      'then '#39'A'#39
      'end ) Tip,'
      '(case'
      'when'
      '(KASA_AY.BORC_VPB>KASA_AY.ALACAK_VPB)'
      'then'
      'KASA_AY.BORC_VPB-KASA_AY.ALACAK_VPB'
      'when'
      '(KASA_AY.ALACAK_VPB>KASA_AY.BORC_VPB)'
      'then'
      'KASA_AY.ALACAK_VPB-KASA_AY.BORC_VPB'
      'end )Bakiye'
      'FROM KASA_AY'
      'LEFT OUTER JOIN KASA ON (KASA_AY.KASA_KOD = KASA.KASA_KOD)')
    OnCalculateField = IB_Query1CalculateField
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 168
    Top = 8
  end
end
