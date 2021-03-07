object frmRaporAracListesi: TfrmRaporAracListesi
  Left = 283
  Top = 260
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'Genel Ara'#231' Listesi'
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
        Caption = 'Ara'#231' Kod Aral'#305#287#305
        TabOrder = 0
        object txtAracKod1: TEdit
          Left = 8
          Top = 16
          Width = 119
          Height = 21
          TabOrder = 0
          OnEnter = txtAracKod1Enter
          OnExit = txtAracKod1Exit
          OnKeyDown = txtAracKod1KeyDown
          OnKeyPress = txtAracKod1KeyPress
        end
        object Button1: TButton
          Left = 8
          Top = 38
          Width = 119
          Height = 25
          Caption = '&Ara'#231' Listesi'
          TabOrder = 1
          TabStop = False
          OnClick = Button1Click
        end
        object txtAracKod2: TEdit
          Left = 134
          Top = 16
          Width = 119
          Height = 21
          TabOrder = 2
          OnEnter = txtAracKod1Enter
          OnExit = txtAracKod2Exit
          OnKeyDown = txtAracKod2KeyDown
          OnKeyPress = txtAracKod1KeyPress
        end
        object Button2: TButton
          Left = 134
          Top = 38
          Width = 119
          Height = 25
          Caption = 'Ara'#231' &Listesi'
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
        Visible = False
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
        TabOrder = 0
        OnEnter = cmbSubeEnter
        OnExit = cmbSubeExit
        Items.Strings = (
          'Ara'#231' Koduna G'#246're'
          'Plakaya G'#246're')
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
      Left = 192
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object Btn_Fast: TButton
      Left = 98
      Top = 4
      Width = 77
      Height = 25
      Caption = '&Rapor'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object qryRapor: TIB_Query
    CalculatedFields.Strings = (
      'CALC_TIPI=CHAR(10)'
      'CALC_OZMAL=CHAR(10)')
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT ARAC_KOD '
      ', PLAKA '
      ', ARAC_TIP '
      ', OZ_MAL '
      ', CARI_KOD '
      
        ',(SELECT CARI_AD FROM CARI WHERE ARAC.CARI_KOD=CARI.CARI_KOD) AS' +
        ' CARI_ADI '
      ', ACIKLAMA '
      ', BORC '
      ', ALACAK '
      ', AKTIF_DEGIL '
      ', YAKIT_LITRE '
      ', TRF_SIG_GEC_TAR '
      ', KASKO_SIG_GEC_TAR '
      ', PERSONEL_KOD '
      
        ',(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=AR' +
        'AC.PERSONEL_KOD) AS PERSONEL_ADI '
      'FROM ARAC')
    OnCalculateField = qryRaporCalculateField
    ColorScheme = False
    KeyLinks.Strings = (
      'ARAC.ARAC_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 92
    Top = 91
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
    ReportOptions.LastChange = 39164.690736574080000000
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
        DataSet = frxIBODts_Arac_Lis
        DataSetName = 'frxIBODts_Arac_Lis'
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
  object frxIBODts_Arac_Lis: TfrxIBODataset
    UserName = 'frxIBODts_Arac_Lis'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ARAC_KOD=ARAC_KOD'
      'PLAKA=PLAKA'
      'ARAC_TIP=ARAC_TIP'
      'OZ_MAL=OZ_MAL'
      'CARI_KOD=CARI_KOD'
      'CARI_ADI=CARI_ADI'
      'ACIKLAMA=ACIKLAMA'
      'BORC=BORC'
      'ALACAK=ALACAK'
      'AKTIF_DEGIL=AKTIF_DEGIL'
      'YAKIT_LITRE=YAKIT_LITRE'
      'TRF_SIG_GEC_TAR=TRF_SIG_GEC_TAR'
      'KASKO_SIG_GEC_TAR=KASKO_SIG_GEC_TAR'
      'PERSONEL_KOD=PERSONEL_KOD'
      'PERSONEL_ADI=PERSONEL_ADI'
      'CALC_TIPI=CALC_TIPI'
      'CALC_OZMAL=CALC_OZMAL')
    DataSet = qryRapor
    Left = 56
    Top = 25
  end
end
