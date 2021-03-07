object frmRaporMazotAracListesi: TfrmRaporMazotAracListesi
  Left = 375
  Top = 202
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'Mazot Ara'#231' Listesi'
  ClientHeight = 233
  ClientWidth = 266
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
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 266
    Height = 46
    Align = alTop
    Caption = 'Tarih Aral'#305#287#305
    TabOrder = 0
    object dtpIslemTar1: TDateTimePicker
      Left = 14
      Top = 16
      Width = 100
      Height = 21
      Date = 37554.733220983800000000
      Time = 37554.733220983800000000
      Checked = False
      TabOrder = 0
      OnEnter = dtpIslemTar1Enter
      OnExit = dtpIslemTar1Exit
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
      OnEnter = dtpIslemTar1Enter
      OnExit = dtpIslemTar1Exit
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 200
    Width = 266
    Height = 33
    Align = alBottom
    TabOrder = 3
    object btnRapor: TButton
      Left = 3
      Top = 4
      Width = 77
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object Button3: TButton
      Left = 183
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object Btn_Fast: TButton
      Left = 93
      Top = 4
      Width = 77
      Height = 25
      Caption = '&Rapor'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object chk_Sirket: TCheckBox
    Left = 19
    Top = 141
    Width = 213
    Height = 17
    Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 46
    Width = 266
    Height = 73
    Align = alTop
    Caption = 'Ara'#231' Kod Aral'#305#287#305
    TabOrder = 1
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
  object qryMazot: TIB_Query
    ColumnAttributes.Strings = (
      'SECIM=BOOLEAN=1,0'
      'ALIS_FATURASI_ALINDI=BOOLEAN=1,0')
    DatabaseName = 'c:\CedaLite\Trans_Db\Transport.FDB'
    FieldsDisplayLabel.Strings = (
      'FIS_NO=Fi'#351' No'
      'KASA_KOD=Kasa Kodu'
      'TARIH=Tarih'
      'DOV_BAZ_TAR=D'#246'viz Baz Tar'
      'ACIKLAMA=A'#231#305'klama'
      'KASA_AD=Kasa Ad'#305
      'CH_ACIKLAMA=C/H A'#231#305'klama'
      'YEV_ACIKLAMA=Yevmiye Defteri A'#231#305'klama'
      'KASAHAR_ID=FIS NO'
      'ARAC_KOD=Ara'#231' Kodu'
      'SEFER_SAY=Sefer Say'#305's'#305
      'ARAC_PLAKA=Ara'#231' Plaka'
      'ALICI_KOD=Al'#305'c'#305' Kodu'
      'ALICI_ADI=Al'#305'c'#305' Ad'#305
      'SATICI_KOD=Sat'#305'c'#305' Kodu'
      'SATICI_ADI=Sat'#305'c'#305' Kodu'
      'PERSONEL_KOD=Personel Kodu'
      'PERSONEL_ADI=Personel Ad'#305
      'OLCU_TIP='#214'l'#231#252' Tip'
      'OLCU_BIRIM='#214'l'#231#252' Birim'
      'TASINAN_ESYA=Ta'#351#305'nan E'#351'ya'
      'BAS_TAR=Ba'#351'lama Tarihi'
      'BIT_TAR=Biti'#351' Tarihi'
      'CIK_YER='#199#305'k'#305#351' Yeri'
      'BIT_YER=Var'#305#351' Yeri'
      'ALICI_BORC_BIRIM_FIY=Birim Fiyat'#305
      'ALICI_B_DOVKOD=D'#246'viz Kodu'
      'ALICI_BORC=Bor'#231
      'ALICI_BORC_VPB=Bor'#231' Vpb'
      'SATICI_ALACAK_BIRIM_FIY=Birim Fiyat'#305
      'SATICI_A_DOVKOD=D'#246'viz Kodu'
      'SATICI_ALACAK=Alacak'
      'SATICI_ALACAK_VPB=Alacak Vpb'
      'BEKLEME_FAT_VAR=Bekleme Faturas'#305
      'BEKLEME_FAT_TUTAR=Tutar'
      'BEKLEME_FAT_DOV_KOD=D'#246'viz Kodu'
      'BEKLEME_FAT_VPB=Tutar Vpb'
      'SEFER_NOTLARI=Sefer Notlar'#305
      'SEFER_ALIS_FAT_ALINDI=Al'#305#351' Faturas'#305' Al'#305'nd'#305
      'SEFER_SATIS_FAT_KESILDI=Sat'#305#351' Faturas'#305' Kesildi'
      'SEFER_ID=Sefer No'
      'MASRAF_MERK=Masraf Merkezi'
      'KOD1=Kod1'
      'KOD2=Kod2'
      'KOD3=Kod3'
      'KOD4=Kod4'
      'MAZOT_FIS_ID=S'#305'ra No'
      'SAAT=Saat'
      'VEREN_PERSONEL_KOD=Veren Personel'
      'ALAN_PERSONEL_KOD=Alan Personel'
      'ALAN_CARI_KOD=Alan Cari Kodu'
      'MAZOTCU_CARI_KOD=Mazot'#231'u Cari Kod'
      'KM=Km'
      'LITRE=Litre'
      'LITRE_FIYAT=Litre Fiyat'#305
      'DOVKOD=D'#246'viz Kodu'
      'DOVKUR=D'#246'viz Kuru'
      'TUTAR=Tutar'
      'TUTAR_VPB=Tutar Vpb'
      'VEREN_PERSONEL_ADI=Veren Personel Ad'#305
      'ALAN_PERSONEL_ADI=Alan Personel Ad'#305
      'MAZOTCU_CARI_ADI=Mazot'#231'u Cari Ad'#305
      'ALAN_CARI_ADI=Alan Cari Ad'#305
      'ALIS_URUN_HAR_ID=Al'#305#351' Faturas'#305' Hareket No'
      'SECIM=Se'#231'im'
      'ALIS_FATURASI_ALINDI=Al'#305#351' Faturas'#305' Al'#305'nd'#305)
    FieldsIndex.Strings = (
      'SECIM'
      'MAZOT_FIS_ID'
      'MAZOT_FIS_SID'
      'ARAC_KOD'
      'ARAC_PLAKA'
      'SEFER_ID'
      'FIS_NO'
      'TARIH'
      'SAAT'
      'VEREN_PERSONEL_KOD'
      'VEREN_PERSONEL_ADI'
      'ALAN_PERSONEL_KOD'
      'ALAN_PERSONEL_ADI'
      'ALAN_CARI_KOD'
      'ALAN_CARI_ADI'
      'MAZOTCU_CARI_KOD'
      'MAZOTCU_CARI_ADI'
      'KM'
      'LITRE'
      'LITRE_FIYAT'
      'DOVKOD'
      'DOV_BAZ_TAR'
      'DOVKUR'
      'TUTAR'
      'TUTAR_VPB'
      'ACIKLAMA'
      'MASRAF_MERK'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4'
      'ALIS_FATURASI_ALINDI'
      'ALIS_URUN_HAR_ID')
    FieldsVisible.Strings = (
      'KASAHAR_ID=FALSE'
      'KASAHAR_SID=FALSE'
      'BELGE_TUR=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE'
      'MAZOT_FIS_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT MAZOT_FIS_ID'
      '     , MAZOT_FIS_SID'
      '     , ARAC_KOD'
      
        '     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=MAZOT_FISI.ARA' +
        'C_KOD) AS ARAC_PLAKA'
      '     , FIS_NO'
      '     , TARIH'
      '     , SAAT'
      '     , VEREN_PERSONEL_KOD'
      
        '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_K' +
        'OD=MAZOT_FISI.VEREN_PERSONEL_KOD) AS VEREN_PERSONEL_ADI    '
      '     , ALAN_PERSONEL_KOD'
      
        '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_K' +
        'OD=MAZOT_FISI.ALAN_PERSONEL_KOD) AS ALAN_PERSONEL_ADI    '
      '     , ALAN_CARI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE MAZOT_FISI.ALAN_CARI_KOD=C' +
        'ARI.CARI_KOD) AS ALAN_CARI_ADI    '
      '     , MAZOTCU_CARI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE MAZOT_FISI.MAZOTCU_CARI_KO' +
        'D=CARI.CARI_KOD) AS MAZOTCU_CARI_ADI    '
      '     , KM'
      '     , LITRE'
      '     , LITRE_FIYAT'
      '     , DOVKOD'
      '     , DOV_BAZ_TAR'
      '     , DOVKUR'
      '     , TUTAR'
      '     , TUTAR_VPB'
      '     , ACIKLAMA'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , SEFER_ID'
      '     , ALIS_URUN_HAR_ID'
      '     , SECIM'
      '     , ALIS_FATURASI_ALINDI'
      'FROM MAZOT_FISI'
      
        'WHERE MAZOT_FIS_ID=:PRM_MAZOT_FIS_ID AND MAZOT_FIS_SID=:PRM_MAZO' +
        'T_FIS_SID')
    AutoFetchAll = True
    ColorScheme = False
    DefaultValues.Strings = (
      'BELGE_SID=1'
      'BELGE_ID=0'
      'TIP=G'
      'KASADEGER=0'
      'ISLEM_TIP=1'
      'MC=C'
      'DOVKUR=0'
      'TUTAR=0'
      'TUTAR_VPB=0'
      'MIKTAR=0')
    KeyLinks.Strings = (
      'MAZOT_FISI.MAZOT_FIS_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 152
    Top = 120
    ParamValues = (
      'PRM_MAZOT_FIS_ID=0')
  end
  object frxIBODts_Mazot_Arac: TfrxIBODataset
    UserName = 'frxIBODts_Mazot_Arac'
    CloseDataSource = False
    FieldAliases.Strings = (
      'SECIM=SECIM'
      'MAZOT_FIS_ID=MAZOT_FIS_ID'
      'MAZOT_FIS_SID=MAZOT_FIS_SID'
      'ARAC_KOD=ARAC_KOD'
      'ARAC_PLAKA=ARAC_PLAKA'
      'SEFER_ID=SEFER_ID'
      'FIS_NO=FIS_NO'
      'TARIH=TARIH'
      'SAAT=SAAT'
      'VEREN_PERSONEL_KOD=VEREN_PERSONEL_KOD'
      'VEREN_PERSONEL_ADI=VEREN_PERSONEL_ADI'
      'ALAN_PERSONEL_KOD=ALAN_PERSONEL_KOD'
      'ALAN_PERSONEL_ADI=ALAN_PERSONEL_ADI'
      'ALAN_CARI_KOD=ALAN_CARI_KOD'
      'ALAN_CARI_ADI=ALAN_CARI_ADI'
      'MAZOTCU_CARI_KOD=MAZOTCU_CARI_KOD'
      'MAZOTCU_CARI_ADI=MAZOTCU_CARI_ADI'
      'KM=KM'
      'LITRE=LITRE'
      'LITRE_FIYAT=LITRE_FIYAT'
      'DOVKOD=DOVKOD'
      'DOV_BAZ_TAR=DOV_BAZ_TAR'
      'DOVKUR=DOVKUR'
      'TUTAR=TUTAR'
      'TUTAR_VPB=TUTAR_VPB'
      'ACIKLAMA=ACIKLAMA'
      'MASRAF_MERK=MASRAF_MERK'
      'KOD1=KOD1'
      'KOD2=KOD2'
      'KOD3=KOD3'
      'KOD4=KOD4'
      'ALIS_FATURASI_ALINDI=ALIS_FATURASI_ALINDI'
      'ALIS_URUN_HAR_ID=ALIS_URUN_HAR_ID')
    DataSet = qryMazot
    Left = 64
    Top = 57
  end
  object frxReport1: TfrxReport
    Version = '4.3'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39136.775302905100000000
    ReportOptions.LastChange = 39164.695829525470000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 56
    Top = 137
  end
end
