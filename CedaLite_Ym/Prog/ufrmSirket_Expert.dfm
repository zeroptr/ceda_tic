object frmSirket_Expert: TfrmSirket_Expert
  Left = 260
  Top = 158
  BorderStyle = bsSingle
  Caption = #350'irket D'#246'nem '#304#351'lemleri'
  ClientHeight = 404
  ClientWidth = 631
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 631
    Height = 369
    ActivePage = Tab_Yeni_Sirket
    Align = alTop
    HotTrack = True
    MultiLine = True
    RaggedRight = True
    ScrollOpposite = True
    Style = tsFlatButtons
    TabOrder = 0
    OnChange = PageControl1Change
    object Tab_Basla: TTabSheet
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Rg_Basla: TRadioGroup
        Left = 24
        Top = 96
        Width = 217
        Height = 105
        ItemIndex = 0
        Items.Strings = (
          'Yeni '#350'irket Olu'#351'tur'
          #350'irketler '#220'zerinde '#304#351'lem Yap')
        TabOrder = 0
      end
    end
    object Tab_Yeni_Sirket: TTabSheet
      ImageIndex = 1
      DesignSize = (
        623
        341)
      object IB_Edit3: TIB_Edit
        Left = 192
        Top = 56
        Width = 415
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'SIRKET_AD'
        DataSource = dts_Sirket
        TabOrder = 0
      end
      object IB_Edit4: TIB_Edit
        Left = 192
        Top = 80
        Width = 415
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'YETKILI'
        DataSource = dts_Sirket
        TabOrder = 1
      end
      object IB_Edit5: TIB_Edit
        Left = 192
        Top = 104
        Width = 415
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'ADRES_1'
        DataSource = dts_Sirket
        TabOrder = 2
      end
      object IB_Edit6: TIB_Edit
        Left = 192
        Top = 128
        Width = 415
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'ADRES_2'
        DataSource = dts_Sirket
        TabOrder = 3
      end
      object IB_Edit7: TIB_Edit
        Left = 192
        Top = 152
        Width = 132
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'ILCE'
        DataSource = dts_Sirket
        TabOrder = 4
      end
      object IB_Edit8: TIB_Edit
        Left = 360
        Top = 152
        Width = 132
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'SEHIR'
        DataSource = dts_Sirket
        TabOrder = 5
      end
      object edt_Pk: TIB_Edit
        Left = 562
        Top = 152
        Width = 45
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'PK'
        DataSource = dts_Sirket
        TabOrder = 6
      end
      object IB_Edit10: TIB_Edit
        Left = 16
        Top = 192
        Width = 89
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'TEL1'
        DataSource = dts_Sirket
        TabOrder = 7
      end
      object IB_Edit11: TIB_Edit
        Left = 112
        Top = 192
        Width = 97
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'TEL2'
        DataSource = dts_Sirket
        TabOrder = 8
      end
      object IB_Edit12: TIB_Edit
        Left = 216
        Top = 192
        Width = 113
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'FAX'
        DataSource = dts_Sirket
        TabOrder = 9
      end
      object IB_Edit13: TIB_Edit
        Left = 336
        Top = 192
        Width = 132
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'VERDAIRE'
        DataSource = dts_Sirket
        TabOrder = 10
      end
      object IB_Image1: TIB_Image
        Left = 16
        Top = 40
        Width = 98
        Height = 81
        AutoLabel.Kind = albTop
        AutoLabel.Margin = -15
        DataField = 'LOGO'
        DataSource = dts_Sirket
        BorderStyle = bsNone
        PreventSearching = True
        TabOrder = 11
        Stretch = True
      end
      object edt_Ver_No: TIB_Edit
        Left = 475
        Top = 192
        Width = 132
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'VERNO'
        DataSource = dts_Sirket
        TabOrder = 12
      end
      object Button1: TButton
        Left = 16
        Top = 128
        Width = 98
        Height = 25
        Caption = 'Resim Se'#231
        TabOrder = 13
        OnClick = Button1Click
      end
      object IB_Edit2: TIB_Edit
        Left = 192
        Top = 32
        Width = 121
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'SIRKET_ID'
        DataSource = dts_Sirket
        Enabled = False
        TabOrder = 14
      end
      object IB_Edit1: TIB_Edit
        Left = 16
        Top = 232
        Width = 115
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'TIC_SIC_NO'
        DataSource = dts_Sirket
        TabOrder = 15
      end
      object IB_Edit9: TIB_Edit
        Left = 136
        Top = 232
        Width = 115
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'TIC_ODA_NO'
        DataSource = dts_Sirket
        TabOrder = 16
      end
      object IB_Edit14: TIB_Edit
        Left = 256
        Top = 232
        Width = 115
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'SSK_SIC_NO'
        DataSource = dts_Sirket
        TabOrder = 17
      end
      object Button2: TButton
        Left = 16
        Top = 152
        Width = 98
        Height = 25
        Caption = 'Resmi Sil'
        TabOrder = 18
        OnClick = Button2Click
      end
      object IB_CheckBox1: TIB_CheckBox
        Left = 565
        Top = 232
        Width = 41
        Height = 17
        DataField = 'AKTIF'
        DataSource = dts_Sirket
        BorderStyle = bsNone
        TabOrder = 19
        Caption = 'Aktif'
      end
      object btnEKLE: TButton
        Left = 16
        Top = 274
        Width = 60
        Height = 23
        Caption = 'Ekle (INS)'
        TabOrder = 20
        OnClick = btnEKLEClick
      end
      object btnKaydet: TButton
        Left = 75
        Top = 274
        Width = 94
        Height = 23
        Caption = 'Kaydet (CTRL+S)'
        TabOrder = 21
        OnClick = btnKaydetClick
      end
      object btnIptal: TButton
        Left = 168
        Top = 274
        Width = 86
        Height = 23
        Caption = #304'ptal(CTRL+P)'
        TabOrder = 22
        OnClick = btnIptalClick
      end
      object btnSil: TButton
        Left = 514
        Top = 274
        Width = 95
        Height = 23
        Anchors = [akTop, akRight]
        Caption = 'Sil (CTRL + DEL)'
        TabOrder = 23
        OnClick = btnSilClick
      end
    end
    object Tab_Sirket_Sor: TTabSheet
      ImageIndex = 6
      object Rg_Sirket_Son_Devam: TRadioGroup
        Left = 24
        Top = 96
        Width = 169
        Height = 105
        ItemIndex = 0
        Items.Strings = (
          #304#351'lemi Bitir'
          #350'irket Se'#231'imi ile Devam Et')
        TabOrder = 0
      end
    end
    object Tab_Sirketler: TTabSheet
      ImageIndex = 5
      object grdSIRKET: TIB_Grid
        Left = 8
        Top = 16
        Width = 601
        Height = 137
        CustomGlyphsSupplied = []
        DataSource = dts_Sirket
        Ctl3D = True
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 0
        RowSelect = True
        Ctl3DShallow = True
      end
      object Rg_Sirket: TRadioGroup
        Left = 16
        Top = 176
        Width = 161
        Height = 105
        ItemIndex = 0
        Items.Strings = (
          #350'irket Bilgileri D'#252'zenle'
          #350'irket D'#246'nem '#304#351'lemleri')
        TabOrder = 1
      end
    end
    object Tab_Don_Yen_Deg: TTabSheet
      ImageIndex = 2
      object Rg_Donem: TRadioGroup
        Left = 24
        Top = 96
        Width = 193
        Height = 105
        ItemIndex = 0
        Items.Strings = (
          'Yeni D'#246'nem Olu'#351'tur'
          'D'#246'nem Bilgileri G'#246'rme De'#287'i'#351'iklik')
        TabOrder = 0
      end
    end
    object Tab_Yeni_Donem: TTabSheet
      ImageIndex = 3
      DesignSize = (
        623
        341)
      object IB_Edit15: TIB_Edit
        Left = 24
        Top = 48
        Width = 57
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'DONEM_NO'
        DataSource = dtsTERMS
        Enabled = False
        TabOrder = 0
      end
      object IB_Date1: TIB_Date
        Left = 92
        Top = 48
        Width = 96
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'DONEM_BAS'
        DataSource = dtsTERMS
        TabOrder = 1
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_Date2: TIB_Date
        Left = 192
        Top = 48
        Width = 96
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'DONEM_SON'
        DataSource = dtsTERMS
        TabOrder = 2
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_Edit16: TIB_Edit
        Left = 24
        Top = 88
        Width = 157
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'SERVER_NAME'
        DataSource = dtsTERMS
        TabOrder = 3
      end
      object IB_CheckBox2: TIB_CheckBox
        Left = 296
        Top = 48
        Width = 93
        Height = 17
        DataField = 'CONN_LOCAL'
        DataSource = dtsTERMS
        BorderStyle = bsNone
        TabOrder = 4
        Caption = 'Yerel Ba'#287'lant'#305
      end
      object txtPath: TIB_Edit
        Left = 189
        Top = 88
        Width = 269
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'DB_PATH'
        DataSource = dtsTERMS
        TabOrder = 5
        ButtonStyle = ebsEllipsis
      end
      object IB_Edit17: TIB_Edit
        Left = 24
        Top = 124
        Width = 157
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'USER_NAME'
        DataSource = dtsTERMS
        TabOrder = 6
      end
      object IB_Edit18: TIB_Edit
        Left = 191
        Top = 123
        Width = 157
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'PASS_WORD'
        DataSource = dtsTERMS
        TabOrder = 7
        PasswordChar = '#'
      end
      object IB_CheckBox3: TIB_CheckBox
        Left = 353
        Top = 124
        Width = 49
        Height = 17
        DataField = 'AKTIF'
        DataSource = dtsTERMS
        BorderStyle = bsNone
        TabOrder = 8
        Caption = 'Aktif'
      end
      object mnuTEST: TButton
        Left = 400
        Top = 120
        Width = 73
        Height = 25
        Caption = 'TEST !'
        TabOrder = 9
        OnClick = mnuTESTClick
      end
      object btnSirketYarat: TButton
        Left = 22
        Top = 156
        Width = 221
        Height = 25
        Caption = 'Yeni D'#246'nem Yarat'
        TabOrder = 10
        OnClick = btnSirketYaratClick
      end
      object btnDonemDevir: TButton
        Left = 250
        Top = 156
        Width = 227
        Height = 25
        Caption = #214'nceki D'#246'nemden Devir'
        TabOrder = 11
        OnClick = btnDonemDevirClick
      end
      object BtnEkle1: TButton
        Left = 8
        Top = 274
        Width = 60
        Height = 23
        Caption = 'Ekle (INS)'
        TabOrder = 12
        OnClick = BtnEkle1Click
      end
      object BtnKaydet1: TButton
        Left = 67
        Top = 274
        Width = 94
        Height = 23
        Caption = 'Kaydet (CTRL+S)'
        TabOrder = 13
        OnClick = BtnKaydet1Click
      end
      object BtnIptal1: TButton
        Left = 160
        Top = 274
        Width = 86
        Height = 23
        Caption = #304'ptal(CTRL+P)'
        TabOrder = 14
        OnClick = BtnIptal1Click
      end
      object BtnSil1: TButton
        Left = 506
        Top = 274
        Width = 95
        Height = 23
        Anchors = [akTop, akRight]
        Caption = 'Sil (CTRL + DEL)'
        TabOrder = 15
        OnClick = BtnSil1Click
      end
    end
    object Tab_Donem_Sec: TTabSheet
      ImageIndex = 4
      object grdTERMS: TIB_Grid
        Left = 16
        Top = 16
        Width = 609
        Height = 153
        CustomGlyphsSupplied = []
        DataSource = dtsTERMS
        Ctl3D = True
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 0
        RowSelect = True
        Ctl3DShallow = True
      end
      object Rg_Donem_Sec: TRadioGroup
        Left = 16
        Top = 176
        Width = 161
        Height = 105
        ItemIndex = 0
        Items.Strings = (
          #304#351'lemi Bitir - '#199#305'k'#305#351
          'D'#246'nem Bilgileri D'#252'zenle')
        TabOrder = 1
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 371
    Width = 631
    Height = 33
    Align = alBottom
    BorderStyle = bsSingle
    TabOrder = 1
    object Btn_geri: TBitBtn
      Left = 391
      Top = 2
      Width = 113
      Height = 25
      Caption = 'Geri'
      TabOrder = 0
      OnClick = Btn_geriClick
    end
    object Btn_ileri: TBitBtn
      Left = 511
      Top = 2
      Width = 113
      Height = 25
      Caption = #304'leri'
      TabOrder = 1
      OnClick = Btn_ileriClick
    end
  end
  object qry_Sirket: TIB_Query
    ColumnAttributes.Strings = (
      'AKTIF=BOOLEAN=1,0')
    FieldsDisplayFormat.Strings = (
      'TEL1=#(###)#######'
      'TEL2=#(###)#######'
      'FAX=#(###)#######'
      'VERNO=### ### ####'
      'PK=#####'
      'TOPLAM_SUBE_ADET=###'
      'SIRKET_KOD=#####')
    FieldsDisplayLabel.Strings = (
      'ADI='#350'irket Ad'#305' :'
      'YETKILI='#350'irket Yetkilisi :'
      'ADRES_1=Adres (1) :'
      'ADRES_2=Adres (2) :'
      'ILCE='#304'l'#231'e :'
      'SEHIR='#350'ehir :'
      'PK=Posta Kodu :'
      'TEL1=Telefon (1) :'
      'TEL2=Telefon (2) :'
      'FAX=Fax :'
      'VERDAIRE=Vergi Dairesi :'
      'VERNO=Vergi Numaras'#305' :'
      'LOGO='#350'irket Logosu :'
      'TOPLAM_SUBE_ADET=Toplam '#350'ube Adedi :'
      'SIRKET_KOD='#350'irket Kodu :'
      'TIC_SIC_NO=Ticaret Sicil No'
      'TIC_ODA_NO=Ticaret Oda No'
      'SSK_SIC_NO=SSK Sicil No'
      'SIRKET_AD='#350'irket Ad'#305
      'SIRKET_ID='#350'irket No')
    FieldsEditMask.Strings = (
      'TEL1=#(###)#######'
      'TEL2=#(###)#######'
      'FAX=#(###)#######'
      'VERNO=### ### ####'
      'PK=#####'
      'TOPLAM_SUBE_ADET=###'
      'SIRKET_KOD=#####')
    FieldsVisible.Strings = (
      'SIRKET_ID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT SIRKET_ID'
      '     , SIRKET_AD'
      '     , YETKILI'
      '     , ADRES_1'
      '     , ADRES_2'
      '     , ILCE'
      '     , SEHIR'
      '     , PK'
      '     , TEL1'
      '     , TEL2'
      '     , FAX'
      '     , VERDAIRE'
      '     , VERNO'
      '     , LOGO'
      '     , TOPLAM_SUBE_ADET'
      '     , TIC_SIC_NO'
      '     , TIC_ODA_NO'
      '     , SSK_SIC_NO'
      '     , AKTIF'
      'FROM SIRKET'
      '')
    ColorScheme = False
    DefaultValues.Strings = (
      'AKTIF=1')
    KeyLinks.Strings = (
      'SIRKET.SIRKET_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qry_SirketAfterInsert
    BeforeDelete = qry_SirketBeforeDelete
    BeforePost = qry_SirketBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 420
    Top = 53
    ParamValues = (
      'PRM_SIRKET_ID=1')
  end
  object dts_Sirket: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = qry_Sirket
    OnStateChanged = dts_SirketStateChanged
    Left = 348
    Top = 49
  end
  object OpenPictureDialog1: TOpenPictureDialog
    DefaultExt = '*.bmp'
    Left = 52
    Top = 81
  end
  object qryTERMS: TIB_Query
    ColumnAttributes.Strings = (
      'CONN_LOCAL=BOOLEAN=1,0'
      'AKTIF=BOOLEAN=1,0')
    FieldsDisplayLabel.Strings = (
      'DONEM_NO=D'#246'nem No'
      'DONEM_BAS=D'#246'nem Ba'#351#305
      'DONEM_SON=D'#246'nem Sonu'
      'DB_PATH=Veri Taban'#305' Yolu'
      'SERVER_NAME=Sunucu Ad'#305' / IP'
      'CONN_LOCAL=Yerel Ba'#287'lant'#305
      'USER_NAME=DB Kullan'#305'c'#305' Ad'#305
      'PASS_WORD=DB Parola')
    FieldsDisplayWidth.Strings = (
      'DONEM_BAS=83'
      'DONEM_SON=100')
    FieldsVisible.Strings = (
      'SIRKET_ID=FALSE'
      'DB_PATH=TRUE'
      'SERVER_NAME=TRUE'
      'CONN_LOCAL=TRUE'
      'PASS_WORD=FALSE'
      'USER_NAME=FALSE'
      'AKTIF=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT SIRKET_ID'
      '     , DONEM_NO'
      '     , DONEM_BAS'
      '     , DONEM_SON'
      '     , DB_PATH'
      '     , SERVER_NAME'
      '     , CONN_LOCAL'
      '     , USER_NAME'
      '     , PASS_WORD'
      '     , AKTIF'
      'FROM TERMS')
    ColorScheme = False
    KeyLinks.Strings = (
      'TERMS.SIRKET_ID'
      'TERMS.DONEM_NO')
    MasterSource = dts_Sirket
    MasterLinks.Strings = (
      'TERMS.SIRKET_ID=SIRKET.SIRKET_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 422
    Top = 122
  end
  object dtsTERMS: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = qryTERMS
    OnStateChanged = dtsTERMSStateChanged
    Left = 348
    Top = 104
  end
end
