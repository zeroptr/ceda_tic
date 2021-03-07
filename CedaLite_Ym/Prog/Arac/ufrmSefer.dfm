object frmSefer: TfrmSefer
  Left = 229
  Top = 141
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Sefer'
  ClientHeight = 605
  ClientWidth = 651
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
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Pg_Sefer: TPageControl
    Left = 0
    Top = 0
    Width = 651
    Height = 605
    ActivePage = Ts_Sefer
    Align = alClient
    TabOrder = 0
    OnChange = Pg_SeferChange
    OnChanging = Pg_SeferChanging
    ExplicitHeight = 576
    object Ts_Sefer: TTabSheet
      Caption = 'Sefer Bilgileri'
      ExplicitHeight = 548
      object IB_Text2: TIB_Text
        Left = 160
        Top = 87
        Width = 290
        Height = 14
        DataField = 'ALICI_ADI'
        DataSource = dtsSefer
        Color = clMoneyGreen
        ParentColor = False
      end
      object IB_Text4: TIB_Text
        Left = 160
        Top = 119
        Width = 290
        Height = 14
        DataField = 'SATICI_ADI'
        DataSource = dtsSefer
        Color = clMoneyGreen
        ParentColor = False
      end
      object IB_Text5: TIB_Text
        Left = 160
        Top = 151
        Width = 290
        Height = 14
        DataField = 'PERSONEL_ADI'
        DataSource = dtsSefer
        Color = clMoneyGreen
        ParentColor = False
      end
      object IB_Text1: TIB_Text
        Left = 160
        Top = 53
        Width = 290
        Height = 14
        DataField = 'ARAC_PLAKA'
        DataSource = dtsSefer
        Color = clMoneyGreen
        ParentColor = False
      end
      object IB_Text6: TIB_Text
        Left = 856
        Top = 110
        Width = 290
        Height = 14
        DataField = 'DARAC_PLAKA'
        DataSource = dtsSefer
        Color = clMoneyGreen
        Enabled = False
        ParentColor = False
        Visible = False
      end
      object IB_Text10: TIB_Text
        Left = 160
        Top = 357
        Width = 57
        Height = 14
        DataField = 'SATIS_URUN_HAR_ID'
        DataSource = dtsSefer
        Color = clMoneyGreen
        ParentColor = False
        OnDblClick = IB_Text10DblClick
      end
      object IB_Text11: TIB_Text
        Left = 160
        Top = 380
        Width = 57
        Height = 14
        DataField = 'ALIS_URUN_HAR_ID'
        DataSource = dtsSefer
        Color = clMoneyGreen
        ParentColor = False
        OnDblClick = IB_Text10DblClick
      end
      object IB_Text12: TIB_Text
        Left = 160
        Top = 404
        Width = 57
        Height = 14
        DataField = 'BEK_FAT_URUN_HAR_ID'
        DataSource = dtsSefer
        Color = clMoneyGreen
        ParentColor = False
        OnDblClick = IB_Text10DblClick
      end
      object IB_Text13: TIB_Text
        Left = 160
        Top = 428
        Width = 57
        Height = 14
        DataField = 'SBEK_FAT_URUN_HAR_ID'
        DataSource = dtsSefer
        Color = clMoneyGreen
        ParentColor = False
        OnDblClick = IB_Text10DblClick
      end
      object IB_Text14: TIB_Text
        Left = 160
        Top = 449
        Width = 57
        Height = 14
        DataField = 'SEFER_TAKIP_ID'
        DataSource = dtsSefer
        Color = clMoneyGreen
        ParentColor = False
        OnDblClick = IB_Text10DblClick
      end
      object IB_Edit1: TIB_Edit
        Left = 8
        Top = 16
        Width = 60
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'SEFER_ID'
        DataSource = dtsSefer
        Enabled = False
        ReadOnly = True
        TabOrder = 0
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_Date1: TIB_Date
        Left = 454
        Top = 84
        Width = 91
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'BAS_TAR'
        DataSource = dtsSefer
        TabOrder = 13
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_Date2: TIB_Date
        Left = 454
        Top = 152
        Width = 91
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'BIT_TAR'
        DataSource = dtsSefer
        TabOrder = 15
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object txtAliciKod: TIB_Edit
        Left = 8
        Top = 84
        Width = 149
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'ALICI_KOD'
        DataSource = dtsSefer
        TabOrder = 7
        OnEnter = txtAliciKodEnter
        OnExit = txtAliciKodExit
        OnKeyDown = txtAliciKodKeyDown
        OnKeyPress = IB_Edit2KeyPress
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtAliciKodButtonClick
      end
      object txtPERSONEL_KOD: TIB_Edit
        Left = 8
        Top = 148
        Width = 149
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'PERSONEL_KOD'
        DataSource = dtsSefer
        TabOrder = 9
        OnEnter = txtPERSONEL_KODEnter
        OnExit = txtPERSONEL_KODExit
        OnKeyDown = txtPERSONEL_KODKeyDown
        OnKeyPress = txtPERSONEL_KODKeyPress
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtPERSONEL_KODButtonClick
      end
      object IB_Edit5: TIB_Edit
        Left = 320
        Top = 304
        Width = 321
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'SEFER_NOTLARI'
        DataSource = dtsSefer
        TabOrder = 20
        OnEnter = IB_Edit5Enter
        OnExit = IB_Edit1Exit
      end
      object grpRapKod: TGroupBox
        Left = 688
        Top = 237
        Width = 633
        Height = 47
        Enabled = False
        TabOrder = 29
        Visible = False
        object IB_Edit11: TIB_Edit
          Left = 274
          Top = 21
          Width = 81
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD2'
          DataSource = dtsSefer
          TabOrder = 0
          OnEnter = IB_Edit11Enter
          OnExit = IB_Edit11Exit
          OnKeyPress = txtPERSONEL_KODKeyPress
          OnKeyUp = IB_Edit11KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit11ButtonClick
        end
        object IB_Edit12: TIB_Edit
          Left = 407
          Top = 21
          Width = 85
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD3'
          DataSource = dtsSefer
          TabOrder = 1
          OnEnter = IB_Edit12Enter
          OnExit = IB_Edit12Exit
          OnKeyPress = txtPERSONEL_KODKeyPress
          OnKeyUp = IB_Edit12KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit12ButtonClick
        end
        object IB_Edit13: TIB_Edit
          Left = 534
          Top = 21
          Width = 85
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD4'
          DataSource = dtsSefer
          TabOrder = 2
          OnEnter = IB_Edit13Enter
          OnExit = IB_Edit13Exit
          OnKeyPress = txtPERSONEL_KODKeyPress
          OnKeyUp = IB_Edit13KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit13ButtonClick
        end
      end
      object IB_Currency1: TIB_Currency
        Left = 72
        Top = 16
        Width = 82
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'SEFER_SAY'
        DataSource = dtsSefer
        TabOrder = 1
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        AlwaysShowButton = True
      end
      object txtSaticiKod: TIB_Edit
        Left = 8
        Top = 116
        Width = 148
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'SATICI_KOD'
        DataSource = dtsSefer
        TabOrder = 8
        OnEnter = txtSaticiKodEnter
        OnExit = txtSaticiKodExit
        OnKeyDown = txtSaticiKodKeyDown
        OnKeyPress = IB_Edit2KeyPress
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtSaticiKodButtonClick
      end
      object IB_CheckBox1: TIB_CheckBox
        Left = 8
        Top = 381
        Width = 124
        Height = 13
        TabStop = False
        DataField = 'SEFER_ALIS_FAT_ALINDI'
        DataSource = dtsSefer
        Enabled = False
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 23
        Caption = 'Al'#305#351' Faturas'#305' Al'#305'nd'#305
      end
      object IB_CheckBox2: TIB_CheckBox
        Left = 8
        Top = 358
        Width = 124
        Height = 13
        TabStop = False
        DataField = 'SEFER_SATIS_FAT_KESILDI'
        DataSource = dtsSefer
        Enabled = False
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 22
        Caption = 'Sat'#305#351' Faturas'#305' Kesildi'
      end
      object IB_CheckBox3: TIB_CheckBox
        Left = 224
        Top = 330
        Width = 132
        Height = 13
        DataField = 'BEKLEME_FAT_VAR'
        DataSource = dtsSefer
        OnClick = IB_CheckBox3Click
        BorderStyle = bsNone
        TabOrder = 25
        Caption = 'Bekleme Faturas'#305
      end
      object IB_Edit27: TIB_Edit
        Left = 704
        Top = 156
        Width = 149
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'OLCU_TIP'
        DataSource = dtsSefer
        Enabled = False
        Visible = False
        TabOrder = 10
        OnEnter = IB_Edit27Enter
        OnExit = IB_Edit27Exit
        OnKeyPress = IB_Edit27KeyPress
        OnKeyUp = IB_Edit27KeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit27ButtonClick
      end
      object IB_Edit6: TIB_Edit
        Left = 864
        Top = 156
        Width = 142
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'OLCU_BIRIM'
        DataSource = dtsSefer
        Enabled = False
        Visible = False
        TabOrder = 11
        OnEnter = IB_Edit6Enter
        OnExit = IB_Edit6Exit
        OnKeyPress = IB_Edit6KeyPress
        OnKeyUp = IB_Edit6KeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit6ButtonClick
      end
      object txtArac_Kod: TIB_Edit
        Left = 8
        Top = 50
        Width = 149
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'ARAC_KOD'
        DataSource = dtsSefer
        TabOrder = 5
        OnEnter = txtArac_KodEnter
        OnExit = txtArac_KodExit
        OnKeyDown = txtArac_KodKeyDown
        OnKeyPress = txtArac_KodKeyPress
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtArac_KodButtonClick
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 180
        Width = 633
        Height = 51
        Caption = 'Al'#305'c'#305
        TabOrder = 16
        object IB_Currency4: TIB_Currency
          Left = 8
          Top = 24
          Width = 87
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'ALICI_BORC_BIRIM_FIY'
          DataSource = dtsSefer
          TabOrder = 0
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object cboDOVKOD: TIB_ComboBox
          Left = 136
          Top = 24
          Width = 89
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'ALICI_B_DOVKOD'
          DataSource = dtsSefer
          TabOrder = 1
          TabStop = False
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          Style = csDropDownList
          ItemHeight = 13
        end
        object IB_Currency2: TIB_Currency
          Left = 408
          Top = 24
          Width = 87
          Height = 21
          TabStop = False
          AutoLabel.Kind = albTop
          DataField = 'ALICI_BORC'
          DataSource = dtsSefer
          ReadOnly = True
          TabOrder = 3
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object IB_Currency9: TIB_Currency
          Left = 536
          Top = 24
          Width = 87
          Height = 21
          TabStop = False
          AutoLabel.Kind = albTop
          DataField = 'ALICI_BORC_VPB'
          DataSource = dtsSefer
          ReadOnly = True
          TabOrder = 4
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object IB_Date3: TIB_Date
          Left = 280
          Top = 24
          Width = 83
          Height = 21
          TabStop = False
          AutoLabel.Kind = albTop
          DataField = 'ALICI_B_DOV_BAZ_TAR'
          DataSource = dtsSefer
          TabOrder = 2
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          IncCellHeight = 1
          IncCellWidth = 2
          DrawYearArrow = False
        end
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 236
        Width = 633
        Height = 52
        Caption = 'Sat'#305'c'#305
        TabOrder = 17
        object IB_Currency6: TIB_Currency
          Left = 8
          Top = 25
          Width = 87
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'SATICI_ALACAK_BIRIM_FIY'
          DataSource = dtsSefer
          TabOrder = 0
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object cboDOVKOD1: TIB_ComboBox
          Left = 136
          Top = 25
          Width = 89
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'SATICI_A_DOVKOD'
          DataSource = dtsSefer
          TabOrder = 1
          TabStop = False
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          Style = csDropDownList
          ItemHeight = 13
        end
        object IB_Currency5: TIB_Currency
          Left = 408
          Top = 25
          Width = 87
          Height = 21
          TabStop = False
          AutoLabel.Kind = albTop
          DataField = 'SATICI_ALACAK'
          DataSource = dtsSefer
          ReadOnly = True
          TabOrder = 3
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object IB_Currency10: TIB_Currency
          Left = 536
          Top = 25
          Width = 87
          Height = 21
          TabStop = False
          AutoLabel.Kind = albTop
          DataField = 'SATICI_ALACAK_VPB'
          DataSource = dtsSefer
          ReadOnly = True
          TabOrder = 4
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object IB_Date4: TIB_Date
          Left = 280
          Top = 25
          Width = 83
          Height = 21
          TabStop = False
          AutoLabel.Kind = albTop
          DataField = 'SATICI_A_DOV_BAZ_TAR'
          DataSource = dtsSefer
          TabOrder = 2
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          IncCellHeight = 1
          IncCellWidth = 2
          DrawYearArrow = False
        end
      end
      object Cb_Cik_Yer: TIB_ComboBox
        Left = 454
        Top = 50
        Width = 188
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'CIK_YER'
        DataSource = dtsSefer
        TabOrder = 12
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        ItemHeight = 13
      end
      object Cb_Bit_Yer: TIB_ComboBox
        Left = 454
        Top = 118
        Width = 188
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'BIT_YER'
        DataSource = dtsSefer
        TabOrder = 14
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        ItemHeight = 13
      end
      object Cb_Tas_Esya: TIB_ComboBox
        Left = 8
        Top = 304
        Width = 204
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'TASINAN_ESYA'
        DataSource = dtsSefer
        TabOrder = 18
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        ItemHeight = 13
      end
      object GroupBox3: TGroupBox
        Left = 224
        Top = 343
        Width = 417
        Height = 49
        TabOrder = 26
        object IB_Currency7: TIB_Currency
          Left = 9
          Top = 23
          Width = 86
          Height = 21
          TabStop = False
          AutoLabel.Kind = albTop
          DataField = 'BEKLEME_FAT_TUTAR'
          DataSource = dtsSefer
          TabOrder = 0
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object IB_Currency8: TIB_Currency
          Left = 321
          Top = 23
          Width = 86
          Height = 21
          TabStop = False
          AutoLabel.Kind = albTop
          DataField = 'BEKLEME_FAT_VPB'
          DataSource = dtsSefer
          ReadOnly = True
          TabOrder = 3
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object cboDOVKOD2: TIB_ComboBox
          Left = 113
          Top = 23
          Width = 88
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'BEKLEME_FAT_DOV_KOD'
          DataSource = dtsSefer
          TabOrder = 1
          TabStop = False
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          Style = csDropDownList
          ItemHeight = 13
        end
        object IB_Date5: TIB_Date
          Left = 225
          Top = 23
          Width = 82
          Height = 21
          TabStop = False
          AutoLabel.Kind = albTop
          DataField = 'BEKLEME_FAT_DOV_BAZ_TAR'
          DataSource = dtsSefer
          TabOrder = 2
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          IncCellHeight = 1
          IncCellWidth = 2
          DrawYearArrow = False
        end
      end
      object IB_CheckBox4: TIB_CheckBox
        Left = 8
        Top = 336
        Width = 132
        Height = 13
        DataField = 'SEFER_TAMAMLANDI'
        DataSource = dtsSefer
        BorderStyle = bsNone
        TabOrder = 21
        Caption = 'Sefer Tamamland'#305
      end
      object Panel1: TPanel
        Left = 0
        Top = 547
        Width = 643
        Height = 30
        Align = alBottom
        TabOrder = 30
        ExplicitTop = 518
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
          Left = 508
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
          Left = 573
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
          Left = 70
          Top = 3
          Width = 85
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
          Width = 87
          Height = 25
          Caption = 'Sil (CTRL+DEL)'
          TabOrder = 3
          OnClick = btnSilClick
        end
        object Btn_Onceki: TButton
          Left = 343
          Top = 3
          Width = 75
          Height = 25
          Caption = '&'#214'nceki'
          TabOrder = 6
          OnClick = Btn_OncekiClick
        end
        object Btn_Sonraki: TButton
          Left = 424
          Top = 3
          Width = 75
          Height = 25
          Caption = '&Sonraki'
          TabOrder = 7
          OnClick = Btn_SonrakiClick
        end
      end
      object txtDorse: TIB_Edit
        Left = 704
        Top = 107
        Width = 149
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'DORSE_KOD'
        DataSource = dtsSefer
        Enabled = False
        Visible = False
        TabOrder = 6
        OnEnter = txtDorseEnter
        OnExit = txtDorseExit
        OnKeyDown = txtDorseKeyDown
        OnKeyPress = txtDorseKeyPress
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtDorseButtonClick
      end
      object IB_CheckBox6: TIB_CheckBox
        Left = 8
        Top = 405
        Width = 145
        Height = 13
        TabStop = False
        DataField = 'BEKLEME_FATURASI_KESILDI'
        DataSource = dtsSefer
        Enabled = False
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 24
        Caption = 'Bekleme Faturas'#305' Kesildi'
      end
      object IB_Edit8: TIB_Edit
        Left = 366
        Top = 13
        Width = 83
        Height = 21
        AutoLabel.Kind = albTop
        AutoLabel.Caption = #304#351'lem Merkezi'
        DataField = 'MASRAF_MERK'
        DataSource = dtsSefer
        TabOrder = 3
        OnEnter = IB_Edit8Enter
        OnExit = IB_Edit8Exit
        OnKeyPress = txtPERSONEL_KODKeyPress
        OnKeyUp = IB_Edit8KeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit8ButtonClick
      end
      object IB_Currency15: TIB_Currency
        Left = 224
        Top = 304
        Width = 87
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'MIKTAR'
        DataSource = dtsSefer
        TabOrder = 19
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        AlwaysShowButton = True
      end
      object IB_Edit10: TIB_Edit
        Left = 280
        Top = 13
        Width = 85
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KOD1'
        DataSource = dtsSefer
        TabOrder = 2
        OnEnter = IB_Edit10Enter
        OnExit = IB_Edit10Exit
        OnKeyPress = txtPERSONEL_KODKeyPress
        OnKeyUp = IB_Edit10KeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit10ButtonClick
      end
      object IB_ComboBox2: TIB_ComboBox
        Left = 453
        Top = 12
        Width = 188
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'FATURA_MIK_SEF'
        DataSource = dtsSefer
        TabOrder = 4
        Style = csDropDownList
        ItemHeight = 13
        Items.Strings = (
          'Sefer Say'#305's'#305' * Birim Fiyat'
          'Sefer Say'#305's'#305' * Miktar * Birim Fiyat'
          'Miktar * Birim Fiyat')
        ItemValues.Strings = (
          '1'
          '2'
          '3')
      end
      object Button1: TButton
        Left = 184
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Button1'
        TabOrder = 31
        Visible = False
        OnClick = Button1Click
      end
      object Panel4: TPanel
        Left = 3
        Top = 461
        Width = 639
        Height = 17
        Caption = #304'statistiki Bilgiler'
        TabOrder = 32
      end
      object IB_Edit7: TIB_Edit
        Left = 206
        Top = 492
        Width = 431
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KONTEYNER_NO'
        DataSource = dtsSefer
        TabOrder = 28
        OnEnter = IB_Edit5Enter
        OnExit = IB_Edit1Exit
      end
      object IB_LookupCombo1: TIB_LookupCombo
        Left = 12
        Top = 492
        Width = 185
        Height = 21
        AutoLabel.Kind = albTop
        AutoLabel.Caption = 'Ta'#351#305'nan E'#351'ya'
        DataSource = dtsESYA
        TabOrder = 27
        DisplayField = 'ESYA_AD'
        ShowButton = True
      end
      object IB_CheckBox7: TIB_CheckBox
        Left = 8
        Top = 429
        Width = 145
        Height = 13
        TabStop = False
        DataField = 'SBEKLEME_FATURASI_KESILDI'
        DataSource = dtsSefer
        Enabled = False
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 33
        Caption = 'Sat'#305'c'#305' Bekleme Fat.Kesildi'
      end
      object IB_CheckBox8: TIB_CheckBox
        Left = 224
        Top = 398
        Width = 131
        Height = 13
        DataField = 'SBEKLEME_FAT_VAR'
        DataSource = dtsSefer
        OnClick = IB_CheckBox8Click
        BorderStyle = bsNone
        TabOrder = 34
        Caption = 'Bekleme Faturas'#305' Sat'#305'c'#305
      end
      object GroupBox4: TGroupBox
        Left = 225
        Top = 411
        Width = 416
        Height = 49
        TabOrder = 35
        object IB_Currency16: TIB_Currency
          Left = 9
          Top = 23
          Width = 86
          Height = 21
          TabStop = False
          AutoLabel.Kind = albTop
          DataField = 'SBEKLEME_FAT_TUTAR'
          DataSource = dtsSefer
          TabOrder = 0
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object IB_Currency17: TIB_Currency
          Left = 321
          Top = 23
          Width = 86
          Height = 21
          TabStop = False
          AutoLabel.Kind = albTop
          DataField = 'SBEKLEME_FAT_VPB'
          DataSource = dtsSefer
          ReadOnly = True
          TabOrder = 3
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object cboDOVKOD3: TIB_ComboBox
          Left = 113
          Top = 23
          Width = 88
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'SBEKLEME_FAT_DOV_KOD'
          DataSource = dtsSefer
          TabOrder = 1
          TabStop = False
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          Style = csDropDownList
          ItemHeight = 13
        end
        object IB_Date9: TIB_Date
          Left = 225
          Top = 23
          Width = 82
          Height = 21
          TabStop = False
          AutoLabel.Kind = albTop
          DataField = 'SBEKLEME_FAT_DOV_BAZ_TAR'
          DataSource = dtsSefer
          TabOrder = 2
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          IncCellHeight = 1
          IncCellWidth = 2
          DrawYearArrow = False
        end
      end
      object Panel5: TPanel
        Left = 8
        Top = 448
        Width = 136
        Height = 17
        Caption = 'Sefer Takip No'
        TabOrder = 36
      end
      object Cb_Yukleyici_Firma: TIB_ComboBox
        Left = 206
        Top = 519
        Width = 188
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'YUKLEYICI_FIRMA'
        DataSource = dtsSefer
        TabOrder = 37
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        ItemHeight = 13
      end
      object Btn_Sefer_Takip_sec: TButton
        Left = 424
        Top = 516
        Width = 121
        Height = 25
        Caption = 'Sefer Takip Se'#231
        TabOrder = 38
        OnClick = Btn_Sefer_Takip_secClick
      end
    end
    object Ts_Mazot: TTabSheet
      Caption = 'Mazot Bilgileri'
      ImageIndex = 1
      ExplicitHeight = 548
      object IB_Text3: TIB_Text
        Left = 152
        Top = 108
        Width = 296
        Height = 14
        DataField = 'VEREN_PERSONEL_ADI'
        DataSource = dtsMazot
        Color = clMoneyGreen
        ParentColor = False
      end
      object IB_Text8: TIB_Text
        Left = 152
        Top = 148
        Width = 296
        Height = 14
        DataField = 'MAZOTCU_CARI_ADI'
        DataSource = dtsMazot
        Color = clMoneyGreen
        ParentColor = False
      end
      object Label2: TLabel
        Left = 16
        Top = 15
        Width = 33
        Height = 13
        Caption = 'Plaka'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object IB_Text7: TIB_Text
        Left = 72
        Top = 14
        Width = 105
        Height = 14
        DataField = 'ARAC_PLAKA'
        DataSource = dtsSefer
        Color = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object IB_Text9: TIB_Text
        Left = 304
        Top = 12
        Width = 312
        Height = 14
        DataField = 'ALICI_ADI'
        DataSource = dtsSefer
        Color = clMoneyGreen
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label3: TLabel
        Left = 240
        Top = 13
        Width = 47
        Height = 13
        Caption = 'Al'#305'c'#305' Ad'#305
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object IB_Edit2: TIB_Edit
        Left = 16
        Top = 64
        Width = 62
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
      object IB_Date6: TIB_Date
        Left = 456
        Top = 64
        Width = 94
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'TARIH'
        DataSource = dtsMazot
        TabOrder = 4
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_Edit3: TIB_Edit
        Left = 16
        Top = 104
        Width = 132
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'VEREN_PERSONEL_KOD'
        DataSource = dtsMazot
        TabOrder = 2
        OnEnter = IB_Edit3Enter
        OnExit = IB_Edit3Exit
        OnKeyDown = IB_Edit3KeyDown
        OnKeyPress = IB_Edit2KeyPress
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit3ButtonClick
      end
      object IB_Edit4: TIB_Edit
        Left = 16
        Top = 264
        Width = 625
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'ACIKLAMA'
        DataSource = dtsMazot
        TabOrder = 14
        OnEnter = IB_Edit4Enter
        OnExit = IB_Edit1Exit
      end
      object IB_Currency3: TIB_Currency
        Left = 144
        Top = 184
        Width = 84
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'TUTAR'
        DataSource = dtsMazot
        TabOrder = 8
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        AlwaysShowButton = True
      end
      object IB_Currency11: TIB_Currency
        Left = 16
        Top = 224
        Width = 84
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'TUTAR_VPB'
        DataSource = dtsMazot
        Visible = False
        ReadOnly = True
        TabOrder = 10
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        AlwaysShowButton = True
      end
      object IB_ComboBox1: TIB_ComboBox
        Left = 144
        Top = 224
        Width = 86
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'DOVKOD'
        DataSource = dtsMazot
        Visible = False
        TabOrder = 11
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        Style = csDropDownList
        ItemHeight = 13
      end
      object IB_Date7: TIB_Date
        Left = 264
        Top = 224
        Width = 81
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'DOV_BAZ_TAR'
        DataSource = dtsMazot
        Visible = False
        TabOrder = 12
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_Edit14: TIB_Edit
        Left = 16
        Top = 144
        Width = 132
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'MAZOTCU_CARI_KOD'
        DataSource = dtsMazot
        TabOrder = 3
        OnEnter = IB_Edit14Enter
        OnExit = IB_Edit14Exit
        OnKeyDown = IB_Edit14KeyDown
        OnKeyPress = IB_Edit2KeyPress
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit14ButtonClick
      end
      object IB_Date8: TIB_Date
        Left = 456
        Top = 120
        Width = 94
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'SAAT'
        DataSource = dtsMazot
        TabOrder = 5
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_Currency12: TIB_Currency
        Left = 456
        Top = 168
        Width = 94
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KM'
        DataSource = dtsMazot
        TabOrder = 6
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        AlwaysShowButton = True
      end
      object IB_Currency13: TIB_Currency
        Left = 16
        Top = 184
        Width = 84
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'LITRE_FIYAT'
        DataSource = dtsMazot
        TabOrder = 7
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        AlwaysShowButton = True
      end
      object IB_Currency14: TIB_Currency
        Left = 264
        Top = 184
        Width = 84
        Height = 21
        TabStop = False
        AutoLabel.Kind = albTop
        DataField = 'LITRE'
        DataSource = dtsMazot
        ReadOnly = True
        TabOrder = 9
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        AlwaysShowButton = True
      end
      object IB_Edit15: TIB_Edit
        Left = 152
        Top = 64
        Width = 131
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'FIS_NO'
        DataSource = dtsMazot
        TabOrder = 1
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object Panel2: TPanel
        Left = 15
        Top = 291
        Width = 625
        Height = 30
        TabOrder = 15
        object BtnMYeni: TBitBtn
          Left = 5
          Top = 3
          Width = 62
          Height = 25
          Caption = 'Yeni (INS)'
          TabOrder = 0
          OnClick = BtnMYeniClick
          NumGlyphs = 2
        end
        object BtnMKaydet: TButton
          Left = 70
          Top = 3
          Width = 91
          Height = 25
          Caption = 'Kaydet (CTRL+S)'
          TabOrder = 1
          OnClick = BtnMKaydetClick
        end
        object BtnMIptal: TButton
          Left = 163
          Top = 3
          Width = 80
          Height = 25
          Caption = #304'ptal(CTRL+P)'
          TabOrder = 2
          OnClick = BtnMIptalClick
        end
        object BtnMSil: TButton
          Left = 244
          Top = 3
          Width = 87
          Height = 25
          Caption = 'Sil (CTRL+DEL)'
          TabOrder = 3
          OnClick = BtnMSilClick
        end
      end
      object IB_Grid2: TIB_Grid
        Left = 8
        Top = 328
        Width = 625
        Height = 233
        CustomGlyphsSupplied = []
        DataSource = dtsMazot
        ReadOnly = True
        TabOrder = 16
        RowSelect = True
        TabMovesOut = True
      end
      object IB_CheckBox5: TIB_CheckBox
        Left = 456
        Top = 224
        Width = 124
        Height = 13
        TabStop = False
        DataField = 'ALIS_FATURASI_ALINDI'
        DataSource = dtsMazot
        BorderStyle = bsNone
        ReadOnly = True
        TabOrder = 13
        Caption = 'Al'#305#351' Faturas'#305' Al'#305'nd'#305
      end
      object Panel3: TPanel
        Left = 3
        Top = 41
        Width = 636
        Height = 3
        TabOrder = 17
      end
    end
  end
  object qrySefer: TIB_Query
    ColumnAttributes.Strings = (
      'BEKLEME_FAT_VAR=BOOLEAN=1,0'
      'SEFER_ALIS_FAT_ALINDI=BOOLEAN=1,0'
      'SEFER_SATIS_FAT_KESILDI=BOOLEAN=1,0'
      'SEFER_TAMAMLANDI=BOOLEAN=1,0'
      'BEKLEME_FATURASI_KESILDI=BOOLEAN=1,0'
      'SBEKLEME_FAT_VAR=BOOLEAN=1,0')
    FieldsDisplayLabel.Strings = (
      'FIS_NO=Fi'#351' No'
      'KASA_KOD=Kasa Kodu'
      'TARIH=Tarih'
      'DOV_BAZ_TAR=D'#246'viz Baz Tar'
      'ACIKLAMA=Hareket A'#231#305'klamas'#305
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
      'SATICI_ADI=Sat'#305'c'#305' Ad'#305
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
      'ALICI_B_DOV_BAZ_TAR=Al'#305'c'#305' D'#246'v.Baz.Tar'
      'SATICI_A_DOV_BAZ_TAR=Sat'#305'c'#305' D'#246'v.Baz.Tar'
      'BEKLEME_FAT_DOV_BAZ_TAR=Fatura D'#246'v.Baz.Tar'
      'DORSE_KOD=Dorse Kod'
      'DARAC_PLAKA=Drose Plaka'
      'SEFER_TAMAMLANDI=Sefer Tamamland'#305
      'ALIS_URUN_HAR_ID=Al'#305#351' Faturas'#305' Hareket No'
      'SATIS_URUN_HAR_ID=Sat'#305#351' Faturas'#305' Hareket No'
      'BEKLEME_FATURASI_KESILDI=Bekleme Faturas'#305' Kesildi'
      'MIKTAR=Miktar'#305
      'FATURA_MIK_SEF=Fa. Sef.Say.Mik.'
      'KONTEYNER_NO=Konteyner No'
      'SBEKLEME_FAT_DOV_KOD=D'#246'viz Kodu'
      'SBEKLEME_FAT_TUTAR=Tutar'
      'SBEKLEME_FAT_VAR=Bekleme Faturas'#305
      'SBEKLEME_FATURASI_KESILDI=sBekleme Faturas'#305' Kesildi'
      'SBEKLEME_FAT_VPB=Tutar Vpb'
      'SBEKLEME_FAT_DOV_BAZ_TAR=D'#246'v Baz Tar'
      'YUKLEYICI_FIRMA=Y'#252'kleyici Firma')
    FieldsVisible.Strings = (
      'KASAHAR_ID=FALSE'
      'KASAHAR_SID=FALSE'
      'BELGE_TUR=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE'
      'SECIM=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnSefer
    SQL.Strings = (
      'SELECT SEFER_ID'
      '     , SEFER_SID'
      '     , SEFER_SAY'
      '     , ARAC_KOD'
      
        '     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER.ARAC_KOD' +
        ') AS ARAC_PLAKA'
      '     , ALICI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SEFER.ALICI_' +
        'KOD) AS ALICI_ADI'
      '     , SATICI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE SEFER.SATICI_KOD=CARI.CARI' +
        '_KOD) AS SATICI_ADI'
      '     , PERSONEL_KOD'
      
        '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_K' +
        'OD=SEFER.PERSONEL_KOD) AS PERSONEL_ADI'
      '     , OLCU_TIP'
      '     , OLCU_BIRIM'
      '     , TASINAN_ESYA'
      '     , BAS_TAR'
      '     , BIT_TAR'
      '     , CIK_YER'
      '     , BIT_YER'
      '     , ALICI_BORC_BIRIM_FIY'
      '     , ALICI_B_DOVKOD'
      '     , ALICI_BORC'
      '     , ALICI_BORC_VPB'
      '     , SATICI_ALACAK_BIRIM_FIY'
      '     , SATICI_A_DOVKOD'
      '     , SATICI_ALACAK'
      '     , SATICI_ALACAK_VPB'
      '     , BEKLEME_FAT_VAR'
      '     , BEKLEME_FAT_TUTAR'
      '     , BEKLEME_FAT_DOV_KOD'
      '     , BEKLEME_FAT_VPB'
      '     , SEFER_NOTLARI'
      '     , SEFER_ALIS_FAT_ALINDI'
      '     , SEFER_SATIS_FAT_KESILDI'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , ALICI_B_DOV_BAZ_TAR'
      '     , SATICI_A_DOV_BAZ_TAR'
      '     , BEKLEME_FAT_DOV_BAZ_TAR'
      '     , ALICI_B_DOVKUR'
      '     , SATICI_A_DOVKUR'
      '     , BEKLEME_FAT_DOVKUR'
      '     , DORSE_KOD '
      
        '     ,(SELECT PLAKA FROM ARAC AR WHERE AR.ARAC_KOD=SEFER.DORSE_K' +
        'OD) AS DARAC_PLAKA'
      '     , SEFER_TAMAMLANDI'
      '     , ALIS_URUN_HAR_ID'
      '     , SATIS_URUN_HAR_ID'
      '     , BEKLEME_FATURASI_KESILDI'
      '     , BEK_FAT_URUN_HAR_ID'
      '     , SECIM'
      '     , MIKTAR'
      '     , FATURA_MIK_SEF'
      '     , ESYA_ID'
      '     , KONTEYNER_NO'
      '   , SBEKLEME_FAT_VAR'
      '   , SBEKLEME_FAT_TUTAR'
      '   , SBEKLEME_FAT_DOV_KOD'
      '   , SBEKLEME_FAT_VPB'
      '   , SBEKLEME_FAT_DOV_BAZ_TAR'
      '   , SBEKLEME_FAT_DOVKUR'
      '   , SBEKLEME_FATURASI_KESILDI'
      '   , SBEK_FAT_URUN_HAR_ID'
      '   , SEFER_TAKIP_ID'
      '   , YUKLEYICI_FIRMA'
      'FROM SEFER'
      'WHERE SEFER_ID=:PRM_SEFER_ID AND SEFER_SID=:PRM_SEFER_SID')
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
      'SEFER.SEFER_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qrySeferAfterInsert
    BeforeCancel = qrySeferBeforeCancel
    BeforeEdit = qrySeferBeforeEdit
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 408
    Top = 64
    ParamValues = (
      'PRM_SEFER_ID=0')
  end
  object dtsSefer: TIB_DataSource
    AutoInsert = False
    Dataset = qrySefer
    OnDataChange = dtsSeferDataChange
    OnStateChanged = dtsSeferStateChanged
    Left = 376
    Top = 64
  end
  object trnSefer: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 304
    Top = 72
  end
  object dtsMazot: TIB_DataSource
    AutoInsert = False
    Dataset = qryMazot
    OnDataChange = dtsMazotDataChange
    OnStateChanged = dtsMazotStateChanged
    Left = 376
    Top = 96
  end
  object qryMazot: TIB_Query
    ColumnAttributes.Strings = (
      'ALIS_FATURASI_ALINDI=BOOLEAN=1,0')
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
      'VEREN_PERSONEL_ADI=Veren Personel  Ad'#305
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
      'DOVKOD=FALSE'
      'DOV_BAZ_TAR=FALSE'
      'DOVKUR=FALSE'
      'TUTAR=FALSE'
      'MASRAF_MERK=FALSE'
      'KOD1=FALSE'
      'KOD2=FALSE'
      'KOD3=FALSE'
      'KOD4=FALSE'
      'SEFER_ID=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnSefer
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
      'FROM MAZOT_FISI'
      'WHERE SEFER_ID=:PRM_SEFER_ID'
      'ORDER BY MAZOT_FIS_ID')
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
    AfterPost = qryMazotAfterPost
    BeforePost = qryMazotBeforePost
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 408
    Top = 96
    ParamValues = (
      'PRM_SEFER_ID=0')
  end
  object qryESYA: TIB_Query
    FieldsGridLabel.Strings = (
      'ESYA_AD=E'#351'ya Ad')
    FieldsVisible.Strings = (
      'ESYA_ID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT *'
      'FROM ESYA')
    ColorScheme = False
    KeyLinks.Strings = (
      'ESYA.ESYA_ID=SEFER.ESYA_ID')
    KeySource = dtsSefer
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 410
    Top = 160
  end
  object dtsESYA: TIB_DataSource
    Dataset = qryESYA
    Left = 378
    Top = 168
  end
end
