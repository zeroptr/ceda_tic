object frmRaporAracHareketleriListesi: TfrmRaporAracHareketleriListesi
  Left = 283
  Top = 260
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'Genel Ara'#231' Hareketleri Listesi'
  ClientHeight = 289
  ClientWidth = 269
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
    Width = 269
    Height = 257
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object chk_Sirket: TCheckBox
        Left = 23
        Top = 175
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
        Top = 46
        Width = 261
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
        Top = 119
        Width = 261
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
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 261
        Height = 46
        Align = alTop
        Caption = 'Tarih Aral'#305#287#305
        TabOrder = 3
        object dtpIslemTar1: TDateTimePicker
          Left = 14
          Top = 16
          Width = 100
          Height = 21
          Date = 37554.733220983800000000
          Time = 37554.733220983800000000
          Checked = False
          TabOrder = 0
        end
        object dtpIslemTar2: TDateTimePicker
          Left = 131
          Top = 15
          Width = 100
          Height = 21
          Date = 37554.733416122690000000
          Time = 37554.733416122690000000
          Checked = False
          TabOrder = 1
        end
      end
      object cb_Masraf: TCheckBox
        Left = 23
        Top = 199
        Width = 213
        Height = 17
        Caption = 'Sadece Masraf Hareketleri'
        TabOrder = 4
        OnEnter = chk_SirketEnter
        OnExit = chk_SirketExit
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
        Text = 'Ara'#231' Koduna G'#246're'
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
    Top = 256
    Width = 269
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
  object QryRapor: TIB_Query
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 188
    Top = 75
  end
  object QryRaporH: TIB_Query
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSource = IB_DataSource1
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 132
    Top = 107
  end
  object frxIBODts_Arac_Hark: TfrxIBODataset
    UserName = 'frxIBODts_Arac_Hark'
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
      'BA=BA'
      'TARIH=TARIH'
      'DOVKOD=DOVKOD'
      'DOVKUR=DOVKUR'
      'TUTAR=TUTAR'
      'TUTAR_VPB=TUTAR_VPB'
      'ACIKLAMA1=ACIKLAMA1'
      'BELGE_TUR=BELGE_TUR'
      'BELGE_ID=BELGE_ID'
      'BELGE_SID=BELGE_SID'
      'SIRA_NO=SIRA_NO'
      'MASRAF_MERK=MASRAF_MERK'
      'KOD1=KOD1'
      'KOD2=KOD2'
      'KOD3=KOD3'
      'KOD4=KOD4'
      'CBORC=CBORC'
      'CALACAK=CALACAK'
      'CALC_BELGE_TUR=CALC_BELGE_TUR')
    DataSet = IB_Query1
    Left = 56
    Top = 25
  end
  object frxReport1: TfrxReport
    Version = '4.7.181'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39136.775302905100000000
    ReportOptions.LastChange = 39164.611612222220000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 48
    Top = 105
  end
  object IB_DataSource1: TIB_DataSource
    Dataset = QryRapor
    Left = 132
    Top = 43
  end
  object IB_Query1: TIB_Query
    CalculatedFields.Strings = (
      'CALC_BELGE_TUR=CHAR(50)')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT ARAC.ARAC_KOD'
      ', ARAC.PLAKA'
      ', ARAC.ARAC_TIP'
      ', ARAC.OZ_MAL'
      ', ARAC.CARI_KOD'
      
        ',(SELECT CARI_AD FROM CARI WHERE ARAC.CARI_KOD=CARI.CARI_KOD) AS' +
        ' CARI_ADI'
      ', ARAC.ACIKLAMA'
      ', ARAC.BORC'
      ', ARAC.ALACAK'
      ', ARAC.AKTIF_DEGIL'
      ', ARAC.YAKIT_LITRE'
      ', ARAC.TRF_SIG_GEC_TAR'
      ', ARAC.KASKO_SIG_GEC_TAR'
      ', ARAC.PERSONEL_KOD'
      
        ',(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=AR' +
        'AC.PERSONEL_KOD) AS PERSONEL_ADI'
      ''
      ''
      ',ARACHAR.BA'
      ',ARACHAR.TARIH'
      ',ARACHAR.DOVKOD'
      ',ARACHAR.DOVKUR'
      ',ARACHAR.TUTAR'
      ',ARACHAR.TUTAR_VPB'
      ',ARACHAR.ACIKLAMA ACIKLAMA1'
      ',ARACHAR.BELGE_TUR'
      ',ARACHAR.BELGE_ID'
      ',ARACHAR.BELGE_SID'
      ',ARACHAR.SIRA_NO'
      ',ARACHAR.MASRAF_MERK'
      ',ARACHAR.KOD1'
      ',ARACHAR.KOD2'
      ',ARACHAR.KOD3'
      ',ARACHAR.KOD4'
      ',(case when  ba='#39'B'#39' then'
      'ARACHAR.TUTAR_VPB else 0 end) CBorc'
      ',(case when  ba='#39'A'#39' then'
      'ARACHAR.TUTAR_VPB else 0 end ) CAlacak'
      ''
      ''
      'FROM ARAC'
      'inner join arachar ON (ARACHAR.arac_kod=ARAC.ARAC_KOD)'
      'ORDER BY ARAC.ARAC_KOD')
    OnCalculateField = IB_Query1CalculateField
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 148
    Top = 3
  end
end
