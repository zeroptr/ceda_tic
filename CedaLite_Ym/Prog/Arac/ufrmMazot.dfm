object frmMazot: TfrmMazot
  Left = 277
  Top = 89
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Mazot Fi'#351'i'
  ClientHeight = 397
  ClientWidth = 535
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object IB_Text5: TIB_Text
    Left = 144
    Top = 139
    Width = 275
    Height = 14
    DataField = 'VEREN_PERSONEL_ADI'
    DataSource = dtsMazot
    Color = clMoneyGreen
    ParentColor = False
  end
  object IB_Text1: TIB_Text
    Left = 232
    Top = 19
    Width = 299
    Height = 14
    DataField = 'ARAC_PLAKA'
    DataSource = dtsMazot
    Color = clMoneyGreen
    ParentColor = False
  end
  object IB_Text2: TIB_Text
    Left = 144
    Top = 219
    Width = 275
    Height = 14
    DataField = 'ALAN_CARI_ADI'
    DataSource = dtsMazot
    Color = clMoneyGreen
    ParentColor = False
  end
  object IB_Text4: TIB_Text
    Left = 144
    Top = 99
    Width = 275
    Height = 14
    DataField = 'MAZOTCU_CARI_ADI'
    DataSource = dtsMazot
    Color = clMoneyGreen
    ParentColor = False
  end
  object IB_Text3: TIB_Text
    Left = 144
    Top = 179
    Width = 275
    Height = 14
    DataField = 'ALAN_PERSONEL_ADI'
    DataSource = dtsMazot
    Color = clMoneyGreen
    ParentColor = False
  end
  object IB_Text6: TIB_Text
    Left = 368
    Top = 275
    Width = 57
    Height = 14
    DataField = 'ALIS_URUN_HAR_ID'
    DataSource = dtsMazot
    Color = clMoneyGreen
    ParentColor = False
    OnDblClick = IB_Text6DblClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 367
    Width = 535
    Height = 30
    Align = alBottom
    TabOrder = 20
    object btnYeni: TBitBtn
      Left = 5
      Top = 3
      Width = 62
      Height = 25
      Caption = 'Yeni (INS)'
      TabOrder = 0
      OnClick = btnYeniClick
      NumGlyphs = 2
    end
    object btnAra: TBitBtn
      Left = 404
      Top = 3
      Width = 62
      Height = 25
      Caption = '&Ara'
      TabOrder = 4
      OnClick = btnAraClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
        3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
        33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
        333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
    end
    object btnCikis: TBitBtn
      Left = 469
      Top = 3
      Width = 61
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 5
      OnClick = btnCikisClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F3333333F7F333301111111B10333337F333333737F33330111111111
        0333337F333333337F333301111111110333337F33FFFFF37F3333011EEEEE11
        0333337F377777F37F3333011EEEEE110333337F37FFF7F37F3333011EEEEE11
        0333337F377777337F333301111111110333337F333333337F33330111111111
        0333337FFFFFFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
    end
    object btnKaydet: TButton
      Left = 69
      Top = 3
      Width = 91
      Height = 25
      Caption = 'Kaydet (CTRL+S)'
      TabOrder = 1
      OnClick = btnKaydetClick
    end
    object btnIPTAL: TButton
      Left = 163
      Top = 3
      Width = 80
      Height = 25
      Caption = #304'ptal(CTRL+P)'
      TabOrder = 2
      OnClick = btnIPTALClick
    end
    object btnSil: TButton
      Left = 244
      Top = 3
      Width = 84
      Height = 25
      Caption = 'Sil (CTRL+DEL)'
      TabOrder = 3
      OnClick = btnSilClick
    end
    object Btn_Onceki: TButton
      Left = 344
      Top = 3
      Width = 25
      Height = 25
      Caption = '<'
      TabOrder = 6
      OnClick = Btn_OncekiClick
    end
    object Btn_Sonraki: TButton
      Left = 371
      Top = 3
      Width = 25
      Height = 25
      Caption = '>'
      TabOrder = 7
      OnClick = Btn_SonrakiClick
    end
  end
  object IB_Edit1: TIB_Edit
    Left = 8
    Top = 16
    Width = 65
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'MAZOT_FIS_ID'
    DataSource = dtsMazot
    Enabled = False
    ReadOnly = True
    TabOrder = 0
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Date1: TIB_Date
    Left = 424
    Top = 56
    Width = 94
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'TARIH'
    DataSource = dtsMazot
    TabOrder = 8
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    IncCellHeight = 1
    IncCellWidth = 2
    DrawYearArrow = False
  end
  object txtPERSONEL_KOD: TIB_Edit
    Left = 8
    Top = 136
    Width = 134
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'VEREN_PERSONEL_KOD'
    DataSource = dtsMazot
    TabOrder = 5
    OnEnter = txtPERSONEL_KODEnter
    OnExit = txtPERSONEL_KODExit
    OnKeyDown = txtPERSONEL_KODKeyDown
    OnKeyPress = txtPERSONEL_KODKeyPress
    ButtonStyle = ebsEllipsis
    OnButtonClick = txtPERSONEL_KODButtonClick
  end
  object IB_Edit5: TIB_Edit
    Left = 8
    Top = 336
    Width = 521
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'ACIKLAMA'
    DataSource = dtsMazot
    TabOrder = 18
    OnEnter = IB_Edit5Enter
    OnExit = IB_Edit1Exit
  end
  object grpRapKod: TGroupBox
    Left = 496
    Top = 264
    Width = 521
    Height = 61
    Enabled = False
    TabOrder = 19
    Visible = False
    object IB_Edit8: TIB_Edit
      Left = 10
      Top = 26
      Width = 83
      Height = 21
      AutoLabel.Kind = albTop
      AutoLabel.Caption = #304#351'lem Merkezi'
      DataField = 'MASRAF_MERK'
      DataSource = dtsMazot
      TabOrder = 0
      OnEnter = IB_Edit8Enter
      OnExit = IB_Edit8Exit
      OnKeyPress = txtSaticiKodKeyPress
      OnKeyUp = IB_Edit8KeyUp
      ButtonStyle = ebsEllipsis
      OnButtonClick = IB_Edit8ButtonClick
    end
    object IB_Edit10: TIB_Edit
      Left = 112
      Top = 26
      Width = 85
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'KOD1'
      DataSource = dtsMazot
      TabOrder = 1
      OnEnter = IB_Edit10Enter
      OnExit = IB_Edit10Exit
      OnKeyPress = txtSaticiKodKeyPress
      OnKeyUp = IB_Edit10KeyUp
      ButtonStyle = ebsEllipsis
      OnButtonClick = IB_Edit10ButtonClick
    end
    object IB_Edit11: TIB_Edit
      Left = 218
      Top = 26
      Width = 81
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'KOD2'
      DataSource = dtsMazot
      TabOrder = 2
      OnEnter = IB_Edit11Enter
      OnExit = IB_Edit11Exit
      OnKeyPress = txtSaticiKodKeyPress
      OnKeyUp = IB_Edit11KeyUp
      ButtonStyle = ebsEllipsis
      OnButtonClick = IB_Edit11ButtonClick
    end
    object IB_Edit12: TIB_Edit
      Left = 319
      Top = 26
      Width = 85
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'KOD3'
      DataSource = dtsMazot
      TabOrder = 3
      OnEnter = IB_Edit12Enter
      OnExit = IB_Edit12Exit
      OnKeyPress = txtSaticiKodKeyPress
      OnKeyUp = IB_Edit12KeyUp
      ButtonStyle = ebsEllipsis
      OnButtonClick = IB_Edit12ButtonClick
    end
    object IB_Edit13: TIB_Edit
      Left = 422
      Top = 26
      Width = 85
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'KOD4'
      DataSource = dtsMazot
      TabOrder = 4
      OnEnter = IB_Edit13Enter
      OnExit = IB_Edit13Exit
      OnKeyPress = txtSaticiKodKeyPress
      OnKeyUp = IB_Edit13KeyUp
      ButtonStyle = ebsEllipsis
      OnButtonClick = IB_Edit13ButtonClick
    end
  end
  object IB_Currency7: TIB_Currency
    Left = 128
    Top = 256
    Width = 87
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'TUTAR'
    DataSource = dtsMazot
    TabOrder = 12
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    AlwaysShowButton = True
  end
  object IB_Currency8: TIB_Currency
    Left = 8
    Top = 296
    Width = 87
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'TUTAR_VPB'
    DataSource = dtsMazot
    Visible = False
    ReadOnly = True
    TabOrder = 14
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    AlwaysShowButton = True
  end
  object txtArac_Kod: TIB_Edit
    Left = 80
    Top = 16
    Width = 153
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'ARAC_KOD'
    DataSource = dtsMazot
    TabOrder = 1
    OnEnter = txtArac_KodEnter
    OnExit = txtArac_KodExit
    OnKeyDown = txtArac_KodKeyDown
    OnKeyPress = txtArac_KodKeyPress
    ButtonStyle = ebsEllipsis
    OnButtonClick = txtArac_KodButtonClick
  end
  object cboDOVKOD: TIB_ComboBox
    Left = 128
    Top = 296
    Width = 89
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'DOVKOD'
    DataSource = dtsMazot
    Visible = False
    TabOrder = 15
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    Style = csDropDownList
    ItemHeight = 13
  end
  object IB_Date2: TIB_Date
    Left = 248
    Top = 296
    Width = 89
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'DOV_BAZ_TAR'
    DataSource = dtsMazot
    Visible = False
    TabOrder = 16
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    IncCellHeight = 1
    IncCellWidth = 2
    DrawYearArrow = False
  end
  object txtAliciKod: TIB_Edit
    Left = 8
    Top = 216
    Width = 134
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'ALAN_CARI_KOD'
    DataSource = dtsMazot
    TabOrder = 7
    OnEnter = txtAliciKodEnter
    OnExit = txtAliciKodExit
    OnKeyDown = txtAliciKodKeyDown
    OnKeyPress = txtAliciKodKeyPress
    ButtonStyle = ebsEllipsis
    OnButtonClick = txtAliciKodButtonClick
  end
  object txtSaticiKod: TIB_Edit
    Left = 8
    Top = 96
    Width = 134
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'MAZOTCU_CARI_KOD'
    DataSource = dtsMazot
    TabOrder = 4
    OnEnter = txtSaticiKodEnter
    OnExit = txtSaticiKodExit
    OnKeyDown = txtSaticiKodKeyDown
    OnKeyPress = txtSaticiKodKeyPress
    ButtonStyle = ebsEllipsis
    OnButtonClick = txtSaticiKodButtonClick
  end
  object txtAlanPersonel: TIB_Edit
    Left = 8
    Top = 176
    Width = 134
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'ALAN_PERSONEL_KOD'
    DataSource = dtsMazot
    TabOrder = 6
    OnEnter = txtAlanPersonelEnter
    OnExit = txtAlanPersonelExit
    OnKeyDown = txtAlanPersonelKeyDown
    OnKeyPress = txtAlanPersonelKeyPress
    ButtonStyle = ebsEllipsis
    OnButtonClick = txtAlanPersonelButtonClick
  end
  object IB_Date4: TIB_Date
    Left = 424
    Top = 104
    Width = 94
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'SAAT'
    DataSource = dtsMazot
    TabOrder = 9
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    IncCellHeight = 1
    IncCellWidth = 2
    DrawYearArrow = False
  end
  object IB_Currency1: TIB_Currency
    Left = 424
    Top = 152
    Width = 94
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'KM'
    DataSource = dtsMazot
    TabOrder = 10
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    AlwaysShowButton = True
  end
  object IB_Currency2: TIB_Currency
    Left = 8
    Top = 256
    Width = 87
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'LITRE_FIYAT'
    DataSource = dtsMazot
    TabOrder = 11
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    AlwaysShowButton = True
  end
  object IB_Currency3: TIB_Currency
    Left = 248
    Top = 256
    Width = 87
    Height = 21
    TabStop = False
    AutoLabel.Kind = albTop
    DataField = 'LITRE'
    DataSource = dtsMazot
    ReadOnly = True
    TabOrder = 13
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    AlwaysShowButton = True
  end
  object IB_Edit2: TIB_Edit
    Left = 80
    Top = 56
    Width = 150
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'FIS_NO'
    DataSource = dtsMazot
    TabOrder = 3
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit3: TIB_Edit
    Left = 8
    Top = 56
    Width = 65
    Height = 21
    TabStop = False
    AutoLabel.Kind = albTop
    DataField = 'SEFER_ID'
    DataSource = dtsMazot
    Enabled = False
    ReadOnly = True
    TabOrder = 2
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_CheckBox1: TIB_CheckBox
    Left = 368
    Top = 256
    Width = 124
    Height = 13
    TabStop = False
    DataField = 'ALIS_FATURASI_ALINDI'
    DataSource = dtsMazot
    BorderStyle = bsNone
    ReadOnly = True
    TabOrder = 17
    Caption = 'Al'#305#351' Faturas'#305' Al'#305'nd'#305
  end
  object Button1: TButton
    Left = 336
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 21
    Visible = False
    OnClick = Button1Click
  end
  object qryMazot: TIB_Query
    ColumnAttributes.Strings = (
      'ALIS_FATURASI_ALINDI=BOOLEAN=1,0')
    DatabaseName = 'C:\ekinci_deg\EKINCI2013.FDB'
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
      'ALAN_CARI_ADI=Alan Cari Ad'#305
      'MAZOTCU_CARI_ADI=Mazot'#231'u Cari Ad'#305
      'ALIS_URUN_HAR_ID=Al'#305#351' Faturas'#305' Hareket No'
      'ALIS_FATURASI_ALINDI=Al'#305#351' Faturas'#305' Al'#305'nd'#305)
    FieldsVisible.Strings = (
      'KASAHAR_ID=FALSE'
      'KASAHAR_SID=FALSE'
      'BELGE_TUR=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE'
      'MAZOT_FIS_SID=FALSE'
      'SECIM=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnMazot
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
      '     , ALIS_FATURASI_ALINDI'
      '     , SECIM'
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
    AfterInsert = qryMazotAfterInsert
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 296
    Top = 48
    ParamValues = (
      'PRM_MAZOT_FIS_ID=0')
  end
  object dtsMazot: TIB_DataSource
    AutoInsert = False
    Dataset = qryMazot
    OnDataChange = dtsMazotDataChange
    OnStateChanged = dtsMazotStateChanged
    Left = 376
    Top = 112
  end
  object trnMazot: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 440
    Top = 144
  end
end
