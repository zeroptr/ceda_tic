object frmArac: TfrmArac
  Left = 194
  Top = 115
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Ara'#231' Tan'#305'mlama'
  ClientHeight = 568
  ClientWidth = 560
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object pgArac: TPageControl
    Left = 0
    Top = 0
    Width = 560
    Height = 568
    ActivePage = TabAracKarti
    Align = alClient
    TabOrder = 0
    OnChange = pgAracChange
    OnChanging = pgAracChanging
    object TabAracKarti: TTabSheet
      Caption = 'Ara'#231' Kart'#305' '
      object IB_Text5: TIB_Text
        Left = 240
        Top = 37
        Width = 310
        Height = 14
        DataField = 'DARAC_PLAKA'
        DataSource = dtsArac
        Color = clMoneyGreen
        ParentColor = False
      end
      object IB_Text1: TIB_Text
        Left = 242
        Top = 149
        Width = 309
        Height = 14
        DataField = 'CARI_ADI'
        DataSource = dtsArac
        Color = clMoneyGreen
        ParentColor = False
      end
      object IB_Text2: TIB_Text
        Left = 242
        Top = 173
        Width = 309
        Height = 14
        DataField = 'PERSONEL_ADI'
        DataSource = dtsArac
        Color = clMoneyGreen
        ParentColor = False
      end
      object Image1: TImage
        Left = 272
        Top = 192
        Width = 105
        Height = 105
        OnDblClick = IB_Image1DblClick
      end
      object IB_Edit1: TIB_Edit
        Left = 80
        Top = 8
        Width = 155
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'ARAC_KOD'
        DataSource = dtsArac
        TabOrder = 0
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        OnKeyPress = IB_Edit1KeyPress
      end
      object IB_Edit7: TIB_Edit
        Left = 272
        Top = 8
        Width = 107
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'PLAKA'
        DataSource = dtsArac
        TabOrder = 1
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        OnKeyPress = IB_Edit1KeyPress
      end
      object IB_Edit9: TIB_Edit
        Left = 80
        Top = 96
        Width = 281
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'ACIKLAMA'
        DataSource = dtsArac
        TabOrder = 5
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_Currency1: TIB_Currency
        Left = 48
        Top = 608
        Width = 119
        Height = 21
        TabStop = False
        AutoLabel.Kind = albLeft
        DataField = 'BORC'
        DataSource = dtsArac
        Enabled = False
        ReadOnly = True
        TabOrder = 12
        AlwaysShowButton = True
      end
      object IB_Currency3: TIB_Currency
        Left = 224
        Top = 608
        Width = 119
        Height = 21
        TabStop = False
        AutoLabel.Kind = albLeft
        DataField = 'ALACAK'
        DataSource = dtsArac
        Enabled = False
        ReadOnly = True
        TabOrder = 13
        AlwaysShowButton = True
      end
      object IB_CheckBox1: TIB_CheckBox
        Left = 80
        Top = 128
        Width = 51
        Height = 13
        DataField = 'OZ_MAL'
        DataSource = dtsArac
        OnClick = IB_CheckBox1Click
        BorderStyle = bsNone
        TabOrder = 6
        Caption = #214'z Mal'
      end
      object cboDOVKOD: TIB_ComboBox
        Left = 80
        Top = 64
        Width = 87
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'ARAC_TIP'
        DataSource = dtsArac
        TabOrder = 4
        Style = csDropDownList
        ItemHeight = 13
        Items.Strings = (
          'Kamyon'
          'T'#305'r'
          'Dorse'
          'Binek'
          'Di'#287'er')
        ItemValues.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4')
      end
      object IB_Date1: TIB_Date
        Left = 80
        Top = 216
        Width = 97
        Height = 21
        TabStop = False
        AutoLabel.Kind = albLeft
        DataField = 'KASKO_SIG_GEC_TAR'
        DataSource = dtsArac
        TabOrder = 9
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_Date2: TIB_Date
        Left = 80
        Top = 248
        Width = 97
        Height = 21
        TabStop = False
        AutoLabel.Kind = albLeft
        DataField = 'TRF_SIG_GEC_TAR'
        DataSource = dtsArac
        TabOrder = 10
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_Currency5: TIB_Currency
        Left = 80
        Top = 280
        Width = 95
        Height = 21
        TabStop = False
        AutoLabel.Kind = albLeft
        DataField = 'YAKIT_LITRE'
        DataSource = dtsArac
        TabOrder = 11
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        AlwaysShowButton = True
      end
      object txtCariKod: TIB_Edit
        Left = 80
        Top = 144
        Width = 155
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'CARI_KOD'
        DataSource = dtsArac
        TabOrder = 7
        OnEnter = txtCariKodEnter
        OnExit = txtCariKodExit
        OnKeyPress = txtCariKodKeyPress
        OnKeyUp = txtCariKodKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtCariKodButtonClick
      end
      object txtPersonel: TIB_Edit
        Left = 80
        Top = 168
        Width = 155
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'PERSONEL_KOD'
        DataSource = dtsArac
        TabOrder = 8
        OnEnter = txtPersonelEnter
        OnExit = txtPersonelExit
        OnKeyPress = txtPersonelKeyPress
        OnKeyUp = txtPersonelKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtPersonelButtonClick
      end
      object IB_CheckBox2: TIB_CheckBox
        Left = 448
        Top = 608
        Width = 69
        Height = 13
        DataField = 'AKTIF_DEGIL'
        DataSource = dtsArac
        BorderStyle = bsNone
        TabOrder = 14
        Caption = 'Aktif De'#287'il'
      end
      object txtDorse: TIB_Edit
        Left = 80
        Top = 32
        Width = 155
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'DORSE_KOD'
        DataSource = dtsArac
        TabOrder = 3
        OnEnter = txtDorseEnter
        OnExit = txtDorseExit
        OnKeyPress = txtCariKodKeyPress
        OnKeyUp = txtDorseKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtDorseButtonClick
      end
      object Panel1: TPanel
        Left = 0
        Top = 510
        Width = 552
        Height = 30
        Align = alBottom
        TabOrder = 15
        object btnCikis: TBitBtn
          Left = 476
          Top = 2
          Width = 61
          Height = 25
          Caption = #199#305'&k'#305#351
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
        object btnAra: TBitBtn
          Left = 413
          Top = 2
          Width = 60
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
        object btnYeni: TBitBtn
          Left = 5
          Top = 3
          Width = 62
          Height = 25
          Caption = 'Yeni (INS)'
          TabOrder = 2
          OnClick = btnYeniClick
          NumGlyphs = 2
        end
        object btnKaydet: TButton
          Left = 69
          Top = 3
          Width = 91
          Height = 25
          Caption = 'Kaydet (CTRL+S)'
          TabOrder = 3
          OnClick = btnKaydetClick
        end
        object btnIPTAL: TButton
          Left = 163
          Top = 3
          Width = 80
          Height = 25
          Caption = #304'ptal(CTRL+P)'
          TabOrder = 4
          OnClick = btnIPTALClick
        end
        object btnSil: TButton
          Left = 244
          Top = 3
          Width = 87
          Height = 25
          Caption = 'Sil (CTRL+DEL)'
          TabOrder = 5
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
          Left = 376
          Top = 3
          Width = 25
          Height = 25
          Caption = '>'
          TabOrder = 7
          OnClick = Btn_SonrakiClick
        end
      end
      object Button1: TButton
        Left = 408
        Top = 192
        Width = 98
        Height = 25
        Caption = 'Resim Se'#231
        TabOrder = 16
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 408
        Top = 232
        Width = 98
        Height = 25
        Caption = 'Resmi Sil'
        TabOrder = 17
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 408
        Top = 272
        Width = 98
        Height = 25
        Caption = 'WebCam Resim Al'
        TabOrder = 18
        Visible = False
        OnClick = Button3Click
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 304
        Width = 537
        Height = 201
        Caption = 'Ara'#231' Sahibi'
        TabOrder = 19
        object Label1: TLabel
          Left = 64
          Top = 64
          Width = 101
          Height = 13
          Caption = 'N'#252'fusa Kay'#305'tl'#305' Oldu'#287'u'
        end
        object IB_Edit4: TIB_Edit
          Left = 64
          Top = 16
          Width = 225
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'AS_ADISOYADI'
          DataSource = dtsArac
          TabOrder = 0
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object IB_Edit5: TIB_Edit
          Left = 64
          Top = 40
          Width = 225
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'AS_DOGUM_YERI'
          DataSource = dtsArac
          TabOrder = 1
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object IB_Edit6: TIB_Edit
          Left = 64
          Top = 80
          Width = 225
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'AS_NUFUS_IL'
          DataSource = dtsArac
          TabOrder = 3
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object IB_Date3: TIB_Date
          Left = 424
          Top = 16
          Width = 108
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'AS_DOGUM_TARIHI'
          DataSource = dtsArac
          TabOrder = 2
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          IncCellHeight = 1
          IncCellWidth = 2
          DrawYearArrow = False
        end
        object IB_Edit8: TIB_Edit
          Left = 64
          Top = 104
          Width = 225
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'AS_NUFUS_ILCE'
          DataSource = dtsArac
          TabOrder = 4
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object IB_Edit10: TIB_Edit
          Left = 424
          Top = 88
          Width = 106
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'AS_SERI_NO'
          DataSource = dtsArac
          TabOrder = 6
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object IB_Date6: TIB_Date
          Left = 424
          Top = 48
          Width = 107
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'AS_MUYANE_GECERLILIK_SUR'
          DataSource = dtsArac
          TabOrder = 5
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          IncCellHeight = 1
          IncCellWidth = 2
          DrawYearArrow = False
        end
        object IB_Edit2: TIB_Edit
          Left = 104
          Top = 128
          Width = 273
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'AS_IKA_ADRES'
          DataSource = dtsArac
          TabOrder = 7
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
        end
        object IB_Edit3: TIB_Edit
          Left = 104
          Top = 152
          Width = 273
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'AS_IKA_ADRES1'
          DataSource = dtsArac
          TabOrder = 8
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
        end
        object IB_Edit24: TIB_Edit
          Left = 104
          Top = 176
          Width = 113
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'AS_TEL1'
          DataSource = dtsArac
          TabOrder = 9
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
        end
        object IB_Edit25: TIB_Edit
          Left = 392
          Top = 176
          Width = 137
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'AS_TEL2'
          DataSource = dtsArac
          TabOrder = 10
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
        end
      end
      object IB_CheckBox9: TIB_CheckBox
        Left = 416
        Top = 8
        Width = 97
        Height = 13
        DataField = 'KARA_LISTE'
        DataSource = dtsArac
        BorderStyle = bsNone
        TabOrder = 2
        Caption = 'Kara Listeye Al'
      end
    end
    object TabRuhsat: TTabSheet
      Caption = 'Ara'#231' Ruhsat'#305'n'#305'n'
      ImageIndex = 1
      object Panel2: TPanel
        Left = 0
        Top = 510
        Width = 552
        Height = 30
        Align = alBottom
        TabOrder = 0
        object Btn_RKaydet: TButton
          Left = 13
          Top = 3
          Width = 91
          Height = 25
          Caption = 'Kaydet (CTRL+S)'
          TabOrder = 0
          OnClick = Btn_RKaydetClick
        end
        object Btn_RIptal: TButton
          Left = 115
          Top = 3
          Width = 80
          Height = 25
          Caption = #304'ptal(CTRL+P)'
          TabOrder = 1
          OnClick = Btn_RIptalClick
        end
        object Btn_RSil: TButton
          Left = 444
          Top = 3
          Width = 87
          Height = 25
          Caption = 'Sil (CTRL+DEL)'
          TabOrder = 2
          OnClick = Btn_RSilClick
        end
      end
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 552
        Height = 510
        Align = alClient
        TabOrder = 1
        object IB_CheckBox3: TIB_CheckBox
          Left = 196
          Top = 232
          Width = 43
          Height = 13
          DataField = 'ARAZI'
          DataSource = dtsAracRuhsat
          BorderStyle = bsNone
          TabOrder = 8
          Caption = 'Arazi'
        end
        object IB_Edit11: TIB_Edit
          Left = 80
          Top = 8
          Width = 158
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'IL'
          DataSource = dtsAracRuhsat
          TabOrder = 0
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object IB_Edit12: TIB_Edit
          Left = 80
          Top = 40
          Width = 158
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ILCE'
          DataSource = dtsAracRuhsat
          TabOrder = 1
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object IB_Date4: TIB_Date
          Left = 80
          Top = 104
          Width = 94
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'TESCIL_TARIHI'
          DataSource = dtsAracRuhsat
          TabOrder = 3
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          IncCellHeight = 1
          IncCellWidth = 2
          DrawYearArrow = False
        end
        object IB_Edit13: TIB_Edit
          Left = 80
          Top = 72
          Width = 158
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'TESCIL_SIRA_NO'
          DataSource = dtsAracRuhsat
          TabOrder = 2
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object IB_Edit14: TIB_Edit
          Left = 80
          Top = 136
          Width = 158
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'PLAKA_NO'
          DataSource = dtsAracRuhsat
          TabOrder = 4
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object IB_Edit15: TIB_Edit
          Left = 80
          Top = 168
          Width = 158
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'MARKASI'
          DataSource = dtsAracRuhsat
          TabOrder = 5
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object IB_Edit16: TIB_Edit
          Left = 80
          Top = 200
          Width = 158
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'MODELI'
          DataSource = dtsAracRuhsat
          TabOrder = 6
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object IB_Edit17: TIB_Edit
          Left = 80
          Top = 232
          Width = 110
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'CINSI'
          DataSource = dtsAracRuhsat
          TabOrder = 7
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object IB_Edit18: TIB_Edit
          Left = 80
          Top = 264
          Width = 158
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'TIPI'
          DataSource = dtsAracRuhsat
          TabOrder = 9
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object IB_Edit19: TIB_Edit
          Left = 80
          Top = 296
          Width = 158
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'RENGI'
          DataSource = dtsAracRuhsat
          TabOrder = 10
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object IB_Edit20: TIB_Edit
          Left = 80
          Top = 320
          Width = 158
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'MOTOR_NO'
          DataSource = dtsAracRuhsat
          TabOrder = 11
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object IB_Edit21: TIB_Edit
          Left = 80
          Top = 352
          Width = 158
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'SASI_NO'
          DataSource = dtsAracRuhsat
          TabOrder = 12
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object IB_Memo2: TIB_Memo
          Left = 9
          Top = 392
          Width = 230
          Height = 49
          AutoLabel.Kind = albTop
          DataField = 'RUHSAT_BILGILERI'
          DataSource = dtsAracRuhsat
          TabOrder = 13
          OnEnter = IB_Memo2Enter
          OnExit = IB_Memo2Exit
          AutoSize = False
        end
        object IB_Currency2: TIB_Currency
          Left = 312
          Top = 16
          Width = 47
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'SILINDIR_HACMI'
          DataSource = dtsAracRuhsat
          TabOrder = 14
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object IB_Currency4: TIB_Currency
          Left = 312
          Top = 48
          Width = 47
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ISTIAP_HADDI'
          DataSource = dtsAracRuhsat
          TabOrder = 16
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object IB_Currency6: TIB_Currency
          Left = 424
          Top = 16
          Width = 47
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'MOTOR_GUCU'
          DataSource = dtsAracRuhsat
          TabOrder = 15
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object IB_Currency7: TIB_Currency
          Left = 424
          Top = 48
          Width = 47
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'KISI'
          DataSource = dtsAracRuhsat
          TabOrder = 17
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object IB_CheckBox4: TIB_CheckBox
          Left = 260
          Top = 88
          Width = 83
          Height = 13
          DataField = 'IMALATCI_YERLI'
          DataSource = dtsAracRuhsat
          BorderStyle = bsNone
          TabOrder = 18
          Caption = #304'malat'#231#305' Yerli'
        end
        object IB_RadioGroup1: TIB_RadioGroup
          Left = 288
          Top = 112
          Width = 71
          Height = 57
          DataField = 'KULLANIM_TIPI'
          DataSource = dtsAracRuhsat
          TabOrder = 19
          Items.Strings = (
            'Ticari'
            'Hususi'
            'Resmi')
          Values.Strings = (
            '1'
            '2'
            '3')
        end
        object IB_RadioGroup2: TIB_RadioGroup
          Left = 416
          Top = 112
          Width = 71
          Height = 57
          DataField = 'YAKIT_TIPI'
          DataSource = dtsAracRuhsat
          TabOrder = 20
          Items.Strings = (
            'Dizel'
            'Benzin'
            'Euro93')
          Values.Strings = (
            '1'
            '2'
            '3')
        end
        object IB_CheckBox5: TIB_CheckBox
          Left = 260
          Top = 184
          Width = 139
          Height = 13
          DataField = 'YUK_TASIMA'
          DataSource = dtsAracRuhsat
          BorderStyle = bsNone
          TabOrder = 21
          Caption = 'Y'#252'k Ta'#351#305'mak '#304#231'in'
        end
        object IB_CheckBox6: TIB_CheckBox
          Left = 260
          Top = 208
          Width = 123
          Height = 13
          DataField = 'ROMORK_TAKMA'
          DataSource = dtsAracRuhsat
          BorderStyle = bsNone
          TabOrder = 22
          Caption = 'R'#246'mork Tak'#305'labilir'
        end
        object IB_CheckBox7: TIB_CheckBox
          Left = 260
          Top = 232
          Width = 107
          Height = 13
          DataField = 'TAKSIMETRE'
          DataSource = dtsAracRuhsat
          BorderStyle = bsNone
          TabOrder = 23
          Caption = 'Taksimetreli'
        end
        object IB_CheckBox8: TIB_CheckBox
          Left = 260
          Top = 256
          Width = 107
          Height = 13
          DataField = 'TAKOMETRE'
          DataSource = dtsAracRuhsat
          BorderStyle = bsNone
          TabOrder = 24
          Caption = 'Takometre Var'
        end
        object IB_Currency8: TIB_Currency
          Left = 352
          Top = 296
          Width = 71
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'NET_AGIRLIK'
          DataSource = dtsAracRuhsat
          TabOrder = 25
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object IB_Currency9: TIB_Currency
          Left = 352
          Top = 320
          Width = 71
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'KATAR_AGIRLIGI'
          DataSource = dtsAracRuhsat
          TabOrder = 26
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object IB_Currency10: TIB_Currency
          Left = 352
          Top = 352
          Width = 71
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ROMORK_ISTIAPHAD'
          DataSource = dtsAracRuhsat
          TabOrder = 27
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object IB_Date5: TIB_Date
          Left = 500
          Top = 260
          Width = 89
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'MUYANE_GECERLILIK_SUR'
          DataSource = dtsAracRuhsat
          Visible = False
          TabOrder = 28
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          IncCellHeight = 1
          IncCellWidth = 2
          DrawYearArrow = False
        end
        object IB_Edit22: TIB_Edit
          Left = 352
          Top = 384
          Width = 155
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ONAYLAYAN_SICIL'
          DataSource = dtsAracRuhsat
          TabOrder = 29
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object IB_Edit23: TIB_Edit
          Left = 352
          Top = 416
          Width = 155
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'SERI_G_NO'
          DataSource = dtsAracRuhsat
          TabOrder = 30
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyPress = IB_Edit1KeyPress
        end
        object GroupBox2: TGroupBox
          Left = 243
          Top = 8
          Width = 0
          Height = 452
          TabOrder = 31
        end
      end
    end
  end
  object qryArac: TIB_Query
    ColumnAttributes.Strings = (
      'OZ_MAL=BOOLEAN=1,0'
      'AKTIF_DEGIL=BOOLEAN=1,0'
      'KARA_LISTE=BOOLEAN=1,0')
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    FieldsDisplayFormat.Strings = (
      'TELNO_1=0(###)#######'
      'TELNO_2=0(###)#######'
      'FAX=0(###)#######'
      'AS_TEL1=0(###)#######'
      'AS_TEL2=0(###)#######')
    FieldsDisplayLabel.Strings = (
      'PLASIYER_KOD=Kodu:'
      'ADISOY=Ad'#305' Soyad'#305' :'
      'FIRMA_ID=Firma Ad'#305' :'
      'TELNO_1=Telefon(1) :'
      'TELNO_2=Telefon(2) :'
      'FAX=Fax :'
      'ADRES_1=Adres (1) :'
      'ADRES_2=Adres (2) :'
      'ILCE='#304'l'#231'e :'
      'SEHIR='#350'ehir :'
      'POSTAKOD=P. Kodu :'
      'EMAIL=E - Mail :'
      'WEBADDR=Web Adresi :'
      'BORC=Borc'
      'ALACAK=Alacak'
      'BORC_VPB=Borc VPB'
      'ALACAK_VPB=Alacak VPB'
      'DOVKOD=Para Birimi'
      'ARAC_KOD=Ara'#231' Kodu'
      'PLAKA=Plaka'
      'ARAC_TIP=Ara'#231' Tipi'
      'OZ_MAL='#214'z Mal'
      'CARI_KOD=Cari Kod'
      'ACIKLAMA=A'#231#305'klama'
      'AKTIF_DEGIL=Aktif De'#287'il'
      'YAKIT_LITRE=Litre/Km De'#287'eri'
      'TRF_SIG_GEC_TAR=Sigorta Ger. Tar.'
      'KASKO_SIG_GEC_TAR=K.Sig.Ge'#231'.Tar.'
      'CARI_ADI=Cari Ad'#305
      'PERSONEL_KOD=Personel Kodu'
      'PERSONEL_ADI=Personel Ad'#305
      'DORSE=Dorse'
      'DARAC_PLAKA=Dorse Plaka'
      'DORSE_KOD=Dorse Kod'
      'AS_ADISOYADI=Ad'#305' Soyad'#305
      'AS_DOGUM_YERI=Do'#287'um Yeri'
      'AS_NUFUS_IL='#304'l'
      'AS_NUFUS_ILCE='#304'l'#231'e'
      'AS_DOGUM_TARIHI=Do'#287'um Tarihi'
      'AS_IKA_ADRES='#304'kametgah Adresi1'
      'AS_SERI_NO=Seri J. No'
      'AS_MUYANE_GECERLILIK_SUR=Muayene Ge'#231'erlilik S'#252'resi'
      'DEVREDEN_BORC=Devreden Borc'
      'DEVREDEN_ALACAK=Devreden Alacak'
      'AS_TEL1=Telefon1 '
      'AS_TEL2=Telefon2'
      'AS_IKA_ADRES1='#304'kametgah Adresi2'
      'KARA_LISTE=Kara Listeye Al')
    FieldsEditMask.Strings = (
      'TELNO_1=0(###)#######'
      'TELNO_2=0(###)#######'
      'FAX=0(###)#######'
      'AS_TEL1=0(###)#######'
      'AS_TEL2=0(###)#######')
    FieldsReadOnly.Strings = (
      'BORC=TRUE'
      'ALACAK=TRUE'
      'BORC_VPB=TRUE'
      'ALACAK_VPB=TRUE')
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
      '     , ACIKLAMA'
      '     , BORC'
      '     , ALACAK'
      '     , AKTIF_DEGIL'
      '     , YAKIT_LITRE'
      '     , TRF_SIG_GEC_TAR'
      '     , KASKO_SIG_GEC_TAR'
      '     , PERSONEL_KOD'
      
        '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_K' +
        'OD=ARAC.PERSONEL_KOD) AS PERSONEL_ADI    '
      '     , DORSE_KOD '
      
        '     ,(SELECT PLAKA FROM ARAC AR WHERE AR.ARAC_KOD=ARAC.DORSE_KO' +
        'D) AS DARAC_PLAKA'
      '     , AS_ADISOYADI'
      '     , AS_DOGUM_YERI'
      '     , AS_NUFUS_IL'
      '     , AS_NUFUS_ILCE'
      '     , AS_DOGUM_TARIHI'
      '     , AS_IKA_ADRES'
      '     , AS_SERI_NO'
      '     , AS_MUYANE_GECERLILIK_SUR'
      '     , DEVREDEN_BORC'
      '     , DEVREDEN_ALACAK'
      '     , RESIM'
      '     , AS_IKA_ADRES1'
      '     , AS_TEL1'
      '     , AS_TEL2'
      '     , KARA_LISTE'
      'FROM ARAC'
      'WHERE ARAC_KOD=:PRM_ARAC_KOD')
    ColorScheme = False
    DefaultValues.Strings = (
      'BORC=0'
      'ALACAK=0')
    KeyLinks.Strings = (
      'ARAC.ARAC_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryAracAfterInsert
    AfterScroll = qryAracAfterScroll
    BeforeDelete = qryAracBeforeDelete
    BeforePost = qryAracBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 436
    Top = 92
    ParamValues = (
      'PRM_ARAC_KOD=')
  end
  object dtsArac: TIB_DataSource
    AutoInsert = False
    Dataset = qryArac
    OnDataChange = dtsAracDataChange
    OnStateChanged = dtsAracStateChanged
    Left = 448
    Top = 128
  end
  object dtsAracRuhsat: TIB_DataSource
    Dataset = QryAracRuhsat
    OnStateChanged = dtsAracRuhsatStateChanged
    Left = 380
    Top = 56
  end
  object QryAracRuhsat: TIB_Query
    ColumnAttributes.Strings = (
      'IMALATCI_YERLI=BOOLEAN=1,0'
      'KULLANIM_TIPI=BOOLEAN=1,0'
      'YAKIT_TIPI=BOOLEAN=1,0'
      'YUK_TASIMA=BOOLEAN=1,0'
      'ROMORK_TAKMA=BOOLEAN=1,0'
      'TAKSIMETRE=BOOLEAN=1,0'
      'TAKOMETRE=BOOLEAN=1,0'
      'ARAZI=BOOLEAN=1,0')
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    FieldsDisplayLabel.Strings = (
      'IL=Verildi'#287'i '#304'l'
      'ILCE='#304'l'#231'e'
      'TESCIL_SIRA_NO=Tescil S'#305'ra No'
      'TESCIL_TARIHI=Tescil Tarihi'
      'PLAKA_NO=Plaka No'
      'MARKASI=Markas'#305
      'MODELI=Modeli'
      'CINSI=Cinsi'
      'ARAZI=Arazi'
      'TIPI=Tipi'
      'RENGI=Rengi'
      'MOTOR_NO=Motor No'
      'SASI_NO='#350'asi No'
      'RUHSAT_BILGILERI=Extra Ruhsat Bilgileri'
      'SILINDIR_HACMI=Silindir Hacmi'
      'MOTOR_GUCU=Motor G'#252'c'#252
      'ISTIAP_HADDI='#304'stiap Haddi'
      'KISI=Ki'#351'i'
      'IMALATCI_YERLI='#304'malat'#231#305' Yerli'
      'KULLANIM_TIPI=Kullan'#305'm Tipi'
      'YAKIT_TIPI=Yak'#305't Tipi'
      'YUK_TASIMA=Y'#252'k Ta'#351#305'mak '#304#231'in'
      'ROMORK_TAKMA=R'#246'mork Tak'#305'labilir'
      'TAKSIMETRE=Taksimetreli'
      'TAKOMETRE=Takometre Var'
      'NET_AGIRLIK=Net A'#287#305'rl'#305'k'
      'KATAR_AGIRLIGI=Katar A'#287#305'rl'#305#287#305
      'ROMORK_ISTIAPHAD=R'#246'mork '#304'stiap Haddi'
      'MUYANE_GECERLILIK_SUR=Muayene Ge'#231'erlilik S'#252'resi'
      'ONAYLAYAN_SICIL=Onaylayan (Sicil)'
      'SERI_G_NO=Seri G.No')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT ARAC_KOD'
      '     , ARAC_SID'
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
      'FROM ARAC_RUHSAT'
      'WHERE ARAC_KOD=:ARAC_KOD')
    ColorScheme = False
    KeyLinks.Strings = (
      'ARAC_RUHSAT.ARAC_KOD'
      'ARAC_RUHSAT.ARAC_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = QryAracRuhsatAfterInsert
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 444
    Top = 56
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 464
    Top = 280
  end
end
