object frmRaporToplamArac: TfrmRaporToplamArac
  Left = 263
  Top = 153
  Caption = 'Toplam Ara'#231' Mazot Raporu'
  ClientHeight = 204
  ClientWidth = 574
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 312
    Top = 8
    Width = 58
    Height = 13
    Caption = 'Toplam Litre'
  end
  object Label2: TLabel
    Left = 312
    Top = 32
    Width = 53
    Height = 13
    Caption = 'Toplam Km'
  end
  object Label3: TLabel
    Left = 312
    Top = 56
    Width = 69
    Height = 13
    Caption = 'Lt/Km Y'#252'zdesi'
  end
  object Label4: TLabel
    Left = 312
    Top = 80
    Width = 76
    Height = 13
    Caption = 'Toplam '#214'denen'
  end
  object Label5: TLabel
    Left = 312
    Top = 104
    Width = 61
    Height = 13
    Caption = 'Fark Y'#252'zdesi'
  end
  object Label6: TLabel
    Left = 312
    Top = 128
    Width = 21
    Height = 13
    Caption = 'Fark'
  end
  object Label20: TLabel
    Left = 18
    Top = 71
    Width = 50
    Height = 13
    Caption = 'Ara'#231' Kodu'
  end
  object LblPlaka: TLabel
    Left = 18
    Top = 95
    Width = 231
    Height = 13
    AutoSize = False
    Caption = 'Ara'#231' Plaka'
  end
  object lbl_Toplam_Litre: TLabel
    Left = 476
    Top = 8
    Width = 77
    Height = 13
    Alignment = taRightJustify
    Caption = 'lbl_Toplam_Litre'
  end
  object lbl_Toplam_Km: TLabel
    Left = 481
    Top = 32
    Width = 72
    Height = 13
    Alignment = taRightJustify
    Caption = 'lbl_Toplam_Km'
  end
  object lbl_LtKm_Yuzdesi: TLabel
    Left = 470
    Top = 56
    Width = 83
    Height = 13
    Alignment = taRightJustify
    Caption = 'lbl_LtKm_Yuzdesi'
  end
  object lbl_Toplam_Odenen: TLabel
    Left = 458
    Top = 80
    Width = 95
    Height = 13
    Alignment = taRightJustify
    Caption = 'lbl_Toplam_Odenen'
  end
  object lb_Fark_Yuzdesi: TLabel
    Left = 475
    Top = 104
    Width = 78
    Height = 13
    Alignment = taRightJustify
    Caption = 'lb_Fark_Yuzdesi'
  end
  object lbl_Fark: TLabel
    Left = 516
    Top = 128
    Width = 37
    Height = 13
    Alignment = taRightJustify
    Caption = 'lbl_Fark'
  end
  object Label9: TLabel
    Left = 16
    Top = 120
    Width = 40
    Height = 13
    Caption = 'Litre/Km'
  end
  object AracLtKm: TLabel
    Left = 80
    Top = 120
    Width = 6
    Height = 13
    Caption = '0'
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 0
    Width = 249
    Height = 46
    Caption = 'Tarih Aral'#305#287#305
    TabOrder = 0
    object dtpIslemTar1: TDateTimePicker
      Left = 6
      Top = 16
      Width = 100
      Height = 21
      Date = 37554.733220983800000000
      Time = 37554.733220983800000000
      Checked = False
      TabOrder = 0
    end
    object dtpIslemTar2: TDateTimePicker
      Left = 143
      Top = 15
      Width = 100
      Height = 21
      Date = 37554.733416122690000000
      Time = 37554.733416122690000000
      Checked = False
      TabOrder = 1
    end
  end
  object txtArac: TEdit
    Left = 105
    Top = 68
    Width = 127
    Height = 21
    TabOrder = 1
    OnExit = txtAracExit
  end
  object Button6: TButton
    Left = 234
    Top = 68
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
    OnClick = Button6Click
  end
  object Btn_Hesapla: TButton
    Left = 488
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Hesapla'
    TabOrder = 3
    OnClick = Btn_HesaplaClick
  end
  object BtnRapor: TButton
    Left = 344
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Rapor'
    TabOrder = 4
    Visible = False
  end
  object Button1: TButton
    Left = 488
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Kapat'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 280
    Top = 176
    Width = 97
    Height = 25
    Caption = 'T'#252'm'#252'n'#252' Raporla'
    TabOrder = 6
    OnClick = Button2Click
  end
  object cb_Ozmal: TCheckBox
    Left = 176
    Top = 184
    Width = 97
    Height = 17
    Caption = #214'zmal Olanlar'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object cb_LtKm: TCheckBox
    Left = 16
    Top = 184
    Width = 137
    Height = 17
    Caption = 'Litre Km De'#287'eri Olanlar'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object Qry_Temp: TIB_Query
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 272
    Top = 16
  end
  object frxIBODts_MazotLitre: TfrxIBODataset
    UserName = 'frxIBODts_MazotLitre'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ARAC_KOD=ARAC_KOD'
      'ARAC_SID=ARAC_SID'
      'PLAKA=PLAKA'
      'ARAC_TIP=ARAC_TIP'
      'OZ_MAL=OZ_MAL'
      'CARI_KOD=CARI_KOD'
      'CARI_ADI=CARI_ADI'
      'PERSONEL_KOD=PERSONEL_KOD'
      'PERSONEL_ADI=PERSONEL_ADI'
      'AKTIF_DEGIL=AKTIF_DEGIL'
      'YAKIT_LITRE=YAKIT_LITRE'
      'TOPLAM_LITRE=TOPLAM_LITRE'
      'TOPLAM_KM=TOPLAM_KM'
      'YUZDE=YUZDE'
      'FARK=FARK'
      'TOPLAM_ODENEN=TOPLAM_ODENEN'
      'FARK_YUZDESI=FARK_YUZDESI')
    DataSet = IB_Query1
    Left = 128
    Top = 9
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
    ReportOptions.LastChange = 39190.758781284720000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 168
    Top = 9
  end
  object IB_Query1: TIB_Query
    CalculatedFields.Strings = (
      'TOPLAM_LITRE=FLOAT'
      'TOPLAM_KM=FLOAT'
      'YUZDE=FLOAT'
      'FARK=FLOAT'
      'TOPLAM_ODENEN=FLOAT'
      'FARK_YUZDESI=FLOAT')
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT ARAC_KOD'
      '     , ARAC_SID'
      '     , PLAKA'
      '     , ARAC_TIP'
      '     , OZ_MAL'
      '     , CARI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE ARAC.CARI_KOD=CARI.CARI_KO' +
        'D) AS CARI_ADI    '
      '     , PERSONEL_KOD'
      
        '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_K' +
        'OD=ARAC.PERSONEL_KOD) AS PERSONEL_ADI    '
      '     , AKTIF_DEGIL'
      '     , YAKIT_LITRE'
      'FROM ARAC')
    OnCalculateField = IB_Query1CalculateField
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 224
    Top = 8
  end
end
