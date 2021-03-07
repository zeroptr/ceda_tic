object frm_Kullanici_Tanimlama: Tfrm_Kullanici_Tanimlama
  Left = 191
  Top = 107
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Kullan'#305'c'#305' Tan'#305'mlama ve D'#252'zenleme '#304#351'lemleri'
  ClientHeight = 393
  ClientWidth = 719
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 362
    Width = 719
    Height = 31
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 369
    object btnCikis: TBitBtn
      Left = 642
      Top = 4
      Width = 59
      Height = 25
      Caption = #199#305'k'#305#351
      TabOrder = 0
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
    object btnYeni: TBitBtn
      Left = 5
      Top = 3
      Width = 62
      Height = 25
      Caption = 'Yeni (INS)'
      TabOrder = 1
      OnClick = btnYeniClick
      NumGlyphs = 2
    end
    object btnKaydet: TButton
      Left = 69
      Top = 3
      Width = 91
      Height = 25
      Caption = 'Kaydet (CTRL+S)'
      TabOrder = 2
      OnClick = btnKaydetClick
    end
    object btnIPTAL: TButton
      Left = 163
      Top = 3
      Width = 80
      Height = 25
      Caption = #304'ptal(CTRL+P)'
      TabOrder = 3
      OnClick = btnIPTALClick
    end
    object btnSil: TButton
      Left = 244
      Top = 3
      Width = 87
      Height = 25
      Caption = 'Sil (CTRL+DEL)'
      TabOrder = 4
      OnClick = btnSilClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 719
    Height = 362
    ActivePage = TabSheet1
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 1
    OnChanging = PageControl1Changing
    ExplicitHeight = 369
    object TabSheet1: TTabSheet
      Caption = 'Kullan'#305'c'#305' '#350'ube '#350'irket Tan'#305'mlamalar'#305
      ExplicitHeight = 338
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 711
        Height = 218
        Align = alTop
        Caption = 'Kullan'#305'c'#305' - '#350'ube Tan'#305'mlamalar'#305
        TabOrder = 0
        object Label1: TLabel
          Left = 14
          Top = 104
          Width = 55
          Height = 13
          Caption = 'Tekrar '#350'ifre'
        end
        object IB_Edit1: TIB_Edit
          Left = 78
          Top = 16
          Width = 201
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'AD_SOY'
          DataSource = dts_Kullanici
          TabOrder = 0
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit2KeyPress
        end
        object IB_Edit2: TIB_Edit
          Left = 78
          Top = 43
          Width = 121
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'USER_NAME'
          DataSource = dts_Kullanici
          TabOrder = 1
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit2KeyPress
        end
        object txtSifre: TIB_Edit
          Left = 78
          Top = 69
          Width = 121
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'PASS_WORD'
          DataSource = dts_Kullanici
          TabOrder = 2
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit2KeyPress
          PasswordChar = '#'
        end
        object txtTekrarSifre: TEdit
          Left = 78
          Top = 95
          Width = 121
          Height = 21
          PasswordChar = '#'
          TabOrder = 3
          OnEnter = txtTekrarSifreEnter
          OnExit = txtTekrarSifreExit
          OnKeyPress = IB_Edit2KeyPress
        end
        object IB_CheckBox1: TIB_CheckBox
          Left = 18
          Top = 153
          Width = 97
          Height = 17
          DisplayLabelAsCaption = True
          DataField = 'YONETICI'
          DataSource = dts_Kullanici
          BorderStyle = bsNone
          TabOrder = 4
          Alignment = taLeftJustify
          Caption = 'Y'#246'netici'
        end
        object cboSUBE: TIB_LookupCombo
          Left = 77
          Top = 122
          Width = 121
          Height = 21
          DataSource = dtsSUBE
          TabOrder = 5
          DisplayField = 'ADI'
          ShowButton = True
        end
        object grdKULLANICI: TIB_Grid
          Left = 306
          Top = 15
          Width = 391
          Height = 178
          CustomGlyphsSupplied = []
          DataSource = dts_Kullanici
          BorderStyle = bsNone
          PreventDeleting = True
          PreventEditing = True
          PreventInserting = True
          PreventSearching = True
          ReadOnly = True
          TabOrder = 6
          RowSelect = True
          Ctl3DShallow = True
        end
        object IB_CheckBox4: TIB_CheckBox
          Left = 16
          Top = 181
          Width = 252
          Height = 17
          DataField = 'SUBE_MUDAHALE'
          DataSource = dts_Kullanici
          BorderStyle = bsNone
          TabOrder = 7
          Alignment = taLeftJustify
          Caption = 'Tan'#305'mlanm'#305#351' b'#252't'#252'n '#351'ubeleri kullan'#305'c'#305' g'#246'rebilir mi'
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Kullan'#305'c'#305' '#350'irket - D'#246'nem Tan'#305'mlamalar'#305
      ImageIndex = 2
      ExplicitHeight = 338
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 711
        Height = 176
        Align = alTop
        Caption = 'Kullan'#305'c'#305' - '#350'irket Tan'#305'mlamalar'#305
        TabOrder = 0
        object GroupBox3: TGroupBox
          Left = 6
          Top = 18
          Width = 331
          Height = 129
          Caption = 'Tan'#305'ml'#305' '#350'irketler'
          TabOrder = 0
          object grdSirket: TIB_Grid
            Left = 6
            Top = 18
            Width = 313
            Height = 105
            CustomGlyphsSupplied = []
            DataSource = dtsSIRKET
            PreventDeleting = True
            PreventEditing = True
            PreventInserting = True
            PreventSearching = True
            ReadOnly = True
            TabOrder = 0
            RowSelect = True
          end
        end
        object GroupBox4: TGroupBox
          Left = 366
          Top = 18
          Width = 331
          Height = 127
          Caption = 'Giri'#351' Hakk'#305' Bulunan '#350'irketler'
          TabOrder = 1
          object grdHakSirket: TIB_Grid
            Left = 8
            Top = 18
            Width = 313
            Height = 104
            CustomGlyphsSupplied = []
            DataSource = dtsSIRKETHAK
            TabOrder = 0
            RowSelect = True
          end
        end
        object btnSirketEkle: TButton
          Left = 340
          Top = 54
          Width = 23
          Height = 23
          Caption = '>>'
          TabOrder = 2
          OnClick = btnSirketEkleClick
        end
        object btnSirketSil: TButton
          Left = 340
          Top = 102
          Width = 23
          Height = 23
          Caption = '<<'
          TabOrder = 3
          OnClick = btnSirketSilClick
        end
        object btnSrktInsAll: TButton
          Left = 6
          Top = 150
          Width = 331
          Height = 20
          Caption = 'Hepsini Ekle'
          TabOrder = 4
          OnClick = btnSrktInsAllClick
        end
        object btnSrktDelAll: TButton
          Left = 366
          Top = 150
          Width = 331
          Height = 20
          Caption = 'Hepsini Sil'
          TabOrder = 5
          OnClick = btnSrktDelAllClick
        end
      end
      object GroupBox6: TGroupBox
        Left = 0
        Top = 176
        Width = 711
        Height = 158
        Align = alTop
        Caption = 'Kullan'#305'c'#305' - D'#246'nem Tan'#305'mlamalar'#305
        TabOrder = 1
        object GroupBox7: TGroupBox
          Left = 6
          Top = 18
          Width = 331
          Height = 111
          Caption = 'Tan'#305'ml'#305' D'#246'nemler'
          TabOrder = 0
          object grdDonem: TIB_Grid
            Left = 8
            Top = 15
            Width = 313
            Height = 91
            CustomGlyphsSupplied = []
            DataSource = dtsSIRKETDONEM
            TabOrder = 0
            RowSelect = True
          end
        end
        object GroupBox8: TGroupBox
          Left = 369
          Top = 18
          Width = 326
          Height = 110
          Caption = 'Giri'#351' Hakk'#305' Bulunan D'#246'nemler'
          TabOrder = 1
          object grdHakDonem: TIB_Grid
            Left = 8
            Top = 15
            Width = 310
            Height = 91
            CustomGlyphsSupplied = []
            DataSource = dtsDONEMHAK
            TabOrder = 0
            RowSelect = True
          end
        end
        object btnDonemEkle: TButton
          Left = 341
          Top = 47
          Width = 24
          Height = 21
          Caption = '>>'
          TabOrder = 2
          OnClick = btnDonemEkleClick
        end
        object btnDonemSil: TButton
          Left = 341
          Top = 96
          Width = 24
          Height = 21
          Caption = '<<'
          TabOrder = 3
          OnClick = btnDonemSilClick
        end
        object btnDnmInsAll: TButton
          Left = 6
          Top = 131
          Width = 331
          Height = 21
          Caption = 'Hepsini Ekle'
          TabOrder = 4
          OnClick = btnDnmInsAllClick
        end
        object btnDnmDelAll: TButton
          Left = 370
          Top = 131
          Width = 325
          Height = 21
          Caption = 'Hepsini Sil'
          TabOrder = 5
          OnClick = btnDnmDelAllClick
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Kullan'#305'c'#305' Kasa Tan'#305'mlamalar'#305
      ImageIndex = 3
      ExplicitHeight = 338
      object grpKasaKisit: TGroupBox
        Left = 0
        Top = 0
        Width = 711
        Height = 328
        Align = alTop
        Caption = 'Kullan'#305'c'#305' Kasa Tan'#305'mlamalar'#305
        TabOrder = 0
        object GroupBox11: TGroupBox
          Left = 12
          Top = 18
          Width = 313
          Height = 248
          Caption = 'Ba'#287'l'#305' bulunulan d'#246'nem '#252'zerinde kullan'#305'm hakk'#305' olmayan kasalar'
          TabOrder = 0
          object grdSrkKasa: TIB_Grid
            Left = 9
            Top = 18
            Width = 295
            Height = 223
            CustomGlyphsSupplied = []
            DataSource = dtsSrkKasa
            TabOrder = 0
            RowSelect = True
          end
        end
        object GroupBox12: TGroupBox
          Left = 372
          Top = 18
          Width = 313
          Height = 247
          Caption = 'Ba'#287'l'#305' bulunulan d'#246'nem '#252'zerinde kullan'#305'm hakk'#305' olan kasalar'
          TabOrder = 1
          object grdKulKasa: TIB_Grid
            Left = 9
            Top = 18
            Width = 295
            Height = 222
            CustomGlyphsSupplied = []
            DataSource = dtsKulKasa
            TabOrder = 0
            RowSelect = True
          end
        end
        object btnKasaEkle: TButton
          Left = 335
          Top = 123
          Width = 24
          Height = 21
          Caption = '>>'
          TabOrder = 2
          OnClick = btnKasaEkleClick
        end
        object btnKasaSil: TButton
          Left = 335
          Top = 167
          Width = 24
          Height = 20
          Caption = '<<'
          TabOrder = 3
          OnClick = btnKasaSilClick
        end
        object Button3: TButton
          Left = 12
          Top = 274
          Width = 313
          Height = 21
          Caption = 'Hepsini Ekle'
          TabOrder = 4
          OnClick = Button3Click
        end
        object Button4: TButton
          Left = 372
          Top = 273
          Width = 313
          Height = 21
          Caption = 'Hepsini Sil'
          TabOrder = 5
          OnClick = Button4Click
        end
        object btnVarsayilan: TButton
          Left = 372
          Top = 293
          Width = 313
          Height = 22
          Caption = 'Yukar'#305'da se'#231'ili kasay'#305' varsay'#305'lan olarak ata'
          TabOrder = 6
          OnClick = btnVarsayilanClick
        end
      end
    end
  end
  object qry_Kullanici: TIB_Query
    ColumnAttributes.Strings = (
      'YONETICI=BOOLEAN=1,0;REQUIRED'
      'RAPKOD_UYG=BOOLEAN=1,0;REQUIRED'
      'SUBE_MUDAHALE=BOOLEAN=1,0'
      'KAY_TAR_UYG=BOOLEAN=1,0'
      'RAPKOD_GOR=BOOLEAN=1,0')
    FieldsDisplayLabel.Strings = (
      'AD_SOY=Ad'#305' Soyad'#305' :'
      'USER_NAME=Kullan'#305'c'#305' Ad'#305' :'
      'PASS_WORD='#350'ifre :'
      'YONETICI=Y'#246'netici'
      'RAPKOD=Rapor Kodu     '
      'EN_GER_KAY_TAR=En Eski Tarih')
    FieldsGridLabel.Strings = (
      'AD_SOY=Ad'#305' Soyad'#305
      'USER_NAME=Kullan'#305'c'#305' Ad'#305)
    FieldsDisplayWidth.Strings = (
      'AD_SOY=158'
      'USER_NAME=120'
      'YONETICI=79')
    FieldsVisible.Strings = (
      'KULLANICI_ID=FALSE'
      'KULLANICI_SID=FALSE'
      'PASS_WORD=FALSE'
      'E_MAIL=FALSE'
      'SMTP_SERVER=FALSE'
      'SMTP_USER=FALSE'
      'SMTP_PASSWOD=FALSE'
      'SUBE_ID=FALSE'
      'SMTP_AUTHENTICATE=FALSE'
      'RAPKOD_UYG=FALSE'
      'RAPKOD=FALSE'
      'RAPKOD_GOR=FALSE'
      'SUBE_MUDAHALE=FALSE'
      'EN_GER_KAY_TAR=FALSE'
      'KAY_TAR_UYG=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT KULLANICI_ID'
      '     , KULLANICI_SID'
      '     , AD_SOY'
      '     , USER_NAME'
      '     , PASS_WORD'
      '     , YONETICI'
      '     , E_MAIL'
      '     , SMTP_SERVER'
      '     , SMTP_USER'
      '     , SMTP_PASSWOD'
      '     , SMTP_AUTHENTICATE'
      '     , SUBE_ID'
      '     , SUBE_MUDAHALE'
      '     , EN_GER_KAY_TAR'
      '     , KAY_TAR_UYG'
      'FROM KULLANICI')
    ColorScheme = False
    DefaultValues.Strings = (
      'YONETICI=0'
      'SMTP_AUTHENTICATE=0'
      'RAPKOD_UYG=0'
      'RAPKOD_GOR=0'
      'SUBE_MUDAHALE=0'
      'KAY_TAR_UYG=0')
    EditSQL.Strings = (
      'UPDATE KULLANICI SET'
      '   KULLANICI_ID = :KULLANICI_ID, /*PK*/'
      '   KULLANICI_SID = :KULLANICI_SID, /*PK*/'
      '   AD_SOY = :AD_SOY,'
      '   USER_NAME = :USER_NAME,'
      '   PASS_WORD = :PASS_WORD,'
      '   YONETICI = :YONETICI,'
      '   E_MAIL = :E_MAIL,'
      '   SMTP_SERVER = :SMTP_SERVER,'
      '   SMTP_USER = :SMTP_USER,'
      '   SMTP_PASSWOD = :SMTP_PASSWOD,'
      '   SMTP_AUTHENTICATE = :SMTP_AUTHENTICATE,'
      '   SUBE_ID = :SUBE_ID,'
      '   SUBE_MUDAHALE = :SUBE_MUDAHALE,'
      '   EN_GER_KAY_TAR = :EN_GER_KAY_TAR,'
      '   KAY_TAR_UYG = :KAY_TAR_UYG'
      'WHERE'
      '   KULLANICI_ID = :OLD_KULLANICI_ID AND'
      '   KULLANICI_SID = :OLD_KULLANICI_SID')
    GeneratorLinks.Strings = (
      'KULLANICI.KULLANICI_ID=GEN_KULLANICI')
    KeyLinks.Strings = (
      'KULLANICI.KULLANICI_ID'
      'KULLANICI.KULLANICI_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItemNo = 1
    OrderingItems.Strings = (
      'Ad'#305' Soyad'#305' :=AD_SOY;AD_SOY DESC'
      'Kullan'#305'c'#305' Ad'#305' :=USER_NAME;USER_NAME DESC')
    OrderingLinks.Strings = (
      'AD_SOY=ITEM=1'
      'USER_NAME=ITEM=2')
    RequestLive = True
    AfterInsert = qry_KullaniciAfterInsert
    AfterScroll = qry_KullaniciAfterScroll
    BeforeDelete = qry_KullaniciBeforeDelete
    BeforePost = qry_KullaniciBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 532
    Top = 302
  end
  object dts_Kullanici: TIB_DataSource
    Dataset = qry_Kullanici
    OnStateChanged = dts_KullaniciStateChanged
    Left = 398
    Top = 248
  end
  object qrySUBE: TIB_Query
    FieldsVisible.Strings = (
      'SUBEID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT SUBE_ID'
      '     , ADI'
      'FROM SUBE'
      'WHERE SIRKET_ID =:PRM_SIRKET_ID')
    ColorScheme = False
    KeyLinks.Strings = (
      'SUBE.SUBE_ID=KULLANICI.SUBE_ID')
    KeySource = dts_Kullanici
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    PreventEditing = True
    PreventInserting = True
    PreventDeleting = True
    ReadOnly = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 14
    Top = 296
  end
  object dtsSUBE: TIB_DataSource
    Dataset = qrySUBE
    Left = 458
    Top = 244
  end
  object dtsSIRKET: TIB_DataSource
    Dataset = qrySIRKET
    Left = 322
    Top = 246
  end
  object qrySIRKET: TIB_Query
    FieldsDisplayLabel.Strings = (
      'SIRKET_AD='#350'irket Ad'#305)
    FieldsVisible.Strings = (
      'SIRKET_ID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT SIRKET_ID,SIRKET_AD FROM SIRKET '
      'WHERE '
      'SIRKET_ID NOT IN'
      '(SELECT SIRKETHAK.SIRKET_ID FROM SIRKETHAK'
      'WHERE '
      'KULLANICI_ID = :PRM_KULLANICI_ID'
      'AND'
      'KULLANICI_SID = :PRM_KULLANICI_SID'
      ')')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 22
    Top = 246
  end
  object qrySIRKETHAK: TIB_Query
    FieldsDisplayLabel.Strings = (
      'SIRKET_AD='#350'irket Ad'#305)
    FieldsDisplayWidth.Strings = (
      'SIRKET_AD=214')
    FieldsVisible.Strings = (
      'AUTH=FALSE'
      'SIRKET_ID=FALSE'
      'KULLANICI_ID=FALSE'
      'KULLANICI_SID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      
        'SELECT SIRKETHAK.KULLANICI_ID,SIRKETHAK.KULLANICI_SID,SIRKET.SIR' +
        'KET_ID,SIRKET.SIRKET_AD FROM SIRKETHAK'
      
        'LEFT OUTER JOIN SIRKET ON (SIRKETHAK.SIRKET_ID = SIRKET.SIRKET_I' +
        'D)'
      
        'LEFT OUTER JOIN KULLANICI ON (SIRKETHAK.KULLANICI_ID=KULLANICI.K' +
        'ULLANICI_ID AND SIRKETHAK.KULLANICI_SID=KULLANICI.KULLANICI_SID)'
      'WHERE '
      'SIRKETHAK.KULLANICI_ID = :PRM_KULLANICI_ID'
      'AND'
      'SIRKETHAK.KULLANICI_SID = :PRM_KULLANICI_SID')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    AfterScroll = qrySIRKETHAKAfterScroll
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 184
    Top = 300
  end
  object dtsSIRKETHAK: TIB_DataSource
    Dataset = qrySIRKETHAK
    Left = 516
    Top = 246
  end
  object qryHAKDEL: TIB_Query
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'DELETE FROM SIRKETHAK'
      'WHERE '
      'SIRKET_ID = :PRM_SIRKET_ID'
      'AND'
      'KULLANICI_ID = :PRM_KULLANICI_ID'
      'AND'
      'KULLANICI_SID = :PRM_KULLANICI_SID')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 124
    Top = 300
  end
  object qryHAKINS: TIB_Query
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      
        'INSERT INTO SIRKETHAK (SIRKET_ID,KULLANICI_ID,KULLANICI_SID) VAL' +
        'UES '
      '(:PRM_SIRKET_ID,:PRM_KULLANICI_ID,:PRM_KULLANICI_SID)')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 406
    Top = 306
  end
  object qrySIRKETDONEM: TIB_Query
    FieldsDisplayLabel.Strings = (
      'DONEM_NO=D'#246'nem No'
      'DONEM_SON=D'#246'nem Sonu'
      'DONEM_BAS=D'#246'nem Ba'#351#305)
    FieldsDisplayWidth.Strings = (
      'DONEM_NO=62'
      'DONEM_BAS=66'
      'DONEM_SON=71')
    FieldsVisible.Strings = (
      'DB_KEY=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT DONEM_NO'
      '     , DONEM_BAS'
      '     , DONEM_SON'
      'FROM TERMS WHERE SIRKET_ID =:PRM_SIRKET_ID'
      'AND'
      'DONEM_NO NOT IN'
      '(SELECT DONEMHAK.DONEM_NO FROM DONEMHAK'
      'WHERE'
      'KULLANICI_ID = :PRM_KULLANICI_ID'
      'AND'
      'KULLANICI_SID = :PRM_KULLANICI_SID'
      'AND'
      'SIRKET_ID = :PRM_SIRKET_ID'
      ')')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 80
    Top = 297
  end
  object dtsSIRKETDONEM: TIB_DataSource
    Dataset = qrySIRKETDONEM
    Left = 626
    Top = 243
  end
  object qryDONEMHAK: TIB_Query
    FieldsDisplayLabel.Strings = (
      'DONEM_NO=D'#246'nem No'
      'DONEM_BAS=D'#246'nem Ba'#351#305
      'DONEM_SON=D'#246'nem Sonu')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT TERMS.DONEM_NO'
      '     , TERMS.DONEM_BAS'
      '     , TERMS.DONEM_SON'
      'FROM TERMS'
      'LEFT OUTER JOIN SIRKET ON (SIRKET.SIRKET_ID = TERMS.SIRKET_ID)'
      
        'LEFT OUTER JOIN DONEMHAK ON (DONEMHAK.SIRKET_ID = TERMS.SIRKET_I' +
        'D AND DONEMHAK.DONEM_NO = TERMS.DONEM_NO)'
      'WHERE SIRKET.SIRKET_ID =:PRM_SIRKET_ID'
      'AND'
      'KULLANICI_ID = :PRM_KULLANICI_ID'
      'AND'
      'KULLANICI_SID = :PRM_KULLANICI_SID')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 77
    Top = 250
  end
  object dtsDONEMHAK: TIB_DataSource
    Dataset = qryDONEMHAK
    Left = 581
    Top = 250
  end
  object qryDONEMINS: TIB_Query
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      
        'INSERT INTO DONEMHAK (SIRKET_ID,DONEM_NO,KULLANICI_ID,KULLANICI_' +
        'SID) VALUES '
      
        '(:PRM_SIRKET_ID,:PRM_DONEM_NO,:PRM_KULLANICI_ID,:PRM_KULLANICI_S' +
        'ID)')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 472
    Top = 304
  end
  object qryDONEMDEL: TIB_Query
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'DELETE FROM DONEMHAK'
      'WHERE '
      'SIRKET_ID = :PRM_SIRKET_ID'
      'AND'
      'DONEM_NO = :PRM_DONEM_NO'
      'AND'
      'KULLANICI_ID = :PRM_KULLANICI_ID'
      'AND'
      'KULLANICI_SID = :PRM_KULLANICI_SID')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 598
    Top = 304
  end
  object qrySrkKasa: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    FieldsDisplayLabel.Strings = (
      'KASA_KOD=Kasa Kodu'
      'ACIKLAMA=Kasa Ad'#305)
    FieldsDisplayWidth.Strings = (
      'ACIKLAMA=141')
    FieldsVisible.Strings = (
      'KASA_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT KASA_KOD,ACIKLAMA,KASA_SID FROM KASA'
      'WHERE KASA_KOD NOT IN'
      '('
      'SELECT KASAHAK.KASA_KOD'
      'FROM KASA'
      
        'INNER JOIN KASAHAK ON (KASAHAK.KASA_KOD = KASA.KASA_KOD AND KASA' +
        'HAK.KASA_SID = KASA.KASA_SID)'
      'WHERE'
      'KASAHAK.KULLANICI_ID = :PRM_KULLANICI_ID'
      'AND'
      'KASAHAK.KULLANICI_SID = :PRM_KULLANICI_SID'
      ')')
    ColorScheme = False
    KeyLinks.Strings = (
      'KASA.KASA_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 293
    Top = 295
  end
  object dtsSrkKasa: TIB_DataSource
    Dataset = qrySrkKasa
    Left = 167
    Top = 247
  end
  object qryKulKasa: TIB_Query
    ColumnAttributes.Strings = (
      'VARSAYILAN=BOOLEAN=1,0')
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    FieldsDisplayLabel.Strings = (
      'KASA_KOD=Kasa Kodu'
      'ACIKLAMA=Kasa Ad'#305
      'VARSAYILAN=Varsay'#305'lan')
    FieldsDisplayWidth.Strings = (
      'ACIKLAMA=84'
      'VARSAYILAN=57'
      'KASA_KOD=77')
    FieldsVisible.Strings = (
      'KASA_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      
        'SELECT KASAHAK.KASA_KOD,KASA.ACIKLAMA,KASAHAK.KASA_SID,KASAHAK.V' +
        'ARSAYILAN FROM KASA'
      
        'INNER JOIN KASAHAK ON (KASAHAK.KASA_KOD = KASA.KASA_KOD AND KASA' +
        'HAK.KASA_SID = KASA.KASA_SID)'
      
        'AND KASAHAK.KULLANICI_ID = :PRM_KULLANICI_ID AND KASAHAK.KULLANI' +
        'CI_SID = :PRM_KULLANICI_SID')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 659
    Top = 295
  end
  object dtsKulKasa: TIB_DataSource
    Dataset = qryKulKasa
    Left = 245
    Top = 247
  end
  object qryKASAINS: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      
        'INSERT INTO KASAHAK (KULLANICI_ID,KULLANICI_SID,KASA_KOD,KASA_SI' +
        'D,VARSAYILAN) VALUES '
      
        '(:PRM_KULLANICI_ID,:PRM_KULLANICI_SID,:PRM_KASA_KOD,:PRM_KASA_SI' +
        'D,:PRM_VARSAYILAN)')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 242
    Top = 302
  end
  object qryKASADEL: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'DELETE FROM KASAHAK'
      'WHERE'
      'KULLANICI_ID = :PRM_KULLANICI_ID'
      'AND'
      'KULLANICI_SID = :PRM_KULLANICI_SID'
      'AND'
      'KASA_KOD = :PRM_KASA_KOD'
      'AND'
      'KASA_SID = :PRM_KASA_SID')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 355
    Top = 298
  end
end
