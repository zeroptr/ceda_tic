object frmOnarim: TfrmOnarim
  Left = 92
  Top = 105
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Onar'#305'm Fi'#351'i'
  ClientHeight = 462
  ClientWidth = 790
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 324
    Top = 4
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object pgFAT_IRS: TPageControl
    Left = 0
    Top = 0
    Width = 790
    Height = 462
    ActivePage = tabFAT_IRS
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    TabStop = False
    OnChange = pgFAT_IRSChange
    OnChanging = pgFAT_IRSChanging
    object tabFAT_IRS: TTabSheet
      Caption = 'Onar'#305'm Fi'#351'i Bilgileri'
      object IB_Text24: TIB_Text
        Left = 226
        Top = 61
        Width = 309
        Height = 14
        DataField = 'CARI_ADI'
        DataSource = dtsFAT_IRS
        Color = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object IB_Text25: TIB_Text
        Left = 226
        Top = 37
        Width = 309
        Height = 14
        DataField = 'ARAC_PLAKA'
        DataSource = dtsFAT_IRS
        Color = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label1: TLabel
        Left = 16
        Top = 272
        Width = 81
        Height = 13
        Caption = 'Yak'#305't Seviyesi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object IB_Text26: TIB_Text
        Left = 230
        Top = 189
        Width = 307
        Height = 14
        DataField = 'PERSONEL_ADI'
        DataSource = dtsFAT_IRS
        Color = clMoneyGreen
        ParentColor = False
      end
      object IB_Text27: TIB_Text
        Left = 230
        Top = 141
        Width = 309
        Height = 14
        DataField = 'NEDEN_ACIKLAMA'
        DataSource = dtsFAT_IRS
        Color = clMoneyGreen
        ParentColor = False
      end
      object Panel5: TPanel
        Left = 0
        Top = 401
        Width = 782
        Height = 30
        Align = alBottom
        TabOrder = 6
        TabStop = True
        object btnAra: TBitBtn
          Left = 622
          Top = 3
          Width = 62
          Height = 25
          Caption = '&Ara'
          TabOrder = 1
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
          Left = 683
          Top = 3
          Width = 61
          Height = 25
          Caption = #199#305'&k'#305#351
          TabOrder = 3
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
          Left = 6
          Top = 3
          Width = 82
          Height = 25
          Caption = 'Yeni (INS)'
          TabOrder = 2
          OnClick = btnYeniClick
        end
        object btnTRN_KAYDET: TButton
          Left = 87
          Top = 3
          Width = 119
          Height = 25
          Caption = 'Kaydet ( CTRL + END)'
          TabOrder = 0
          OnClick = btnTRN_KAYDETClick
        end
        object btnTRN_IPTAL: TButton
          Left = 205
          Top = 3
          Width = 108
          Height = 25
          Caption = 'Iptal (CTRL + A)'
          TabOrder = 4
          OnClick = btnTRN_IPTALClick
        end
        object btnFaturaSil: TBitBtn
          Left = 312
          Top = 3
          Width = 92
          Height = 25
          Caption = 'Sil (CTRL + DEL)'
          TabOrder = 5
          OnClick = btnFaturaSilClick
        end
        object Btn_Onceki: TBitBtn
          Left = 423
          Top = 3
          Width = 75
          Height = 25
          Caption = '&'#214'nceki Fi'#351
          TabOrder = 6
          OnClick = Btn_OncekiClick
        end
        object Btn_Sonraki: TBitBtn
          Left = 503
          Top = 3
          Width = 75
          Height = 25
          Caption = '&Sonraki Fi'#351
          TabOrder = 7
          OnClick = Btn_SonrakiClick
        end
      end
      object IB_Edit40: TIB_Edit
        Left = 76
        Top = 320
        Width = 445
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'ACIKLAMA'
        DataSource = dtsFAT_IRS
        TabOrder = 4
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit40Exit
      end
      object txtFaturaProjeAD: TIB_Edit
        Left = 221
        Top = 295
        Width = 300
        Height = 21
        TabStop = False
        DataField = 'PROJE_AD'
        DataSource = dtsFAT_IRS
        Enabled = False
        Visible = False
        TabOrder = 7
      end
      object txtCariKod: TIB_Edit
        Left = 76
        Top = 59
        Width = 145
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'CARI_KOD'
        DataSource = dtsFAT_IRS
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnEnter = txtCariKodEnter
        OnExit = txtCariKodExit
        OnKeyPress = txtCariKodKeyPress
        OnKeyUp = txtCariKodKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtCariKodButtonClick
      end
      object txtProjeKod: TIB_Edit
        Left = 76
        Top = 295
        Width = 145
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'PROJE_KOD'
        DataSource = dtsFAT_IRS
        Visible = False
        TabOrder = 3
        OnEnter = txtProjeKodEnter
        OnExit = txtProjeKodExit
        OnKeyPress = txtProjeKodKeyPress
        OnKeyUp = txtProjeKodKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtProjeKodButtonClick
      end
      object IB_Edit2: TIB_Edit
        Left = 76
        Top = 9
        Width = 144
        Height = 24
        AutoLabel.Kind = albLeft
        AutoLabel.Caption = 'Fi'#351' No'
        DataField = 'ONARIM_ID'
        DataSource = dtsFAT_IRS
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_CheckBox1: TIB_CheckBox
        Left = 678
        Top = 367
        Width = 97
        Height = 17
        DataField = 'YAZILDI'
        DataSource = dtsFAT_IRS
        BorderStyle = bsNone
        PreventEditing = True
        ReadOnly = True
        TabOrder = 8
        Caption = 'Yazd'#305'r'#305'ld'#305
      end
      object rgYAZICI: TRadioGroup
        Left = 674
        Top = 270
        Width = 101
        Height = 69
        Caption = 'Yazd'#305'rma'
        ItemIndex = 2
        Items.Strings = (
          'Yazd'#305'r'
          #214'n '#304'zleme'
          'Sadece Kay'#305't')
        TabOrder = 9
      end
      object btnCikti: TButton
        Left = 674
        Top = 341
        Width = 100
        Height = 25
        Caption = 'Yaz'#305'c'#305' '#199#305'kt'#305's'#305
        TabOrder = 10
        TabStop = False
        OnClick = btnCiktiClick
      end
      object grpRapKod: TGroupBox
        Left = 3
        Top = 343
        Width = 556
        Height = 50
        TabOrder = 5
        object IB_Edit5: TIB_Edit
          Left = 16
          Top = 21
          Width = 83
          Height = 21
          AutoLabel.Kind = albTop
          AutoLabel.Caption = #304#351'lem Merkezi'
          DataField = 'MASRAF_MERK'
          DataSource = dtsFAT_IRS
          TabOrder = 0
          OnEnter = IB_Edit5Enter
          OnExit = IB_Edit5Exit
          OnKeyUp = IB_Edit5KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit5ButtonClick
        end
        object IB_Edit6: TIB_Edit
          Left = 126
          Top = 21
          Width = 85
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD1'
          DataSource = dtsFAT_IRS
          TabOrder = 1
          OnEnter = IB_Edit6Enter
          OnExit = IB_Edit6Exit
          OnKeyUp = IB_Edit6KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit6ButtonClick
        end
        object IB_Edit7: TIB_Edit
          Left = 234
          Top = 21
          Width = 81
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD2'
          DataSource = dtsFAT_IRS
          TabOrder = 2
          OnEnter = IB_Edit7Enter
          OnExit = IB_Edit7Exit
          OnKeyUp = IB_Edit7KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit7ButtonClick
        end
        object IB_Edit24: TIB_Edit
          Left = 342
          Top = 21
          Width = 85
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD3'
          DataSource = dtsFAT_IRS
          TabOrder = 3
          OnEnter = IB_Edit24Enter
          OnExit = IB_Edit24Exit
          OnKeyUp = IB_Edit24KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit24ButtonClick
        end
        object IB_Edit25: TIB_Edit
          Left = 453
          Top = 21
          Width = 85
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD4'
          DataSource = dtsFAT_IRS
          TabOrder = 4
          OnEnter = IB_Edit25Enter
          OnExit = IB_Edit25Exit
          OnKeyUp = IB_Edit25KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit25ButtonClick
        end
      end
      object txt_Sevk_Adres: TIB_Edit
        Left = 76
        Top = 83
        Width = 145
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'SEVK_ADRES_KOD'
        DataSource = dtsFAT_IRS
        TabOrder = 2
        OnEnter = txt_Sevk_AdresEnter
        OnExit = txt_Sevk_AdresExit
        OnKeyPress = txtCariKodKeyPress
        OnKeyUp = txt_Sevk_AdresKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txt_Sevk_AdresButtonClick
      end
      object txtArac_Kod: TIB_Edit
        Left = 76
        Top = 35
        Width = 145
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'ARAC_KODU'
        DataSource = dtsFAT_IRS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 11
        OnEnter = txtArac_KodEnter
        OnExit = txtArac_KodExit
        OnKeyPress = txtArac_KodKeyPress
        OnKeyUp = txtArac_KodKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtArac_KodButtonClick
      end
      object rg_Yakit_Seviyesi: TIB_RadioGroup
        Left = 104
        Top = 264
        Width = 377
        Height = 25
        DataField = 'YAKIT_SEVIYESI'
        DataSource = dtsFAT_IRS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        Columns = 4
        Items.Strings = (
          '1/4'
          '1/2'
          '3/4'
          '4/4')
        Values.Strings = (
          '1'
          '2'
          '3'
          '4')
      end
      object cb_Odeme_Sekli: TIB_ComboBox
        Left = 76
        Top = 160
        Width = 145
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'ODEME_SEKLI'
        DataSource = dtsFAT_IRS
        TabOrder = 13
        Style = csDropDownList
        ItemHeight = 13
        Items.Strings = (
          'Banka Havalesi'
          #199'ek ile '#214'deme'
          'Kredi Kart'#305' ile '#214'deme'
          'Nakit '#214'deme'
          'Senet ile '#214'deme')
        ItemValues.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5')
      end
      object cr_Onceki_km: TIB_Currency
        Left = 76
        Top = 216
        Width = 121
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'ONCEKI_KM'
        DataSource = dtsFAT_IRS
        TabOrder = 14
        AlwaysShowButton = True
      end
      object cr_Giris_Km: TIB_Currency
        Left = 76
        Top = 240
        Width = 121
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'GIRIS_KM'
        DataSource = dtsFAT_IRS
        TabOrder = 15
        AlwaysShowButton = True
      end
      object cr_Tahmini_Parca: TIB_Currency
        Left = 360
        Top = 216
        Width = 121
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'TAHMINI_PARCA_TUTAR'
        DataSource = dtsFAT_IRS
        TabOrder = 16
        AlwaysShowButton = True
      end
      object IB_Currency2: TIB_Currency
        Left = 360
        Top = 240
        Width = 121
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'TAHMINI_ISCILIK_TUTAR'
        DataSource = dtsFAT_IRS
        TabOrder = 17
        AlwaysShowButton = True
      end
      object IB_CheckBox2: TIB_CheckBox
        Left = 16
        Top = 112
        Width = 137
        Height = 17
        DataField = 'GARANTI_ISLEMI'
        DataSource = dtsFAT_IRS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 18
        Caption = 'Garanti '#304#351'lemi Var'
      end
      object IB_CheckBox3: TIB_CheckBox
        Left = 224
        Top = 112
        Width = 137
        Height = 17
        DataField = 'EXSPERTIZ_ISLEMI'
        DataSource = dtsFAT_IRS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 19
        Caption = 'Expertiz '#304#351'lemi Var'
      end
      object IB_CheckBox4: TIB_CheckBox
        Left = 424
        Top = 112
        Width = 190
        Height = 17
        DataField = 'SOK_PAR_IADE'
        DataSource = dtsFAT_IRS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 20
        Caption = 'S'#246'k'#252'len Par'#231'a '#304'ade Edilecek'
      end
      object IB_Edit1: TIB_Edit
        Left = 600
        Top = 192
        Width = 177
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'TESLIM_EDEN'
        DataSource = dtsFAT_IRS
        TabOrder = 21
      end
      object IB_Edit3: TIB_Edit
        Left = 600
        Top = 216
        Width = 177
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'ALACAK_OLAN'
        DataSource = dtsFAT_IRS
        TabOrder = 22
      end
      object IB_Edit8: TIB_Edit
        Left = 656
        Top = 240
        Width = 121
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'TELEFON'
        DataSource = dtsFAT_IRS
        TabOrder = 23
      end
      object IB_Date2: TIB_Date
        Left = 686
        Top = 8
        Width = 94
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'GIRIS_TARIH'
        DataSource = dtsFAT_IRS
        TabOrder = 24
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_Date3: TIB_Date
        Left = 687
        Top = 32
        Width = 93
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'GIRIS_SAAT'
        DataSource = dtsFAT_IRS
        TabOrder = 25
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_Date1: TIB_Date
        Left = 688
        Top = 64
        Width = 92
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'TESLIM_TAR'
        DataSource = dtsFAT_IRS
        TabOrder = 26
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_Date4: TIB_Date
        Left = 689
        Top = 88
        Width = 91
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'TESLIM_SAAT'
        DataSource = dtsFAT_IRS
        TabOrder = 27
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object Button1: TButton
        Left = 560
        Top = 348
        Width = 113
        Height = 44
        Caption = #214'nceki Onar'#305'mlar'#305
        TabOrder = 28
        OnClick = Button1Click
      end
      object IB_CheckBox5: TIB_CheckBox
        Left = 533
        Top = 311
        Width = 124
        Height = 17
        DataField = 'IPTAL'
        DataSource = dtsFAT_IRS
        BorderStyle = bsNone
        TabOrder = 29
        Caption = 'Onar'#305'm Fi'#351'ini '#304'ptal Et'
      end
      object txtPersonel: TIB_Edit
        Left = 76
        Top = 184
        Width = 145
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'KABUL_EDEN_PERS'
        DataSource = dtsFAT_IRS
        TabOrder = 30
        OnEnter = txtPersonelEnter
        OnExit = txtPersonelExit
        OnKeyPress = txtPersonelKeyPress
        OnKeyUp = txtPersonelKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtPersonelButtonClick
      end
      object txt_Gel_Neden: TIB_Edit
        Left = 76
        Top = 136
        Width = 145
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'GELIS_NEDENI_KOD'
        DataSource = dtsFAT_IRS
        TabOrder = 31
        OnEnter = txt_Gel_NedenEnter
        OnExit = txt_Gel_NedenExit
        OnKeyPress = txt_Gel_NedenKeyPress
        OnKeyUp = txt_Gel_NedenKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txt_Gel_NedenButtonClick
      end
      object IB_Date5: TIB_Date
        Left = 690
        Top = 120
        Width = 90
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'BITIS_TARIHI'
        DataSource = dtsFAT_IRS
        TabOrder = 32
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_Date6: TIB_Date
        Left = 691
        Top = 144
        Width = 89
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'BITIS_SAAT'
        DataSource = dtsFAT_IRS
        TabOrder = 33
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_CheckBox6: TIB_CheckBox
        Left = 677
        Top = 383
        Width = 92
        Height = 17
        DataField = 'KAPANDI'
        DataSource = dtsFAT_IRS
        Enabled = False
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 34
        Caption = 'Faturas'#305' Kesildi'
      end
    end
    object tabKalem: TTabSheet
      Caption = 'Onar'#305'm Fi'#351'i Detaylar'#305' Bilgileri'
      ImageIndex = 1
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 782
        Height = 19
        Align = alTop
        TabOrder = 0
        object Label18: TLabel
          Left = 419
          Top = 3
          Width = 36
          Height = 13
          Caption = 'Cari Ad'#305
        end
        object Label19: TLabel
          Left = 293
          Top = 3
          Width = 46
          Height = 13
          Caption = 'Cari Kodu'
        end
        object Label20: TLabel
          Left = 5
          Top = 2
          Width = 46
          Height = 13
          Caption = 'Seri / No:'
        end
        object IB_Text1: TIB_Text
          Left = 52
          Top = 3
          Width = 53
          Height = 13
          DataField = 'FAT_IRS_SERI'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text2: TIB_Text
          Left = 104
          Top = 3
          Width = 96
          Height = 13
          DataField = 'BELGE_NO'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text3: TIB_Text
          Left = 226
          Top = 3
          Width = 65
          Height = 13
          DataField = 'TARIH'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object Label21: TLabel
          Left = 199
          Top = 3
          Width = 24
          Height = 13
          Caption = 'Tarih'
        end
        object IB_Text4: TIB_Text
          Left = 342
          Top = 3
          Width = 77
          Height = 13
          DataField = 'CARI_KOD'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text5: TIB_Text
          Left = 459
          Top = 3
          Width = 314
          Height = 13
          DataField = 'CARI_AD'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 401
        Width = 782
        Height = 30
        Align = alBottom
        TabOrder = 1
        object IB_Text22: TIB_Text
          Left = 627
          Top = 6
          Width = 116
          Height = 17
          DataField = 'BRUT_TOP'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object Label37: TLabel
          Left = 590
          Top = 7
          Width = 35
          Height = 13
          Caption = 'Toplam'
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 19
        Width = 782
        Height = 138
        Align = alTop
        TabOrder = 2
        object lblKAL_ISKONTO_TIP: TLabel
          Left = 10
          Top = 73
          Width = 35
          Height = 13
          Caption = #304'skonto'
        end
        object IB_Text16: TIB_Text
          Left = 5
          Top = 3
          Width = 70
          Height = 13
          DataField = 'URUNHAR_ID'
          DataSource = dtsURUNHAR
          Color = clInfoBk
          ParentColor = False
        end
        object btnEKLE: TButton
          Left = 5
          Top = 112
          Width = 60
          Height = 23
          Caption = 'Ekle (INS)'
          TabOrder = 17
          OnClick = btnEKLEClick
        end
        object btnKaydet: TButton
          Left = 64
          Top = 112
          Width = 94
          Height = 23
          Caption = 'Kaydet (CTRL+S)'
          TabOrder = 18
          OnClick = btnKaydetClick
        end
        object btnIptal: TButton
          Left = 157
          Top = 112
          Width = 86
          Height = 23
          Caption = #304'ptal(CTRL+P)'
          TabOrder = 19
          OnClick = btnIptalClick
        end
        object btnSil: TButton
          Left = 640
          Top = 112
          Width = 95
          Height = 23
          Caption = 'Sil (CTRL + DEL)'
          TabOrder = 20
          OnClick = btnSilClick
        end
        object txtUrunKodu: TIB_Edit
          Left = 77
          Top = 16
          Width = 116
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'URUN_KOD'
          DataSource = dtsURUNHAR
          TabOrder = 0
          OnEnter = txtUrunKoduEnter
          OnExit = txtUrunKoduExit
          OnKeyPress = txtUrunKoduKeyPress
          OnKeyUp = txtUrunKoduKeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = txtUrunKoduButtonClick
        end
        object IB_Edit23: TIB_Edit
          Left = 195
          Top = 16
          Width = 278
          Height = 21
          TabStop = False
          AutoLabel.Kind = albTop
          DataField = 'URUN_AD'
          DataSource = dtsURUNHAR
          Enabled = False
          TabOrder = 1
        end
        object txtOlcuBirim: TIB_Edit
          Left = 45
          Top = 51
          Width = 121
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'OLCUBIRIM'
          DataSource = dtsURUNHAR
          TabOrder = 4
          OnEnter = txtOlcuBirimEnter
          OnExit = txtOlcuBirimExit
          OnKeyPress = txtOlcuBirimKeyPress
          OnKeyUp = txtOlcuBirimKeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = txtOlcuBirimButtonClick
        end
        object IB_Currency5: TIB_Currency
          Left = 167
          Top = 51
          Width = 94
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'BIRIM_FIY'
          DataSource = dtsURUNHAR
          TabOrder = 5
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object edtDOVKUR: TIB_Currency
          Left = 354
          Top = 51
          Width = 86
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'DOVKUR'
          DataSource = dtsURUNHAR
          TabOrder = 7
          OnEnter = IB_Edit1Enter
          OnExit = edtDOVKURExit
          AlwaysShowButton = True
        end
        object edtTUTAR: TIB_Currency
          Left = 441
          Top = 51
          Width = 102
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'TUTAR'
          DataSource = dtsURUNHAR
          Enabled = False
          TabOrder = 9
          OnEnter = IB_Edit24Enter
          OnExit = IB_Edit24Exit
          AlwaysShowButton = True
        end
        object IB_Currency1: TIB_Currency
          Left = 545
          Top = 51
          Width = 124
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'TUTAR_VPB'
          DataSource = dtsURUNHAR
          Enabled = False
          TabOrder = 10
          OnEnter = IB_Edit24Enter
          OnExit = IB_Edit24Exit
          AlwaysShowButton = True
          CalculatorKind = cucInline
        end
        object IB_Edit22: TIB_Edit
          Left = 670
          Top = 51
          Width = 25
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KDV'
          DataSource = dtsURUNHAR
          TabOrder = 11
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
        end
        object txtDepoKod: TIB_Edit
          Left = 474
          Top = 16
          Width = 71
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'DEPO_KOD'
          DataSource = dtsURUNHAR
          TabOrder = 2
          OnEnter = txtDepoKodEnter
          OnExit = txtDepoKodExit
          OnKeyPress = txtDepoKodKeyPress
          OnKeyUp = txtDepoKodKeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = txtDepoKodButtonClick
        end
        object txtDepoAd: TIB_Edit
          Left = 546
          Top = 16
          Width = 229
          Height = 21
          TabStop = False
          AutoLabel.Kind = albTop
          DataField = 'DEPO_AD'
          DataSource = dtsURUNHAR
          Enabled = False
          TabOrder = 8
        end
        object rdIskonto: TIB_RadioGroup
          Left = 5
          Top = 87
          Width = 103
          Height = 22
          DataField = 'ISKONTO_TIP'
          DataSource = dtsURUNHAR
          TabOrder = 12
          Columns = 2
          Items.Strings = (
            'Oran'
            'Tutar')
          Values.Strings = (
            '0'
            '1')
          OnChange = rdIskontoChange
        end
        object txtIskontoOran: TIB_Edit
          Left = 110
          Top = 87
          Width = 37
          Height = 21
          AutoLabel.Kind = albTop
          AutoLabel.Margin = -3
          DataField = 'ISKONTO_ORAN'
          DataSource = dtsURUNHAR
          TabOrder = 13
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
        end
        object txtIskontoTutar: TIB_Currency
          Left = 148
          Top = 87
          Width = 108
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'ISKONTO_TUTAR'
          DataSource = dtsURUNHAR
          TabOrder = 14
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object txtISKONTO_TUTAR_VPB: TIB_Currency
          Left = 257
          Top = 87
          Width = 125
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'ISKONTO_TUTAR_VPB'
          DataSource = dtsURUNHAR
          Enabled = False
          TabOrder = 15
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object IB_Edit28: TIB_Edit
          Left = 383
          Top = 87
          Width = 350
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'ACIKLAMA'
          DataSource = dtsURUNHAR
          TabOrder = 16
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
        end
        object IB_Edit4: TIB_Edit
          Left = 696
          Top = 51
          Width = 80
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KDV_TUTAR'
          DataSource = dtsURUNHAR
          Enabled = False
          TabOrder = 21
        end
        object IB_Currency7: TIB_Currency
          Left = 4
          Top = 51
          Width = 39
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'MIKTAR'
          DataSource = dtsURUNHAR
          TabOrder = 3
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object cboDOVKOD: TIB_ComboBox
          Left = 263
          Top = 51
          Width = 89
          Height = 21
          AutoLabel.Kind = albTop
          AutoLabel.Caption = 'D'#246'viz Kodu'
          DataField = 'DOVKOD'
          DataSource = dtsURUNHAR
          TabOrder = 6
          OnEnter = cboDOVKODEnter
          OnExit = cboDOVKODExit
          Style = csDropDownList
          ItemHeight = 0
        end
        object BitBtn2: TBitBtn
          Left = 5
          Top = 16
          Width = 71
          Height = 20
          Caption = 'Paket Se'#231'imi'
          TabOrder = 22
          OnClick = BitBtn2Click
        end
      end
      object grdFatKontrol: TIB_Grid
        Left = 0
        Top = 157
        Width = 782
        Height = 244
        TabStop = False
        CustomGlyphsSupplied = []
        DataSource = dtsURUNHAR
        Align = alClient
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 3
        RowSelect = True
        Ctl3DShallow = True
      end
    end
    object tabToplam: TTabSheet
      Caption = 'Toplamlar'
      ImageIndex = 2
      object GroupBox1: TGroupBox
        Left = 8
        Top = 8
        Width = 241
        Height = 281
        Caption = 'Fatura Bilgileri'
        TabOrder = 0
        object Label5: TLabel
          Left = 47
          Top = 179
          Width = 62
          Height = 13
          Caption = 'KDV Toplam'#305
        end
        object lblTOP_PAG_KAL_ISK_TOP: TLabel
          Left = 38
          Top = 41
          Width = 72
          Height = 13
          Caption = 'Kal. '#304's. Toplam'#305
        end
        object Label9: TLabel
          Left = 52
          Top = 17
          Width = 57
          Height = 13
          Caption = 'Br'#252't Toplam'
        end
        object Label10: TLabel
          Left = 54
          Top = 158
          Width = 55
          Height = 13
          Caption = 'Net Toplam'
        end
        object Label11: TLabel
          Left = 44
          Top = 224
          Width = 66
          Height = 13
          Caption = 'Genel Toplam'
        end
        object IB_Text15: TIB_Text
          Left = 112
          Top = 16
          Width = 122
          Height = 17
          DataField = 'BRUT_TOP'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object txtTOP_PAG_KAL_ISK_TOP: TIB_Text
          Left = 112
          Top = 40
          Width = 122
          Height = 17
          DataField = 'KALEM_ISKONTO_TOPLAM_VPB'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text17: TIB_Text
          Left = 112
          Top = 157
          Width = 122
          Height = 17
          DataField = 'NET_TOP'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text18: TIB_Text
          Left = 112
          Top = 178
          Width = 122
          Height = 17
          DataField = 'KDV_TOP'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text19: TIB_Text
          Left = 112
          Top = 224
          Width = 122
          Height = 17
          DataField = 'GENEL_TOP'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object Label35: TLabel
          Left = 52
          Top = 63
          Width = 55
          Height = 13
          Caption = #304'skonto Tipi'
          Visible = False
        end
        object IB_Text21: TIB_Text
          Left = 112
          Top = 136
          Width = 122
          Height = 17
          DataField = 'ISKONTO_TOPLAM_VPB'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object Label36: TLabel
          Left = 35
          Top = 136
          Width = 75
          Height = 13
          Caption = #304'skonto Toplam'#305
        end
        object rdFatIsTip: TIB_RadioGroup
          Left = 112
          Top = 60
          Width = 122
          Height = 22
          DataField = 'ISKONTO_TIP'
          DataSource = dtsFAT_IRS
          Visible = False
          TabOrder = 0
          Columns = 2
          Items.Strings = (
            'Oran'
            'Tutar')
          Values.Strings = (
            '0'
            '1')
          OnChange = rdFatIsTipChange
        end
        object txtFatIskontoOran: TIB_Currency
          Left = 112
          Top = 86
          Width = 33
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ISKONTO_ORAN'
          DataSource = dtsFAT_IRS
          Visible = False
          TabOrder = 1
          AlwaysShowButton = True
        end
        object txtFatIskontoTutar: TIB_Currency
          Left = 112
          Top = 112
          Width = 122
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ISKONTO_TUTAR_VPB'
          DataSource = dtsFAT_IRS
          Visible = False
          TabOrder = 2
          AlwaysShowButton = True
        end
        object IB_Currency6: TIB_Currency
          Left = 112
          Top = 197
          Width = 121
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'OTV'
          DataSource = dtsFAT_IRS
          TabOrder = 3
          AlwaysShowButton = True
        end
      end
      object GroupBox3: TGroupBox
        Left = 264
        Top = 8
        Width = 241
        Height = 169
        Caption = 'KDV'
        TabOrder = 1
        object IB_Text6: TIB_Text
          Left = 38
          Top = 17
          Width = 19
          Height = 17
          DataField = 'KDV1_ORAN'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text7: TIB_Text
          Left = 99
          Top = 16
          Width = 121
          Height = 17
          DataField = 'KDV1'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text8: TIB_Text
          Left = 38
          Top = 63
          Width = 19
          Height = 17
          DataField = 'KDV3_ORAN'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text9: TIB_Text
          Left = 38
          Top = 40
          Width = 19
          Height = 17
          DataField = 'KDV2_ORAN'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text10: TIB_Text
          Left = 99
          Top = 40
          Width = 121
          Height = 17
          DataField = 'KDV2'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text11: TIB_Text
          Left = 38
          Top = 87
          Width = 19
          Height = 17
          DataField = 'KDV4_ORAN'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text12: TIB_Text
          Left = 99
          Top = 63
          Width = 121
          Height = 17
          DataField = 'KDV3'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text13: TIB_Text
          Left = 99
          Top = 87
          Width = 121
          Height = 17
          DataField = 'KDV4'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text14: TIB_Text
          Left = 99
          Top = 111
          Width = 121
          Height = 17
          DataField = 'KDV5'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text20: TIB_Text
          Left = 38
          Top = 111
          Width = 19
          Height = 17
          DataField = 'KDV5_ORAN'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text23: TIB_Text
          Left = 99
          Top = 133
          Width = 121
          Height = 17
          DataField = 'KDV_TOP'
          DataSource = dtsFAT_IRS
          Color = clInfoBk
          ParentColor = False
        end
        object Label24: TLabel
          Left = 5
          Top = 17
          Width = 31
          Height = 13
          Caption = 'KDV 1'
        end
        object Label25: TLabel
          Left = 5
          Top = 41
          Width = 31
          Height = 13
          Caption = 'KDV 2'
        end
        object Label26: TLabel
          Left = 5
          Top = 65
          Width = 31
          Height = 13
          Caption = 'KDV 3'
        end
        object Label27: TLabel
          Left = 5
          Top = 89
          Width = 31
          Height = 13
          Caption = 'KDV 4'
        end
        object Label28: TLabel
          Left = 5
          Top = 113
          Width = 31
          Height = 13
          Caption = 'KDV 5'
        end
        object Label29: TLabel
          Left = 71
          Top = 17
          Width = 25
          Height = 13
          Caption = 'Tutar'
        end
        object Label30: TLabel
          Left = 71
          Top = 40
          Width = 25
          Height = 13
          Caption = 'Tutar'
        end
        object Label31: TLabel
          Left = 71
          Top = 64
          Width = 25
          Height = 13
          Caption = 'Tutar'
        end
        object Label32: TLabel
          Left = 71
          Top = 89
          Width = 25
          Height = 13
          Caption = 'Tutar'
        end
        object Label33: TLabel
          Left = 71
          Top = 112
          Width = 25
          Height = 13
          Caption = 'Tutar'
        end
        object Label34: TLabel
          Left = 7
          Top = 136
          Width = 88
          Height = 13
          Caption = 'Toplam KDV Tutar'
        end
      end
    end
    object tabAciklama: TTabSheet
      Caption = 'A'#231#305'klamalar'
      ImageIndex = 3
      object IB_Memo1: TIB_Memo
        Left = 16
        Top = 16
        Width = 761
        Height = 97
        AutoLabel.Kind = albTop
        DataField = 'ONARIM_ISTEKLERI'
        DataSource = dtsFAT_IRS
        TabOrder = 0
        AutoSize = False
      end
      object IB_Memo2: TIB_Memo
        Left = 16
        Top = 136
        Width = 761
        Height = 113
        AutoLabel.Kind = albTop
        DataField = 'MUSTERI_SIKAYETI'
        DataSource = dtsFAT_IRS
        TabOrder = 1
        AutoSize = False
      end
      object IB_Memo3: TIB_Memo
        Left = 16
        Top = 272
        Width = 761
        Height = 129
        AutoLabel.Kind = albTop
        DataField = 'SERVIS_NOTU'
        DataSource = dtsFAT_IRS
        TabOrder = 2
        AutoSize = False
      end
    end
  end
  object qryFAT_IRS: TIB_Query
    ColumnAttributes.Strings = (
      'IPTAL=BOOLEAN=1,0'
      'YAZILDI=BOOLEAN=1,0'
      'GARANTI_ISLEMI=BOOLEAN=1,0'
      'EXSPERTIZ_ISLEMI=BOOLEAN=1,0'
      'SOK_PAR_IADE=BOOLEAN=1,0'
      'TESLIM_SAAT=NODATE'
      'GIRIS_SAAT=NODATE'
      'BITIS_SAAT=NODATE')
    DatabaseName = 'c:\CedaLite\Db\Cevresel_2006.FDB'
    FieldsDisplayFormat.Strings = (
      'KDV1=#,##'
      'KDV2=#,##'
      'KDV3=#,##'
      'KDV4=#,##'
      'KDV5=#,##'
      'BRUTTOP=#,##.00'
      'NETTOP=#,##'
      'GENELTOP=#,##'
      'KDVTOP=#,##'
      'INDIRIMTOP=#,##'
      'KALEM_ISKONTO_TOPLAMVBP=#,##.00'
      'FATURA_ISKONTO_TUTARVPB=#,##.00'
      'ISKONTO_TOPLAMIVPB=#,##.00'
      'OTV=#,##'
      'TELEFON=0(###)#######')
    FieldsDisplayLabel.Strings = (
      'FATSERI=Seri No'
      'FATURA_KOD=Kodu'
      'REF_BELGE_TUR=Belge T'#252'r'#252
      'PLASIYER_KOD=Plasiyer Kodu'
      'VADE_TARIH=Vade Tarihi'
      'VADE_GUN=Vade G'#252'n'
      'TARIH='#304#351'lem Tarih'
      'FATURA_TIP=Fatura Tipi'
      'ACIKLAMA=A'#231#305'klama'
      'FATURA_ISKONTO_ORAN='#304'skonto Oran'
      'FATURA_ISKONTO_TUTARVPB='#304'skonto Tutar'
      'FIILI_TAR=Fiili Tarih'
      'DOV_BAZ_TAR=D'#246'v Baz Tarih'
      'OTV='#214'TV'
      'DEPO_KOD=Depo Kodu'
      'DEPO_AD=Depo Ad'
      'PLASIYER_AD=Plasiyer Ad'
      'KASA_KOD=Kasa Kodu'
      'KASA_AD=Kasa Ad'#305
      'CARI_KOD=Cari Kodu'
      'PROJE_KOD=Proje Kodu'
      'PROJE_AD=Proje Ad'#305
      'YEV_ACIKLAMA=Yevmiye ACK'
      'FAT_IRS_ID=Fi'#351' No'
      'TIP=Tipi'
      'ISKONTO_ORAN='#304'skonto Oran'
      'ISKONTO_TUTAR_VPB='#304'skonto Tutar VPB'
      'FAT_IRS_TIP=Tipi'
      'SEVK_ADRES_KOD=Sevk Adresi'
      'ONARIM_ID=Fi'#351' No'
      'ARAC_KODU=Ara'#231' Kodu'
      'ARAC_PLAKA=Ara'#231' Plaka'
      'GELIS_NEDENI=Geli'#351' Nedeni'
      'GIRIS_KM=Giri'#351' Km'
      'ONCEKI_KM='#214'nceki Km'
      'ODEME_SEKLI='#214'deme '#350'ekli'
      'YAKIT_SEVIYESI=Yak'#305't Seviyesi'
      'GARANTI_ISLEMI=Garanti '#304#351'lemi Var'
      'EXSPERTIZ_ISLEMI=Expertiz '#304#351'lemi Var'
      'SOK_PAR_IADE=S'#246'k'#252'len Par'#231'a '#304'ade'
      'TESLIM_EDEN=Teslim Eden'
      'ALACAK_OLAN=Alacak Olan'
      'TELEFON=Telefon'
      'SIGORTA_KOD=Sigorta Kod'
      'TESLIM_TAR=Teslim Tarihi'
      'TESLIM_SAAT=Teslim Saati'
      'TAHMINI_PARCA_TUTAR=Tahmini Par'#231'a Tutar'
      'TAHMINI_ISCILIK_TUTAR=Tahmini '#304#351#231'ilik Tutar'
      'GIRIS_TARIH=Giri'#351' Tarihi'
      'GIRIS_SAAT=Giri'#351' Saati'
      'ONARIM_ISTEKLERI=Onar'#305'm '#304'stekleri'
      'MUSTERI_SIKAYETI=M'#252#351'teri '#350'ikayeti'
      'SERVIS_NOTU=Servis Notu'
      'BRUT_TOP=B'#252'r'#252't Toplam'
      'NET_TOP=Net Toplam'
      'GENEL_TOP=Genel Toplam'
      'KDV_TOP=Kdv Toplam'#305
      'SAAT=Saat'
      'CARI_ADI=Cari Ad'#305
      'KABUL_EDEN_PERS=Kabul Eden'
      'PERSONEL_ADI=Personel Ad'#305
      'GELIS_NEDENI_KOD=Geli'#351' Nedeni'
      'BITIS_TARIHI=Biti'#351' Tarihi'
      'BITIS_SAAT=Biti'#351' Saati')
    FieldsEditMask.Strings = (
      'TELEFON=0(###)#######')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    SQL.Strings = (
      'SELECT ONARIM_ID'
      '     , ONARIM_SID'
      '     , ARAC_KODU'
      
        '     ,(SELECT PLAKA FROM SRV_ARAC WHERE SRV_ARAC_ONARIM.ARAC_KOD' +
        'U=SRV_ARAC.ARAC_KOD) AS ARAC_PLAKA'
      '     , GELIS_NEDENI'
      '     , GIRIS_KM'
      '     , ONCEKI_KM'
      '     , ODEME_SEKLI'
      '     , YAKIT_SEVIYESI'
      '     , GARANTI_ISLEMI'
      '     , EXSPERTIZ_ISLEMI'
      '     , SOK_PAR_IADE'
      '     , TESLIM_EDEN'
      '     , ALACAK_OLAN'
      '     , TELEFON'
      '     , SIGORTA_KOD'
      '     , TESLIM_TAR'
      '     , TESLIM_SAAT'
      '     , TAHMINI_PARCA_TUTAR'
      '     , TAHMINI_ISCILIK_TUTAR'
      '     , GIRIS_TARIH'
      '     , GIRIS_SAAT'
      '     , ONARIM_ISTEKLERI'
      '     , MUSTERI_SIKAYETI'
      '     , SERVIS_NOTU'
      '     , YAZILDI'
      '     , ACIKLAMA'
      '     , BRUT_TOP'
      '     , NET_TOP'
      '     , GENEL_TOP'
      '     , KDV_TOP'
      '     , DEPO_KOD'
      '     , SAAT'
      '     , KALEM_ISKONTO_TOPLAM_VPB'
      '     , ISKONTO_TIP'
      '     , ISKONTO_ORAN'
      '     , ISKONTO_TUTAR_VPB'
      '     , ISKONTO_TOPLAM_VPB'
      '     , KDV1'
      '     , KDV2'
      '     , KDV3'
      '     , KDV4'
      '     , KDV5'
      '     , OTV'
      '     , VADE_GUN'
      '     , VADE_TARIH'
      '     , KDV1_ORAN'
      '     , KDV2_ORAN'
      '     , KDV3_ORAN'
      '     , KDV4_ORAN'
      '     , KDV5_ORAN'
      '     , ODEMETAR'
      '     , PROJE_KOD'
      
        '     , (Select PROJE.PROJE_AD From PROJE Where PROJE.PROJE_KOD=S' +
        'RV_ARAC_ONARIM.PROJE_KOD) As PROJE_AD'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , SECIM'
      '     , KAPANDI'
      '     , SEVK_ADRES_KOD'
      '     , CARI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SRV_ARAC_ONA' +
        'RIM.CARI_KOD) AS CARI_ADI'
      '     , BITIS_TARIHI'
      '     , BITIS_SAAT'
      '     , IPTAL'
      '     , GELIS_NEDENI_KOD'
      
        '     ,(SELECT ACIKLAMA FROM SRV_GELIS_NEDENI WHERE SRV_GELIS_NED' +
        'ENI.NEDEN_KOD=SRV_ARAC_ONARIM.GELIS_NEDENI_KOD) AS NEDEN_ACIKLAM' +
        'A'
      '     , KABUL_EDEN_PERS'
      
        '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_K' +
        'OD=SRV_ARAC_ONARIM.KABUL_EDEN_PERS) AS PERSONEL_ADI'
      '     , MALZEME_FIYATI'
      '     , ISCILIK_FIYATI'
      '     , DIAGNOSTIK_FIYATI'
      'FROM SRV_ARAC_ONARIM'
      'WHERE ONARIM_ID=:PRM_ONARIM_ID and  ONARIM_SID=:PRM_ONARIM_SID')
    ColorScheme = False
    DefaultValues.Strings = (
      'ONARIM_ID=0'
      'TAHMINI_PARCA_TUTAR=0'
      'TAHMINI_ISCILIK_TUTAR=0'
      'BRUT_TOP=0'
      'NET_TOP=0'
      'GENEL_TOP=0'
      'KDV_TOP=0'
      'KALEM_ISKONTO_TOPLAM_VPB=0'
      'ISKONTO_TUTAR_VPB=0'
      'ISKONTO_TOPLAM_VPB=0'
      'KDV1=0'
      'KDV2=0'
      'KDV3=0'
      'KDV4=0'
      'KDV5=0'
      'OTV=0')
    KeyLinks.Strings = (
      'SRV_ARAC_ONARIM.ONARIM_ID'
      'SRV_ARAC_ONARIM.ONARIM_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryFAT_IRSAfterInsert
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 148
    Top = 268
    ParamValues = (
      'PRM_ONARIM_ID=0')
  end
  object trnFAT_IRS: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 492
    Top = 258
  end
  object dtsFAT_IRS: TIB_DataSource
    AutoInsert = False
    Dataset = qryFAT_IRS
    OnDataChange = dtsFAT_IRSDataChange
    OnStateChanged = dtsFAT_IRSStateChanged
    Left = 150
    Top = 318
  end
  object qryURUNHAR: TIB_Query
    DatabaseName = 'c:\CedaLite\Db\Cevresel_2006.FDB'
    FieldsDisplayFormat.Strings = (
      'MIKTAR=#,##.00'
      'TUTARDOV=#,##.00'
      'TUTARVPB=#,##.00'
      'DOVKUR=#,##.00'
      'ISKONTO_TUTAR=#,##.00'
      'ISKONTO_TUTAR_VPB=#,##.00'
      'BIRIMFIY=#,##.00'
      'KDV_TUTAR=#,##.00')
    FieldsDisplayLabel.Strings = (
      'ACIKLAMA=Ac'#305'klama'
      'URUN_KOD='#220'r'#252'n Kodu'
      'URUN_AD='#220'r'#252'n Ad'#305
      'OLCUBIRIM='#214'l'#231#252' Birimi'
      'MIKTAR=Miktar'
      'BIRIMFIY=Birim Fiyat'
      'DOVKOD=Para Birimi'
      'DOVKUR=D'#246'viz Kuru'
      'TUTARDOV=Tutar'
      'TUTARVPB=Tutar VPB'
      'TARIH=Tarih'
      'DEPO_KOD=Depo Kodu'
      'DEPO_AD=Depo Ad'#305
      'KDV=KDV'
      'ISKONTO_ORAN= '#304's. Oran'
      'ISKONTO_TUTAR='#304's.Tutar'
      'ISKONTO_TUTAR_VPB='#304'skonto Tutar VPB'
      'ISKONTO_TIP='#304'skonto Tip'
      'KDV_TUTAR=KDV Tutar'
      'BIRIM_FIY=Birim Fiyat'
      'TUTAR=Tutar'
      'TUTAR_VPB=Tutar VPB')
    FieldsDisplayWidth.Strings = (
      'URUN_KOD=83'
      'BIRIMFIY=86'
      'DOVKOD=55'
      'MIKTAR=45'
      'OLCUBIRIM=56'
      'TUTARDOV=92'
      'TUTARVPB=107'
      'ACIKLAMA=182'
      'KDV_TUTAR=71'
      'BIRIM_FIY=74'
      'TUTAR=114'
      'TUTAR_VPB=118')
    FieldsIndex.Strings = (
      'FATURA_ID'
      'FATURA_SID'
      'URUN_KOD'
      'ACIKLAMA'
      'BIRIM_FIY'
      'DOVKOD'
      'MIKTAR'
      'OLCUBIRIM'
      'URUN_AD'
      'DOVKUR'
      'TARIH'
      'DEPO_KOD'
      'DEPO_AD'
      'KDV'
      'ISKONTO_ORAN'
      'ISKONTO_TUTAR'
      'ISKONTO_TUTAR_VPB'
      'ISKONTO_TIP'
      'URUNHAR_ID'
      'URUNHAR_SID'
      'FIILI_TAR'
      'DOV_BAZ_TAR'
      'TIP'
      'BELGE_TUR'
      'BELGE_ID'
      'BELGE_SID'
      'BELGE_SIRA_NO'
      'OLCUBIRIM_URN_OB'
      'MIKTAR_URN_OB'
      'TUTAR'
      'TUTAR_VPB'
      'URUN_DOVKOD'
      'TUTAR_URUN_DOVKOD'
      'BIRIM_FIY_VPB'
      'BIRIM_FIY_URN_DOVKOD'
      'IRSALIYE_ID'
      'IRSALIYE_SID'
      'MASRAF_MERK'
      'KDV_TUTAR'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4')
    FieldsVisible.Strings = (
      'FATURA_D_ID=FALSE'
      'FATURA_D_SID=FALSE'
      'FATURA_ID=FALSE'
      'FATURA_SID=FALSE'
      'URUN_AD=FALSE'
      'DOVKUR=FALSE'
      'TARIH=FALSE'
      'REF_BELGE_ID=FALSE'
      'REF_BELGE_TUR=FALSE'
      'DEPO_KOD=FALSE'
      'DEPO_AD=FALSE'
      'KDV=FALSE'
      'ISKONTO_ORAN=FALSE'
      'ISKONTO_TUTAR=FALSE'
      'ISKONTO_TUTAR_VPB=FALSE'
      'ISKONTO_TIP=FALSE'
      'SIRA_NO=FALSE'
      'KDV_TUTAR=FALSE'
      'KOD4=FALSE'
      'KOD3=FALSE'
      'KOD2=FALSE'
      'KOD1=FALSE'
      'MASRAF_MERK=FALSE'
      'IRSALIYE_SID=FALSE'
      'IRSALIYE_ID=FALSE'
      'BIRIM_FIY_URN_DOVKOD=FALSE'
      'BIRIM_FIY_VPB=FALSE'
      'BIRIM_FIY=TRUE'
      'TUTAR_URUN_DOVKOD=FALSE'
      'URUN_DOVKOD=FALSE'
      'MIKTAR_URN_OB=FALSE'
      'OLCUBIRIM_URN_OB=FALSE'
      'BELGE_SIRA_NO=FALSE'
      'BELGE_SID=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_TUR=FALSE'
      'TIP=FALSE'
      'DOV_BAZ_TAR=FALSE'
      'FIILI_TAR=FALSE'
      'URUNHAR_SID=FALSE'
      'URUNHAR_ID=FALSE'
      'BIRIM_FIY_URN_OB=FALSE'
      'SECIM=FALSE'
      'CIKIS_MIKTAR=FALSE'
      'FAT_IRS_SEP=FALSE'
      'AKTARILAN_MIKTAR=FALSE'
      'KAPANDI=FALSE'
      'FATURA_URUN_HAR_ID=FALSE'
      'ONARIM_ID=FALSE'
      'ONARIM_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    SQL.Strings = (
      'SELECT URUNHAR_ID'
      '     , URUNHAR_SID'
      '     , TARIH'
      '     , FIILI_TAR'
      '     , DOV_BAZ_TAR'
      '     , URUN_KOD'
      
        '     , (SELECT  URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD=SRV_A' +
        'RAC_ONARIM_D.URUN_KOD) AS URUN_AD'
      '     , ACIKLAMA'
      '     , TIP'
      '     , BELGE_TUR'
      '     , BELGE_ID'
      '     , BELGE_SID'
      '     , BELGE_SIRA_NO'
      '     , OLCUBIRIM'
      '     , OLCUBIRIM_URN_OB'
      '     , MIKTAR'
      '     , MIKTAR_URN_OB'
      '     , DOVKOD'
      '     , DOVKUR'
      '     , TUTAR'
      '     , TUTAR_VPB'
      '     , URUN_DOVKOD'
      '     , TUTAR_URUN_DOVKOD'
      '     , BIRIM_FIY'
      '     , BIRIM_FIY_VPB'
      '     , BIRIM_FIY_URN_DOVKOD'
      '     , ISKONTO_TIP'
      '     , ISKONTO_ORAN'
      '     , ISKONTO_TUTAR'
      '     , ISKONTO_TUTAR_VPB'
      '     , DEPO_KOD'
      
        '     , (SELECT DEPO.ADI FROM DEPO WHERE DEPO.DEPO_KOD = SRV_ARAC' +
        '_ONARIM_D.DEPO_KOD) AS DEPO_AD'
      '     , ONARIM_ID'
      '     , ONARIM_SID'
      '     , FATURA_ID'
      '     , FATURA_SID'
      '     , IRSALIYE_ID'
      '     , IRSALIYE_SID'
      '     , MASRAF_MERK'
      '     , KDV'
      '     , KDV_TUTAR'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , SECIM'
      '     , FAT_IRS_SEP'
      '     , AKTARILAN_MIKTAR'
      '     , KAPANDI'
      '     , FATURA_URUN_HAR_ID'
      'FROM SRV_ARAC_ONARIM_D'
      'WHERE ONARIM_ID=:PRM_ONARIM_ID And ONARIM_SID=:PRM_ONARIM_SID'
      'ORDER BY URUNHAR_ID;')
    ColorScheme = False
    DefaultValues.Strings = (
      'FATURA_ID=0'
      'BIRIM_FIY=0'
      'DOVKOD=YTL'
      'MIKTAR=0'
      'DOVKUR=0'
      'ISKONTO_TUTAR=0'
      'ISKONTO_TUTAR_VPB=0'
      'URUNHAR_ID=0'
      'BELGE_TUR=0'
      'BELGE_ID=0'
      'MIKTAR_URN_OB=0'
      'TUTAR=0'
      'TUTAR_VPB=0'
      'URUN_DOVKOD=YTL'
      'TUTAR_URUN_DOVKOD=0'
      'BIRIM_FIY_VPB=0'
      'BIRIM_FIY_URN_DOVKOD=0'
      'IRSALIYE_ID=0'
      'KDV_TUTAR=0'
      'ONARIM_ID=0')
    KeyLinks.Strings = (
      'SRV_ARAC_ONARIM_D.URUNHAR_ID'
      'SRV_ARAC_ONARIM_D.URUNHAR_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterDelete = qryURUNHARAfterDelete
    AfterInsert = qryURUNHARAfterInsert
    AfterPost = qryURUNHARAfterPost
    BeforeEdit = qryURUNHARBeforeEdit
    BeforePost = qryURUNHARBeforePost
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 222
    Top = 228
    ParamValues = (
      'PRM_ONARIM_ID=0')
  end
  object dtsURUNHAR: TIB_DataSource
    AutoInsert = False
    Dataset = qryURUNHAR
    OnDataChange = dtsURUNHARDataChange
    OnStateChanged = dtsURUNHARStateChanged
    Left = 228
    Top = 320
  end
  object qry_Temp: TIB_Query
    DatabaseName = 'c:\CedaLite\Db\Cevresel_2006.FDB'
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 410
    Top = 258
  end
  object frxIBODts_Onarim_fis: TfrxIBODataset
    UserName = 'frxIBODts_Onarim_fis'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ONARIM_ID=ONARIM_ID'
      'ONARIM_SID=ONARIM_SID'
      'ARAC_KODU=ARAC_KODU'
      'ARAC_PLAKA=ARAC_PLAKA'
      'ARAC_SASI_NO=ARAC_SASI_NO'
      'ARAC_MARKA_TIP=ARAC_MARKA_TIP'
      'GELIS_NEDENI=GELIS_NEDENI'
      'GIRIS_KM=GIRIS_KM'
      'ONCEKI_KM=ONCEKI_KM'
      'ODEME_SEKLI=ODEME_SEKLI'
      'YAKIT_SEVIYESI=YAKIT_SEVIYESI'
      'GARANTI_ISLEMI=GARANTI_ISLEMI'
      'EXSPERTIZ_ISLEMI=EXSPERTIZ_ISLEMI'
      'SOK_PAR_IADE=SOK_PAR_IADE'
      'TESLIM_EDEN=TESLIM_EDEN'
      'ALACAK_OLAN=ALACAK_OLAN'
      'TELEFON=TELEFON'
      'SIGORTA_KOD=SIGORTA_KOD'
      'TESLIM_TAR=TESLIM_TAR'
      'TESLIM_SAAT=TESLIM_SAAT'
      'TAHMINI_PARCA_TUTAR=TAHMINI_PARCA_TUTAR'
      'TAHMINI_ISCILIK_TUTAR=TAHMINI_ISCILIK_TUTAR'
      'GIRIS_TARIH=GIRIS_TARIH'
      'GIRIS_SAAT=GIRIS_SAAT'
      'ONARIM_ISTEKLERI=ONARIM_ISTEKLERI'
      'MUSTERI_SIKAYETI=MUSTERI_SIKAYETI'
      'SERVIS_NOTU=SERVIS_NOTU'
      'YAZILDI=YAZILDI'
      'ACIKLAMA=ACIKLAMA'
      'BRUT_TOP=BRUT_TOP'
      'NET_TOP=NET_TOP'
      'GENEL_TOP=GENEL_TOP'
      'KDV_TOP=KDV_TOP'
      'DEPO_KOD=DEPO_KOD'
      'SAAT=SAAT'
      'KALEM_ISKONTO_TOPLAM_VPB=KALEM_ISKONTO_TOPLAM_VPB'
      'ISKONTO_TIP=ISKONTO_TIP'
      'ISKONTO_ORAN=ISKONTO_ORAN'
      'ISKONTO_TUTAR_VPB=ISKONTO_TUTAR_VPB'
      'ISKONTO_TOPLAM_VPB=ISKONTO_TOPLAM_VPB'
      'KDV1=KDV1'
      'KDV2=KDV2'
      'KDV3=KDV3'
      'KDV4=KDV4'
      'KDV5=KDV5'
      'OTV=OTV'
      'VADE_GUN=VADE_GUN'
      'VADE_TARIH=VADE_TARIH'
      'KDV1_ORAN=KDV1_ORAN'
      'KDV2_ORAN=KDV2_ORAN'
      'KDV3_ORAN=KDV3_ORAN'
      'KDV4_ORAN=KDV4_ORAN'
      'KDV5_ORAN=KDV5_ORAN'
      'ODEMETAR=ODEMETAR'
      'PROJE_KOD=PROJE_KOD'
      'PROJE_AD=PROJE_AD'
      'MASRAF_MERK=MASRAF_MERK'
      'KOD1=KOD1'
      'KOD2=KOD2'
      'KOD3=KOD3'
      'KOD4=KOD4'
      'SECIM=SECIM'
      'KAPANDI=KAPANDI'
      'SEVK_ADRES_KOD=SEVK_ADRES_KOD'
      'CARI_KOD=CARI_KOD'
      'CARI_ADI=CARI_ADI'
      'VERDAIRE=VERDAIRE'
      'VERNO=VERNO'
      'ADRES1=ADRES1'
      'TEL_NO_1=TEL_NO_1'
      'GELIS_NEDENI_KOD=GELIS_NEDENI_KOD'
      'NEDEN_ACIKLAMA=NEDEN_ACIKLAMA'
      'KABUL_EDEN_PERS=KABUL_EDEN_PERS'
      'PERSONEL_ADI=PERSONEL_ADI'
      'FATURA_TARIHI=FATURA_TARIHI'
      'FATURA_NO=FATURA_NO'
      'MALZEME_FIYATI=MALZEME_FIYATI'
      'ISCILIK_FIYATI=ISCILIK_FIYATI'
      'DIAGNOSTIK_FIYATI=DIAGNOSTIK_FIYATI'
      'URUNHAR_ID=URUNHAR_ID'
      'URUNHAR_SID=URUNHAR_SID'
      'TARIH=TARIH'
      'FIILI_TAR=FIILI_TAR'
      'DOV_BAZ_TAR=DOV_BAZ_TAR'
      'URUN_KOD=URUN_KOD'
      'URUN_AD=URUN_AD'
      'ACIKLAMA_DETAY=ACIKLAMA_DETAY'
      'TIP=TIP'
      'BELGE_TUR=BELGE_TUR'
      'BELGE_ID=BELGE_ID'
      'BELGE_SID=BELGE_SID'
      'BELGE_SIRA_NO=BELGE_SIRA_NO'
      'OLCUBIRIM=OLCUBIRIM'
      'OLCUBIRIM_URN_OB=OLCUBIRIM_URN_OB'
      'MIKTAR=MIKTAR'
      'MIKTAR_URN_OB=MIKTAR_URN_OB'
      'DOVKOD=DOVKOD'
      'DOVKUR=DOVKUR'
      'TUTAR=TUTAR'
      'TUTAR_VPB=TUTAR_VPB'
      'URUN_DOVKOD=URUN_DOVKOD'
      'TUTAR_URUN_DOVKOD=TUTAR_URUN_DOVKOD'
      'BIRIM_FIY=BIRIM_FIY'
      'BIRIM_FIY_VPB=BIRIM_FIY_VPB'
      'BIRIM_FIY_URN_DOVKOD=BIRIM_FIY_URN_DOVKOD'
      'ISKONTO_TIP=ISKONTO_TIP'
      'ISKONTO_ORAN=ISKONTO_ORAN'
      'ISKONTO_TUTAR=ISKONTO_TUTAR'
      'ISKONTO_TUTAR_VPB=ISKONTO_TUTAR_VPB'
      'DEPO_KOD=DEPO_KOD'
      'DEPO_AD=DEPO_AD'
      'ONARIM_ID=ONARIM_ID'
      'ONARIM_SID=ONARIM_SID'
      'FATURA_ID=FATURA_ID'
      'FATURA_SID=FATURA_SID'
      'IRSALIYE_ID=IRSALIYE_ID'
      'IRSALIYE_SID=IRSALIYE_SID'
      'MASRAF_MERK=MASRAF_MERK'
      'KDV=KDV'
      'KDV_TUTAR=KDV_TUTAR'
      'KOD1=KOD1'
      'KOD2=KOD2'
      'KOD3=KOD3'
      'KOD4=KOD4'
      'SECIM=SECIM'
      'FAT_IRS_SEP=FAT_IRS_SEP'
      'AKTARILAN_MIKTAR=AKTARILAN_MIKTAR'
      'KAPANDI=KAPANDI'
      'FATURA_URUN_HAR_ID=FATURA_URUN_HAR_ID')
    DataSet = IB_Query1
    Left = 432
    Top = 41
  end
  object frxReport1: TfrxReport
    Version = '4.3'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39176.428120289400000000
    ReportOptions.LastChange = 39178.679205358800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    OnAfterPrintReport = frxReport1AfterPrintReport
    Left = 368
    Top = 41
  end
  object IB_Query1: TIB_Query
    DatabaseName = 'c:\CedaLite\Db\Cevresel_2006.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT O.ONARIM_ID'
      '     , O.ONARIM_SID'
      '     , O.ARAC_KODU'
      
        '     ,(SELECT PLAKA FROM SRV_ARAC WHERE SRV_ARAC_ONARIM.ARAC_KOD' +
        'U=SRV_ARAC.ARAC_KOD) AS ARAC_PLAKA'
      
        '     ,(SELECT SASI_NO FROM SRV_ARAC WHERE SRV_ARAC_ONARIM.ARAC_K' +
        'ODU=SRV_ARAC.ARAC_KOD) AS ARAC_SASI_NO'
      
        '     ,(SELECT ARAC_MARKA_TIP FROM SRV_ARAC WHERE SRV_ARAC_ONARIM' +
        '.ARAC_KODU=SRV_ARAC.ARAC_KOD) AS ARAC_MARKA_TIP'
      '     , O.GELIS_NEDENI'
      '     , O.GIRIS_KM'
      '     , O.ONCEKI_KM'
      '     , O.ODEME_SEKLI'
      '     , O.YAKIT_SEVIYESI'
      '     , O.GARANTI_ISLEMI'
      '     , O.EXSPERTIZ_ISLEMI'
      '     , O.SOK_PAR_IADE'
      '     , O.TESLIM_EDEN'
      '     , O.ALACAK_OLAN'
      '     , O.TELEFON'
      '     , O.SIGORTA_KOD'
      '     , O.TESLIM_TAR'
      '     , O.TESLIM_SAAT'
      '     , O.TAHMINI_PARCA_TUTAR'
      '     , O.TAHMINI_ISCILIK_TUTAR'
      '     , O.GIRIS_TARIH'
      '     , O.GIRIS_SAAT'
      '     , O.ONARIM_ISTEKLERI'
      '     , O.MUSTERI_SIKAYETI'
      '     , O.SERVIS_NOTU'
      '     , O.YAZILDI'
      '     , O.ACIKLAMA'
      '     , O.BRUT_TOP'
      '     , O.NET_TOP'
      '     , O.GENEL_TOP'
      '     , O.KDV_TOP'
      '     , O.DEPO_KOD'
      '     , O.SAAT'
      '     , O.KALEM_ISKONTO_TOPLAM_VPB'
      '     , O.ISKONTO_TIP'
      '     , O.ISKONTO_ORAN'
      '     , O.ISKONTO_TUTAR_VPB'
      '     , O.ISKONTO_TOPLAM_VPB'
      '     , O.KDV1'
      '     , O.KDV2'
      '     , O.KDV3'
      '     , O.KDV4'
      '     , O.KDV5'
      '     , O.OTV'
      '     , O.VADE_GUN'
      '     , O.VADE_TARIH'
      '     , O.KDV1_ORAN'
      '     , O.KDV2_ORAN'
      '     , O.KDV3_ORAN'
      '     , O.KDV4_ORAN'
      '     , O.KDV5_ORAN'
      '     , O.ODEMETAR'
      '     , O.PROJE_KOD'
      
        '     , (Select PROJE.PROJE_AD From PROJE Where PROJE.PROJE_KOD=S' +
        'RV_ARAC_ONARIM.PROJE_KOD) As PROJE_AD'
      '     , O.MASRAF_MERK'
      '     , O.KOD1'
      '     , O.KOD2'
      '     , O.KOD3'
      '     , O.KOD4'
      '     , O.SECIM'
      '     , O.KAPANDI'
      '     , O.SEVK_ADRES_KOD'
      '     , O.CARI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SRV_ARAC_ONA' +
        'RIM.CARI_KOD) AS CARI_ADI'
      
        '     ,(SELECT VERDAIRE FROM CARI WHERE CARI.CARI_KOD=SRV_ARAC_ON' +
        'ARIM.CARI_KOD) AS VERDAIRE'
      
        '     ,(SELECT VERNO FROM CARI WHERE CARI.CARI_KOD=SRV_ARAC_ONARI' +
        'M.CARI_KOD) AS VERNO'
      
        '     ,(SELECT ADRES_1 FROM CARI WHERE CARI.CARI_KOD=SRV_ARAC_ONA' +
        'RIM.CARI_KOD) AS ADRES1'
      
        '     ,(SELECT TEL_NO_1 FROM CARI WHERE CARI.CARI_KOD=SRV_ARAC_ON' +
        'ARIM.CARI_KOD) AS TEL_NO_1'
      ''
      '     , O.GELIS_NEDENI_KOD'
      
        '     ,(SELECT ACIKLAMA FROM SRV_GELIS_NEDENI WHERE SRV_GELIS_NED' +
        'ENI.NEDEN_KOD=SRV_ARAC_ONARIM.GELIS_NEDENI_KOD) AS NEDEN_ACIKLAM' +
        'A'
      '     , O.KABUL_EDEN_PERS'
      
        '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_K' +
        'OD=SRV_ARAC_ONARIM.KABUL_EDEN_PERS) AS PERSONEL_ADI'
      '     , O.FATURA_TARIHI'
      '     , O.FATURA_NO  '
      '     , O.MALZEME_FIYATI  '
      '     , O.ISCILIK_FIYATI  '
      '     , O.DIAGNOSTIK_FIYATI  '
      ''
      ''
      '     , OD.URUNHAR_ID'
      '     , OD.URUNHAR_SID'
      '     , OD.TARIH'
      '     , OD.FIILI_TAR'
      '     , OD.DOV_BAZ_TAR'
      '     , OD.URUN_KOD'
      
        '     , (SELECT  URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD=SRV_A' +
        'RAC_ONARIM_D.URUN_KOD) AS URUN_AD'
      '     , OD.ACIKLAMA ACIKLAMA_DETAY'
      '     , OD.TIP'
      '     , OD.BELGE_TUR'
      '     , OD.BELGE_ID'
      '     , OD.BELGE_SID'
      '     , OD.BELGE_SIRA_NO'
      '     , OD.OLCUBIRIM'
      '     , OD.OLCUBIRIM_URN_OB'
      '     , OD.MIKTAR'
      '     , OD.MIKTAR_URN_OB'
      '     , OD.DOVKOD'
      '     , OD.DOVKUR'
      '     , OD.TUTAR'
      '     , OD.TUTAR_VPB'
      '     , OD.URUN_DOVKOD'
      '     , OD.TUTAR_URUN_DOVKOD'
      '     , OD.BIRIM_FIY'
      '     , OD.BIRIM_FIY_VPB'
      '     , OD.BIRIM_FIY_URN_DOVKOD'
      '     , OD.ISKONTO_TIP'
      '     , OD.ISKONTO_ORAN'
      '     , OD.ISKONTO_TUTAR'
      '     , OD.ISKONTO_TUTAR_VPB'
      '     , OD.DEPO_KOD'
      
        '     , (SELECT DEPO.ADI FROM DEPO WHERE DEPO.DEPO_KOD = SRV_ARAC' +
        '_ONARIM_D.DEPO_KOD) AS DEPO_AD'
      '     , OD.ONARIM_ID'
      '     , OD.ONARIM_SID'
      '     , OD.FATURA_ID'
      '     , OD.FATURA_SID'
      '     , OD.IRSALIYE_ID'
      '     , OD.IRSALIYE_SID'
      '     , OD.MASRAF_MERK'
      '     , OD.KDV'
      '     , OD.KDV_TUTAR'
      '     , OD.KOD1'
      '     , OD.KOD2'
      '     , OD.KOD3'
      '     , OD.KOD4'
      '     , OD.SECIM'
      '     , OD.FAT_IRS_SEP'
      '     , OD.AKTARILAN_MIKTAR'
      '     , OD.KAPANDI'
      '     , OD.FATURA_URUN_HAR_ID'
      'FROM SRV_ARAC_ONARIM O'
      
        'INNER JOIN SRV_ARAC_ONARIM_D OD ON (O.ONARIM_ID=OD.ONARIM_ID And' +
        ' O.ONARIM_SID=OD.ONARIM_SID)'
      
        'WHERE O.ONARIM_ID=:PRM_ONARIM_ID and  OD.ONARIM_SID=:PRM_ONARIM_' +
        'SID'
      ''
      'ORDER BY OD.URUNHAR_ID;')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 524
    Top = 43
    ParamValues = (
      'PRM_ONARIM_ID=0')
  end
end
