object frmRaporSrvAracListesi: TfrmRaporSrvAracListesi
  Left = 383
  Top = 172
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'Genel Ara'#231' Listesi'
  ClientHeight = 295
  ClientWidth = 275
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
    Width = 275
    Height = 281
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object chk_Sirket: TCheckBox
        Left = 23
        Top = 208
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
        Top = 73
        Width = 267
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
          Left = 140
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
          Left = 140
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
        Top = 146
        Width = 267
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
      object grb1: TGroupBox
        Left = 0
        Top = 0
        Width = 267
        Height = 73
        Align = alTop
        Caption = 'Cari Kod Aral'#305#287#305
        TabOrder = 3
        object txtCariKod1: TEdit
          Left = 8
          Top = 16
          Width = 122
          Height = 21
          TabOrder = 0
          OnEnter = txtCariKod1Enter
          OnExit = txtCariKod1Exit
          OnKeyDown = txtCariKod1KeyDown
          OnKeyPress = txtAracKod1KeyPress
        end
        object txtCariKod2: TEdit
          Left = 138
          Top = 16
          Width = 121
          Height = 21
          TabOrder = 1
          OnEnter = txtAracKod1Enter
          OnExit = txtCariKod2Exit
          OnKeyDown = txtCariKod2KeyDown
          OnKeyPress = txtAracKod1KeyPress
        end
        object btnCariListe1: TButton
          Left = 9
          Top = 38
          Width = 121
          Height = 25
          Caption = '&Cari Listesi'
          TabOrder = 2
          TabStop = False
          OnClick = btnCariListe1Click
        end
        object btnCariListe2: TButton
          Left = 138
          Top = 38
          Width = 121
          Height = 25
          Caption = 'C&ari Listesi'
          TabOrder = 3
          TabStop = False
          OnClick = btnCariListe2Click
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
    Top = 262
    Width = 275
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
      Visible = False
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
      'SELECT ARAC_KOD'
      '     , ARAC_SID'
      '     , PLAKA'
      '     , CARI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE SRV_ARAC.CARI_KOD=CARI.CAR' +
        'I_KOD) AS CARI_ADI    '
      
        '     ,(SELECT TEL_NO_1 FROM CARI WHERE SRV_ARAC.CARI_KOD=CARI.CA' +
        'RI_KOD) AS TELEFON1 '
      
        '     ,(SELECT TEL_NO_2 FROM CARI WHERE SRV_ARAC.CARI_KOD=CARI.CA' +
        'RI_KOD) AS TELEFON2 '
      '     , ACIKLAMA'
      '     , AKTIF_DEGIL'
      '     , TRF_SIG_GEC_TAR'
      '     , KASKO_SIG_GEC_TAR'
      '     , AS_ADISOYADI'
      '     , AS_DOGUM_YERI'
      '     , AS_NUFUS_IL'
      '     , AS_NUFUS_ILCE'
      '     , AS_DOGUM_TARIHI'
      '     , AS_IKA_ADRES'
      '     , AS_SERI_NO'
      '     , AS_MUYANE_GECERLILIK_SUR'
      '     , ARAC_MARKA'
      '     , ARAC_MARKA_TIP'
      '     , TRAFIK_CIKIS_TAR'
      '     , MODEL_YILI'
      '     , SON_ONARIM_KM'
      '     , RADYO_TEYP'
      '     , ALARM'
      '     , SIGORTA_KOD'
      
        '     ,(SELECT ADI FROM SRV_ARAC_SIGORTA WHERE SRV_ARAC.SIGORTA_K' +
        'OD=SRV_ARAC_SIGORTA.SIGORTA_KOD) AS SIGORTA_ADI'
      '     , BAYI_KOD'
      
        '     ,(SELECT BAYI_ADI FROM SRV_ARAC_BAYI WHERE SRV_ARAC.BAYI_KO' +
        'D=SRV_ARAC_BAYI.BAYI_KOD) AS BAYI_ADI'
      '     , RADYO_KOD_NUM'
      '     , LASTIK_EBADI'
      '     , ANAHTAR_NUMARASI'
      '     , NOTLAR'
      '     , IL'
      '     , ILCE'
      '     , TESCIL_SIRA_NO'
      '     , TESCIL_TARIHI'
      '     , PLAKA_NO'
      '     , MARKASI'
      '     , MODELI'
      '     , CINSI'
      '     , ARAZI'
      '     , TIPI'
      '     , RENGI'
      '     , MOTOR_NO'
      '     , SASI_NO'
      '     , RUHSAT_BILGILERI'
      '     , SILINDIR_HACMI'
      '     , MOTOR_GUCU'
      '     , ISTIAP_HADDI'
      '     , KISI'
      '     , IMALATCI_YERLI'
      '     , KULLANIM_TIPI'
      '     , YAKIT_TIPI'
      '     , YUK_TASIMA'
      '     , ROMORK_TAKMA'
      '     , TAKSIMETRE'
      '     , TAKOMETRE'
      '     , NET_AGIRLIK'
      '     , KATAR_AGIRLIGI'
      '     , ROMORK_ISTIAPHAD'
      '     , MUYANE_GECERLILIK_SUR'
      '     , ONAYLAYAN_SICIL'
      '     , SERI_G_NO'
      '     , BORC'
      '     , ALACAK'
      '     , DEVREDEN_BORC'
      '     , DEVREDEN_ALACAK'
      '     , RESIM'
      '     , SON_ONARIM_TARIHI'
      'FROM SRV_ARAC'
      'WHERE ARAC_KOD=:PRM_ARAC_KOD')
    OnCalculateField = qryRaporCalculateField
    ColorScheme = False
    KeyLinks.Strings = (
      'SRV_ARAC.ARAC_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 92
    Top = 91
    ParamValues = (
      'PRM_ARAC_KOD=')
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
    ReportOptions.LastChange = 39177.724403564820000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 96
    Top = 217
    Datasets = <
      item
        DataSet = frxIBODts_Srv_Arac_Lis
        DataSetName = 'frxIBODts_Srv_Arac_Lis'
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
  object frxIBODts_Srv_Arac_Lis: TfrxIBODataset
    UserName = 'frxIBODts_Srv_Arac_Lis'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ARAC_KOD=ARAC_KOD'
      'ARAC_SID=ARAC_SID'
      'PLAKA=PLAKA'
      'CARI_KOD=CARI_KOD'
      'CARI_ADI=CARI_ADI'
      'TELEFON1=TELEFON1'
      'TELEFON2=TELEFON2'
      'ACIKLAMA=ACIKLAMA'
      'AKTIF_DEGIL=AKTIF_DEGIL'
      'TRF_SIG_GEC_TAR=TRF_SIG_GEC_TAR'
      'KASKO_SIG_GEC_TAR=KASKO_SIG_GEC_TAR'
      'AS_ADISOYADI=AS_ADISOYADI'
      'AS_DOGUM_YERI=AS_DOGUM_YERI'
      'AS_NUFUS_IL=AS_NUFUS_IL'
      'AS_NUFUS_ILCE=AS_NUFUS_ILCE'
      'AS_DOGUM_TARIHI=AS_DOGUM_TARIHI'
      'AS_IKA_ADRES=AS_IKA_ADRES'
      'AS_SERI_NO=AS_SERI_NO'
      'AS_MUYANE_GECERLILIK_SUR=AS_MUYANE_GECERLILIK_SUR'
      'ARAC_MARKA=ARAC_MARKA'
      'ARAC_MARKA_TIP=ARAC_MARKA_TIP'
      'TRAFIK_CIKIS_TAR=TRAFIK_CIKIS_TAR'
      'MODEL_YILI=MODEL_YILI'
      'SON_ONARIM_KM=SON_ONARIM_KM'
      'RADYO_TEYP=RADYO_TEYP'
      'ALARM=ALARM'
      'SIGORTA_KOD=SIGORTA_KOD'
      'SIGORTA_ADI=SIGORTA_ADI'
      'BAYI_KOD=BAYI_KOD'
      'BAYI_ADI=BAYI_ADI'
      'RADYO_KOD_NUM=RADYO_KOD_NUM'
      'LASTIK_EBADI=LASTIK_EBADI'
      'ANAHTAR_NUMARASI=ANAHTAR_NUMARASI'
      'NOTLAR=NOTLAR'
      'IL=IL'
      'ILCE=ILCE'
      'TESCIL_SIRA_NO=TESCIL_SIRA_NO'
      'TESCIL_TARIHI=TESCIL_TARIHI'
      'PLAKA_NO=PLAKA_NO'
      'MARKASI=MARKASI'
      'MODELI=MODELI'
      'CINSI=CINSI'
      'ARAZI=ARAZI'
      'TIPI=TIPI'
      'RENGI=RENGI'
      'MOTOR_NO=MOTOR_NO'
      'SASI_NO=SASI_NO'
      'RUHSAT_BILGILERI=RUHSAT_BILGILERI'
      'SILINDIR_HACMI=SILINDIR_HACMI'
      'MOTOR_GUCU=MOTOR_GUCU'
      'ISTIAP_HADDI=ISTIAP_HADDI'
      'KISI=KISI'
      'IMALATCI_YERLI=IMALATCI_YERLI'
      'KULLANIM_TIPI=KULLANIM_TIPI'
      'YAKIT_TIPI=YAKIT_TIPI'
      'YUK_TASIMA=YUK_TASIMA'
      'ROMORK_TAKMA=ROMORK_TAKMA'
      'TAKSIMETRE=TAKSIMETRE'
      'TAKOMETRE=TAKOMETRE'
      'NET_AGIRLIK=NET_AGIRLIK'
      'KATAR_AGIRLIGI=KATAR_AGIRLIGI'
      'ROMORK_ISTIAPHAD=ROMORK_ISTIAPHAD'
      'MUYANE_GECERLILIK_SUR=MUYANE_GECERLILIK_SUR'
      'ONAYLAYAN_SICIL=ONAYLAYAN_SICIL'
      'SERI_G_NO=SERI_G_NO'
      'BORC=BORC'
      'ALACAK=ALACAK'
      'DEVREDEN_BORC=DEVREDEN_BORC'
      'DEVREDEN_ALACAK=DEVREDEN_ALACAK'
      'RESIM=RESIM'
      'SON_ONARIM_TARIHI=SON_ONARIM_TARIHI'
      'CALC_TIPI=CALC_TIPI'
      'CALC_OZMAL=CALC_OZMAL')
    DataSet = qryRapor
    Left = 160
    Top = 201
  end
end
