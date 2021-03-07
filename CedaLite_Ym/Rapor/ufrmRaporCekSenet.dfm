object frmRaporCekSenet: TfrmRaporCekSenet
  Left = 224
  Top = 99
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'frmRaporCekSenet'
  ClientHeight = 462
  ClientWidth = 522
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
    Width = 522
    Height = 439
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object chk_Sirket: TCheckBox
        Left = 156
        Top = 378
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnEnter = tanzim_ekleEnter
        OnExit = tanzim_ekleExit
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 77
        Width = 514
        Height = 70
        Align = alTop
        TabOrder = 0
        object tanzim_Tarihi: TGroupBox
          Left = 7
          Top = 8
          Width = 247
          Height = 55
          Caption = 'Tanzim Tarihi'
          TabOrder = 0
          object TanzimTar1: TDateTimePicker
            Left = 30
            Top = 20
            Width = 89
            Height = 21
            Date = 37621.411060740740000000
            Time = 37621.411060740740000000
            TabOrder = 1
            OnEnter = TanzimTar1Enter
            OnExit = TanzimTar1Exit
          end
          object TanzimTar2: TDateTimePicker
            Left = 139
            Top = 19
            Width = 89
            Height = 21
            Date = 37621.411088946760000000
            Time = 37621.411088946760000000
            TabOrder = 2
            OnEnter = TanzimTar1Enter
            OnExit = TanzimTar1Exit
          end
          object tanzim_ekle: TCheckBox
            Left = 6
            Top = 22
            Width = 19
            Height = 17
            TabOrder = 0
            OnEnter = tanzim_ekleEnter
            OnExit = tanzim_ekleExit
          end
        end
        object vade_Tarihi: TGroupBox
          Left = 258
          Top = 8
          Width = 247
          Height = 55
          Caption = 'Vade Tarihi'
          TabOrder = 1
          object VadeTar1: TDateTimePicker
            Left = 30
            Top = 20
            Width = 89
            Height = 21
            Date = 37621.411060740740000000
            Time = 37621.411060740740000000
            TabOrder = 1
            OnEnter = TanzimTar1Enter
            OnExit = TanzimTar1Exit
          end
          object VadeTar2: TDateTimePicker
            Left = 139
            Top = 19
            Width = 89
            Height = 21
            Date = 37621.411088946760000000
            Time = 37621.411088946760000000
            TabOrder = 2
            OnEnter = TanzimTar1Enter
            OnExit = TanzimTar1Exit
          end
          object vade_ekle: TCheckBox
            Left = 6
            Top = 22
            Width = 19
            Height = 17
            TabOrder = 0
            OnEnter = tanzim_ekleEnter
            OnExit = tanzim_ekleExit
          end
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 147
        Width = 514
        Height = 75
        Align = alTop
        TabOrder = 1
        object durum: TRadioGroup
          Left = 6
          Top = 7
          Width = 247
          Height = 59
          Caption = 'Durumu'
          Columns = 3
          ItemIndex = 4
          Items.Strings = (
            'Beklemede'
            #214'denmi'#351
            'Protestolu'
            #304'ptal'
            'Hepsi')
          TabOrder = 0
          OnEnter = durumEnter
          OnExit = durumExit
        end
        object yer_kodu: TRadioGroup
          Left = 258
          Top = 7
          Width = 247
          Height = 59
          Caption = 'Yer Kodu'
          Columns = 3
          ItemIndex = 4
          Items.Strings = (
            'Portf'#246'yde'
            'Ciro'
            'Tahsil'
            'Teminat'
            'Hepsi')
          TabOrder = 1
          OnEnter = durumEnter
          OnExit = durumExit
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 222
        Width = 514
        Height = 78
        Align = alTop
        TabOrder = 2
        object tip: TRadioGroup
          Left = 6
          Top = 10
          Width = 499
          Height = 59
          Caption = 'Tipi'
          Columns = 3
          ItemIndex = 2
          Items.Strings = (
            'Ciro'
            'As'#305'l'
            'Hepsi')
          TabOrder = 0
          OnEnter = durumEnter
          OnExit = durumExit
        end
        object grp_Banka: TGroupBox
          Left = 6
          Top = 10
          Width = 499
          Height = 60
          Caption = 'Banka'
          TabOrder = 1
          object txt_Banka: TEdit
            Left = 66
            Top = 22
            Width = 123
            Height = 21
            TabOrder = 1
            OnEnter = txt_BankaEnter
            OnExit = txt_BankaExit
            OnKeyDown = txt_BankaKeyDown
          end
          object btnBankaKod: TButton
            Left = 192
            Top = 22
            Width = 17
            Height = 20
            Caption = '...'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            TabStop = False
            OnClick = btnBankaKodClick
          end
          object sadece_banka: TCheckBox
            Left = 18
            Top = 24
            Width = 14
            Height = 17
            TabOrder = 0
            OnEnter = tanzim_ekleEnter
            OnExit = tanzim_ekleExit
          end
        end
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 300
        Width = 514
        Height = 72
        Align = alTop
        TabOrder = 3
        object tutar: TGroupBox
          Left = 7
          Top = 9
          Width = 300
          Height = 54
          Caption = 'Varsay'#305'lan Para Birimi'
          TabOrder = 0
          object Label1: TLabel
            Left = 132
            Top = 24
            Width = 24
            Height = 13
            Caption = '> -- <'
          end
          object tutar1: TIB_Currency
            Left = 12
            Top = 22
            Width = 114
            Height = 21
            TabOrder = 0
            OnEnter = tutar1Enter
            OnExit = tutar1Exit
            OnKeyPress = tutar1KeyPress
            AlwaysShowButton = True
          end
          object tutar2: TIB_Currency
            Left = 168
            Top = 22
            Width = 114
            Height = 21
            TabOrder = 1
            OnEnter = tutar1Enter
            OnExit = tutar1Exit
            OnKeyPress = tutar2KeyPress
            AlwaysShowButton = True
          end
        end
        object grpSube: TGroupBox
          Left = 314
          Top = 9
          Width = 191
          Height = 54
          Caption = #350'ube Ad'#305
          TabOrder = 1
          object cmbSube: TComboBox
            Left = 28
            Top = 21
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
      object GroupBox5: TGroupBox
        Left = 0
        Top = 0
        Width = 514
        Height = 39
        Align = alTop
        TabOrder = 5
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
          TabStop = False
          OnClick = btnCARIClick
        end
        object chkCARI: TCheckBox
          Left = 485
          Top = 14
          Width = 14
          Height = 17
          TabOrder = 1
        end
      end
      object GroupBox6: TGroupBox
        Left = 0
        Top = 39
        Width = 514
        Height = 38
        Align = alTop
        TabOrder = 6
        object txtBelgeNo: TEdit
          Left = 120
          Top = 12
          Width = 97
          Height = 21
          TabOrder = 1
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
          Items.Strings = (
            'Fi'#351' Numaras'#305
            'Belge Numaras'#305)
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 429
    Width = 522
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
    object Button3: TButton
      Left = 442
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object Btn_Fast: TButton
      Left = 214
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
    Left = 184
    Top = 436
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
    ReportOptions.LastChange = 39164.408800092590000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 184
    Top = 249
    Datasets = <
      item
        DataSet = frxIBODts_Senet_Har
        DataSetName = 'frxIBODts_Senet_Har'
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
  object frxIBODts_Cek_Har: TfrxIBODataset
    UserName = 'frxIBODts_Cek_Har'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CEK_ID=CEK_ID'
      'CARI_KOD=CARI_KOD'
      'CARI_AD=CARI_AD'
      'TANZIMTAR=TANZIMTAR'
      'VADETAR=VADETAR'
      'CEK_SAHIBI=CEK_SAHIBI'
      'ACIKLAMA=ACIKLAMA'
      'BANKA_AD=BANKA_AD'
      'CEK_NUM=CEK_NUM'
      'DOVKOD=DOVKOD'
      'DOVKUR=DOVKUR'
      'TUTAR=TUTAR'
      'TUTAR_VPB=TUTAR_VPB'
      'DB_KEY=DB_KEY')
    DataSet = IB_Query1
    Left = 192
    Top = 169
  end
  object IB_Query1: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_FIDAN.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      
        'SELECT CEK_ID,CARI_KOD,(SELECT CARI_AD FROM CARI WHERE CARI.CARI' +
        '_KOD = CEK.CARI_KOD) AS CARI_AD,CEK.TANZIMTAR,CEK.VADETAR,CEK.CE' +
        'K_SAHIBI,CEK.ACIKLAMA,CEK.BANKA_AD,CEK.CEK_NUM,CEK.DOVKOD,CEK.DO' +
        'VKUR,CEK.TUTAR,CEK.TUTAR_VPB FROM CEK')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 264
    Top = 144
  end
  object frxIBODts_Senet_Har: TfrxIBODataset
    UserName = 'frxIBODts_Senet_Har'
    CloseDataSource = False
    FieldAliases.Strings = (
      'SENET_ID=SENET_ID'
      'TANZIMTAR=TANZIMTAR'
      'VADETAR=VADETAR'
      'SENET_SAHIBI=SENET_SAHIBI'
      'ACIKLAMA=ACIKLAMA'
      'TANZIM_YER=TANZIM_YER'
      'SENET_ID=SENET_ID'
      'DOVKOD=DOVKOD'
      'DOVKUR=DOVKUR'
      'TUTAR=TUTAR'
      'TUTAR_VPB=TUTAR_VPB'
      'DB_KEY=DB_KEY')
    DataSet = IB_Query2
    Left = 304
    Top = 249
  end
  object IB_Query2: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_FIDAN.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      
        'SELECT SENET_ID,SENET.TANZIMTAR,SENET.VADETAR,SENET.SENET_SAHIBI' +
        ',SENET.ACIKLAMA,SENET.TANZIM_YER,SENET.SENET_ID,SENET.DOVKOD,SEN' +
        'ET.DOVKUR,SENET.TUTAR,SENET.TUTAR_VPB FROM SENET')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 376
    Top = 224
  end
end
