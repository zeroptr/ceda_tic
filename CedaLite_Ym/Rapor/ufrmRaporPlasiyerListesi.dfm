object frmRaporPlasiyerListesi: TfrmRaporPlasiyerListesi
  Left = 260
  Top = 244
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Plasiyer Listesi'
  ClientHeight = 212
  ClientWidth = 295
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
    Width = 295
    Height = 175
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object chk_Sirket: TCheckBox
        Left = 36
        Top = 122
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
        Width = 287
        Height = 73
        Align = alTop
        Caption = 'Plasiyer Kod Aral'#305#287#305
        TabOrder = 0
        object txtPlasiyerKod1: TEdit
          Left = 8
          Top = 16
          Width = 131
          Height = 21
          TabOrder = 0
          OnEnter = txtPlasiyerKod1Enter
          OnExit = txtPlasiyerKod1Exit
          OnKeyDown = txtPlasiyerKod1KeyDown
          OnKeyPress = txtPlasiyerKod1KeyPress
        end
        object txtPlasiyerKod2: TEdit
          Left = 147
          Top = 16
          Width = 130
          Height = 21
          TabOrder = 1
          OnEnter = txtPlasiyerKod1Enter
          OnExit = txtPlasiyerKod2Exit
          OnKeyDown = txtPlasiyerKod2KeyDown
          OnKeyPress = txtPlasiyerKod1KeyPress
        end
        object Button1: TButton
          Left = 8
          Top = 38
          Width = 131
          Height = 25
          Caption = '&Plasiyer Listesi'
          TabOrder = 2
          TabStop = False
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 148
          Top = 38
          Width = 129
          Height = 25
          Caption = 'P&lasiyer Listesi'
          TabOrder = 3
          TabStop = False
          OnClick = Button2Click
        end
      end
      object grpSube: TGroupBox
        Left = 0
        Top = 73
        Width = 287
        Height = 41
        Align = alTop
        Caption = #350'ube Ad'#305
        TabOrder = 1
        object cmbSube: TComboBox
          Left = 76
          Top = 12
          Width = 135
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
        Top = 4
        Width = 40
        Height = 13
        Caption = 'S'#305'ralama'
      end
      object cmb_sirala: TComboBox
        Left = 4
        Top = 18
        Width = 279
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'Plasiyer koduna g'#246're'
        OnEnter = cmbSubeEnter
        OnExit = cmbSubeExit
        Items.Strings = (
          'Plasiyer koduna g'#246're'
          'Plasiyer ad'#305' soyad'#305'na g'#246're')
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 179
    Width = 295
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 9
      Top = 4
      Width = 76
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object Button3: TButton
      Left = 212
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object Btn_Fast: TButton
      Left = 110
      Top = 4
      Width = 77
      Height = 25
      Caption = '&Rapor'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object qryPlasiyer: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_FIDAN.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 114
    Top = 78
  end
  object qryRapor: TIB_Cursor
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_FIDAN.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 202
    Top = 86
  end
  object frxIBODts_Plasiyer: TfrxIBODataset
    UserName = 'frxIBODts_Plasiyer'
    CloseDataSource = False
    FieldAliases.Strings = (
      'PLASIYER_KOD=PLASIYER_KOD'
      'PLASIYER_SID=PLASIYER_SID'
      'ADISOY=ADISOY'
      'FIRMA_ID=FIRMA_ID'
      'TELNO_1=TELNO_1'
      'TELNO_2=TELNO_2'
      'FAX=FAX'
      'ADRES_1=ADRES_1'
      'ADRES_2=ADRES_2'
      'ILCE=ILCE'
      'SEHIR=SEHIR'
      'POSTAKOD=POSTAKOD'
      'EMAIL=EMAIL'
      'WEBADDR=WEBADDR'
      'DOVKOD=DOVKOD'
      'BORC=BORC'
      'ALACAK=ALACAK'
      'BORC_VPB=BORC_VPB'
      'ALACAK_VPB=ALACAK_VPB'
      'PASIF=PASIF'
      'DEVREDEN_BORC=DEVREDEN_BORC'
      'DEVREDEN_ALACAK=DEVREDEN_ALACAK'
      'DEVREDEN_BORC_VPB=DEVREDEN_BORC_VPB'
      'DEVREDEN_ALACAK_VPB=DEVREDEN_ALACAK_VPB'
      'BORC_TOP=BORC_TOP'
      'ALACAK_TOP=ALACAK_TOP')
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
    ReportOptions.LastChange = 39163.671406782410000000
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
        DataSet = frxIBODts_Plasiyer
        DataSetName = 'frxIBODts_Plasiyer'
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
      'SELECT PLASIYER.*,'
      
        ' (SELECT SUM(CARIHAR.TUTAR_VPB) FROM CARIHAR WHERE CARIHAR.PLASI' +
        'YER_KOD = PLASIYER.PLASIYER_KOD AND CARIHAR.TIP = '#39'B'#39') AS BORC_T' +
        'OP,'
      
        '(SELECT SUM(CARIHAR.TUTAR_VPB) FROM CARIHAR WHERE CARIHAR.PLASIY' +
        'ER_KOD = PLASIYER.PLASIYER_KOD AND CARIHAR.TIP = '#39'A'#39') AS ALACAK_' +
        'TOP'
      'FROM PLASIYER')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 120
    Top = 32
  end
end
