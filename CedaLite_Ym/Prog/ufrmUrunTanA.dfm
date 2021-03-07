object frmUrunTanA: TfrmUrunTanA
  Left = 265
  Top = 119
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #220'r'#252'n Tan'#305'mlama'
  ClientHeight = 454
  ClientWidth = 558
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgUrun: TPageControl
    Left = 0
    Top = 0
    Width = 558
    Height = 435
    ActivePage = tabUrun
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    OnChange = pgUrunChange
    OnChanging = pgUrunChanging
    object tabUrun: TTabSheet
      Caption = 'Temel '#220'r'#252'n Bilgileri'
      object Panel1: TPanel
        Left = 0
        Top = 374
        Width = 550
        Height = 30
        Align = alBottom
        TabOrder = 28
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
          Left = 420
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
          Left = 484
          Top = 3
          Width = 61
          Height = 25
          Caption = #199#305'&k'#305#351
          TabOrder = 2
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
      object IB_Edit1: TIB_Edit
        Left = 90
        Top = 4
        Width = 111
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'URUN_KOD'
        DataSource = dts_Urun
        TabOrder = 0
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        OnKeyPress = IB_Edit1KeyPress
      end
      object IB_Edit2: TIB_Edit
        Left = 90
        Top = 26
        Width = 423
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'URUN_AD'
        DataSource = dts_Urun
        TabOrder = 1
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        OnKeyPress = IB_Edit1KeyPress
      end
      object IB_Edit3: TIB_Edit
        Left = 90
        Top = 49
        Width = 423
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'URUN_AD_YD'
        DataSource = dts_Urun
        TabOrder = 2
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        OnKeyPress = IB_Edit1KeyPress
      end
      object IB_Edit9: TIB_Edit
        Left = 272
        Top = 73
        Width = 241
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'DEPO_ADI'
        DataSource = dts_Urun
        Enabled = False
        TabOrder = 4
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_Edit27: TIB_Edit
        Left = 90
        Top = 97
        Width = 125
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'OLCU_TIP'
        DataSource = dts_Urun
        TabOrder = 5
        OnEnter = IB_Edit27Enter
        OnExit = IB_Edit27Exit
        OnKeyPress = IB_Edit27KeyPress
        OnKeyUp = IB_Edit27KeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit27ButtonClick
      end
      object IB_Edit8: TIB_Edit
        Left = 272
        Top = 97
        Width = 147
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'OLCUBIRIM'
        DataSource = dts_Urun
        TabOrder = 6
        OnEnter = IB_Edit8Enter
        OnExit = IB_Edit8Exit
        OnKeyPress = IB_Edit8KeyPress
        OnKeyUp = IB_Edit8KeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit8ButtonClick
      end
      object IB_Currency1: TIB_Currency
        Left = 90
        Top = 121
        Width = 121
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'BIRIMFIY'
        DataSource = dts_Urun
        TabOrder = 7
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        AlwaysShowButton = True
      end
      object IB_Currency2: TIB_Currency
        Left = 273
        Top = 121
        Width = 114
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'SATISFIY'
        DataSource = dts_Urun
        TabOrder = 8
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        AlwaysShowButton = True
      end
      object IB_Edit20: TIB_Edit
        Left = 415
        Top = 121
        Width = 28
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'KDV'
        DataSource = dts_Urun
        TabOrder = 9
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_Edit5: TIB_Edit
        Left = 90
        Top = 214
        Width = 60
        Height = 21
        TabStop = False
        AutoLabel.Kind = albLeft
        DataField = 'AZAMIMIK'
        DataSource = dts_Urun
        Color = clScrollBar
        Enabled = False
        TabOrder = 18
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_Edit16: TIB_Edit
        Left = 90
        Top = 166
        Width = 167
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'UBARCODE'
        DataSource = dts_Urun
        TabOrder = 13
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_Edit4: TIB_Edit
        Left = 219
        Top = 214
        Width = 60
        Height = 21
        TabStop = False
        AutoLabel.Kind = albLeft
        DataField = 'ASGARIMIK'
        DataSource = dts_Urun
        Color = clScrollBar
        Enabled = False
        TabOrder = 19
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_Edit6: TIB_Edit
        Left = 352
        Top = 214
        Width = 60
        Height = 21
        TabStop = False
        AutoLabel.Kind = albLeft
        DataField = 'SIPMIKTAR'
        DataSource = dts_Urun
        Color = clScrollBar
        Enabled = False
        TabOrder = 20
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_Edit15: TIB_Edit
        Left = 368
        Top = 166
        Width = 167
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'D_BARCODE'
        DataSource = dts_Urun
        TabOrder = 14
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_Edit26: TIB_Edit
        Left = 90
        Top = 190
        Width = 167
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'GTIPNO'
        DataSource = dts_Urun
        TabOrder = 15
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_Edit10: TIB_Edit
        Left = 90
        Top = 144
        Width = 24
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'KARMARJ'
        DataSource = dts_Urun
        TabOrder = 11
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_CheckBox1: TIB_CheckBox
        Left = 479
        Top = 193
        Width = 55
        Height = 17
        DisplayLabelAsCaption = True
        DataField = 'HIZMET'
        DataSource = dts_Urun
        BorderStyle = bsNone
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 17
        Caption = 'Hizmet'
      end
      object IB_Memo1: TIB_Memo
        Left = 90
        Top = 329
        Width = 425
        Height = 38
        AutoLabel.Kind = albLeft
        DataField = 'ACIKLAMALAR'
        DataSource = dts_Urun
        TabOrder = 27
        OnEnter = IB_Memo1Enter
        OnExit = IB_Memo1Exit
        AutoSize = False
      end
      object IB_Edit7: TIB_Edit
        Left = 90
        Top = 73
        Width = 126
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'DEPO_KOD'
        DataSource = dts_Urun
        TabOrder = 3
        OnEnter = IB_Edit7Enter
        OnExit = IB_Edit7Exit
        OnKeyPress = IB_Edit7KeyPress
        OnKeyUp = IB_Edit7KeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit7ButtonClick
      end
      object IB_Currency3: TIB_Currency
        Left = 275
        Top = 238
        Width = 90
        Height = 21
        TabStop = False
        AutoLabel.Kind = albLeft
        DataField = 'BORC_VPB'
        DataSource = dts_Urun
        Color = clScrollBar
        Enabled = False
        TabOrder = 22
        AlwaysShowButton = True
      end
      object IB_Currency4: TIB_Currency
        Left = 275
        Top = 260
        Width = 90
        Height = 21
        TabStop = False
        AutoLabel.Kind = albLeft
        DataField = 'ALACAK_VPB'
        DataSource = dts_Urun
        Color = clScrollBar
        Enabled = False
        TabOrder = 24
        AlwaysShowButton = True
      end
      object IB_Currency5: TIB_Currency
        Left = 90
        Top = 299
        Width = 90
        Height = 21
        TabStop = False
        AutoLabel.Kind = albLeft
        DataField = 'MIKTAR_BORC'
        DataSource = dts_Urun
        Color = clScrollBar
        Enabled = False
        TabOrder = 25
        AlwaysShowButton = True
      end
      object IB_Currency6: TIB_Currency
        Left = 275
        Top = 299
        Width = 90
        Height = 21
        TabStop = False
        AutoLabel.Kind = albLeft
        DataField = 'MIKTAR_ALACAK'
        DataSource = dts_Urun
        Color = clScrollBar
        Enabled = False
        TabOrder = 26
        AlwaysShowButton = True
      end
      object IB_Currency7: TIB_Currency
        Left = 90
        Top = 238
        Width = 90
        Height = 21
        TabStop = False
        AutoLabel.Kind = albLeft
        DataField = 'BORC'
        DataSource = dts_Urun
        Color = clScrollBar
        Enabled = False
        TabOrder = 21
        AlwaysShowButton = True
      end
      object IB_Currency8: TIB_Currency
        Left = 90
        Top = 260
        Width = 90
        Height = 21
        TabStop = False
        AutoLabel.Kind = albLeft
        DataField = 'ALACAK'
        DataSource = dts_Urun
        Color = clScrollBar
        Enabled = False
        TabOrder = 23
        AlwaysShowButton = True
      end
      object IB_CheckBox3: TIB_CheckBox
        Left = 130
        Top = 146
        Width = 97
        Height = 16
        DataField = 'KDV_DAHIL'
        DataSource = dts_Urun
        BorderStyle = bsNone
        TabOrder = 12
        Caption = 'KDV Dahil'
      end
      object cboDOVKOD: TIB_ComboBox
        Left = 450
        Top = 120
        Width = 89
        Height = 21
        AutoLabel.Kind = albTop
        AutoLabel.Caption = 'D'#246'viz Kodu'
        DataField = 'DOVKOD'
        DataSource = dts_Urun
        TabOrder = 10
        OnEnter = cboDOVKODEnter
        OnExit = cboDOVKODExit
        Style = csDropDownList
        ItemHeight = 13
      end
      object IB_ComboBox1: TIB_ComboBox
        Left = 368
        Top = 192
        Width = 89
        Height = 21
        AutoLabel.Kind = albLeft
        AutoLabel.Caption = #220'r'#252'n Tipi'
        DataField = 'URUN_TIP'
        DataSource = dts_Urun
        TabOrder = 16
        OnEnter = cboDOVKODEnter
        OnExit = cboDOVKODExit
        Style = csDropDownList
        ItemHeight = 13
        Items.Strings = (
          'Mamul'
          'Yar'#305' Mamul'
          'Ham Madde')
        ItemValues.Strings = (
          'M'
          'Y'
          'H')
      end
      object IB_Currency9: TIB_Currency
        Left = 459
        Top = 238
        Width = 90
        Height = 21
        TabStop = False
        AutoLabel.Kind = albLeft
        DataField = 'DEV_BORC'
        DataSource = dts_Urun
        Color = clScrollBar
        Enabled = False
        TabOrder = 29
        AlwaysShowButton = True
      end
      object IB_Currency10: TIB_Currency
        Left = 459
        Top = 260
        Width = 90
        Height = 21
        TabStop = False
        AutoLabel.Kind = albLeft
        DataField = 'DEV_ALACAK'
        DataSource = dts_Urun
        Color = clScrollBar
        Enabled = False
        TabOrder = 30
        AlwaysShowButton = True
      end
    end
    object tabUrunGrup: TTabSheet
      Caption = 'Gruplama'
      ImageIndex = 1
      object IB_Grid1: TIB_Grid
        Left = 3
        Top = 21
        Width = 237
        Height = 267
        CustomGlyphsSupplied = []
        DataSource = dtsBut_Urun_Grup
        OnDblClick = btnEkleClick
        BorderStyle = bsNone
        TabOrder = 0
        RowSelect = True
        Ctl3DShallow = True
      end
      object IB_Grid2: TIB_Grid
        Left = 270
        Top = 21
        Width = 271
        Height = 268
        CustomGlyphsSupplied = []
        DataSource = dtsUrun_Grup_Uye
        OnDblClick = btnGSilClick
        BorderStyle = bsNone
        TabOrder = 1
        RowSelect = True
        Ctl3DShallow = True
      end
      object btnVarSay: TButton
        Left = 271
        Top = 295
        Width = 186
        Height = 25
        Caption = 'Se'#231'ili Grubu Vars'#305'yalan Olarak Ata'
        TabOrder = 2
        OnClick = btnVarSayClick
      end
      object btnUrunGroup: TButton
        Left = 3
        Top = 295
        Width = 75
        Height = 25
        Caption = #220'r'#252'n &Grup'
        TabOrder = 3
        OnClick = btnUrunGroupClick
      end
      object btnEkle: TButton
        Left = 241
        Top = 22
        Width = 26
        Height = 22
        Caption = '- >'
        TabOrder = 4
        OnClick = btnEkleClick
      end
      object btnGSil: TButton
        Left = 242
        Top = 49
        Width = 27
        Height = 24
        Caption = '< -'
        TabOrder = 5
        OnClick = btnGSilClick
      end
    end
    object tabFiyat: TTabSheet
      Caption = 'Fiyatland'#305'rma'
      ImageIndex = 3
      object GroupBox1: TGroupBox
        Left = 4
        Top = 1
        Width = 545
        Height = 194
        Caption = 'Cari Fiyat'
        TabOrder = 0
        object lblFiyCariAciklama: TLabel
          Left = 4
          Top = 152
          Width = 535
          Height = 13
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Grid4: TIB_Grid
          Left = 4
          Top = 12
          Width = 537
          Height = 138
          CustomGlyphsSupplied = []
          DataSource = dts_FiyCari
          BorderStyle = bsNone
          TabOrder = 0
          TabStopAutomation = True
          TrackGridRow = True
          Ctl3DShallow = True
          TabMovesOut = True
          object IB_LookupCombo2: TIB_LookupCombo
            Left = 195
            Top = 75
            Width = 121
            Height = 21
            DataSource = dts_FiyCariDovKod
            Visible = False
            TabOrder = 0
            DisplayField = 'DOVKOD'
            ShowButton = True
          end
        end
        object btnCariFiyEkle: TButton
          Left = 5
          Top = 166
          Width = 55
          Height = 22
          Caption = 'Ekle'
          TabOrder = 1
          OnClick = btnCariFiyEkleClick
        end
        object btnCariFiyDeg: TButton
          Left = 61
          Top = 166
          Width = 55
          Height = 22
          Caption = 'De'#287'i'#351'tir'
          TabOrder = 2
          OnClick = btnCariFiyDegClick
        end
        object btnCariFiySil: TButton
          Left = 116
          Top = 166
          Width = 55
          Height = 22
          Caption = 'Sil'
          TabOrder = 3
          OnClick = btnCariFiySilClick
        end
        object btnCariFiyKaydet: TButton
          Left = 171
          Top = 166
          Width = 55
          Height = 22
          Caption = 'Kaydet'
          TabOrder = 4
          OnClick = btnCariFiyKaydetClick
        end
        object btnCariFiyIptal: TButton
          Left = 226
          Top = 166
          Width = 55
          Height = 22
          Caption = #304'ptal'
          TabOrder = 5
          OnClick = btnCariFiyIptalClick
        end
      end
      object GroupBox2: TGroupBox
        Left = 5
        Top = 194
        Width = 544
        Height = 206
        Caption = 'Cari Grup Fiyat'
        TabOrder = 1
        object lblFiyCGAciklama: TLabel
          Left = 6
          Top = 167
          Width = 529
          Height = 13
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Grid5: TIB_Grid
          Left = 4
          Top = 12
          Width = 531
          Height = 155
          CustomGlyphsSupplied = []
          DataSource = dts_FiyCGroup
          BorderStyle = bsNone
          TabOrder = 0
          Ctl3DShallow = True
          object IB_LookupCombo3: TIB_LookupCombo
            Left = 194
            Top = 8
            Width = 121
            Height = 21
            DataSource = dts_FiyCGroupDovKod
            Visible = False
            TabOrder = 0
            DisplayField = 'DOVKOD'
            ShowButton = True
          end
        end
        object btnCGFiyEkle: TButton
          Left = 6
          Top = 181
          Width = 55
          Height = 22
          Caption = 'Ekle'
          TabOrder = 1
          OnClick = btnCGFiyEkleClick
        end
        object btnCGFiyDeg: TButton
          Left = 61
          Top = 181
          Width = 55
          Height = 22
          Caption = 'De'#287'i'#351'tir'
          TabOrder = 2
          OnClick = btnCGFiyDegClick
        end
        object btnCGFiySil: TButton
          Left = 118
          Top = 181
          Width = 55
          Height = 22
          Caption = 'Sil'
          TabOrder = 3
          OnClick = btnCGFiySilClick
        end
        object btnCGFiyKaydet: TButton
          Left = 174
          Top = 181
          Width = 55
          Height = 22
          Caption = 'Kaydet'
          TabOrder = 4
          OnClick = btnCGFiyKaydetClick
        end
        object btnCGFiyIptal: TButton
          Left = 230
          Top = 181
          Width = 55
          Height = 22
          Caption = #304'ptal'
          TabOrder = 5
          OnClick = btnCGFiyIptalClick
        end
      end
    end
    object tabTedarik: TTabSheet
      Caption = 'Tedarik'
      ImageIndex = 4
      object IB_Grid3: TIB_Grid
        Left = 0
        Top = 169
        Width = 550
        Height = 235
        CustomGlyphsSupplied = []
        DataSource = dts_Urun_Tedarik
        Align = alClient
        ReadOnly = True
        TabOrder = 0
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 550
        Height = 169
        Align = alTop
        TabOrder = 1
        object IB_Edit24: TIB_Edit
          Left = 352
          Top = 64
          Width = 121
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'TEDARIK_SURESI'
          DataSource = dts_Urun_Tedarik
          TabOrder = 3
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
        end
        object IB_Edit25: TIB_Edit
          Left = 56
          Top = 64
          Width = 129
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'FIYAT'
          DataSource = dts_Urun_Tedarik
          TabOrder = 2
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
        end
        object IB_Edit28: TIB_Edit
          Left = 56
          Top = 88
          Width = 417
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ACIKLAMA'
          DataSource = dts_Urun_Tedarik
          TabOrder = 4
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          OnKeyUp = txtCarikodKeyUp
        end
        object txtCarikod: TIB_Edit
          Left = 56
          Top = 41
          Width = 129
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'CARI_KOD'
          DataSource = dts_Urun_Tedarik
          TabOrder = 0
          OnEnter = txtCarikodEnter
          OnExit = txtCarikodExit
          OnKeyPress = txtCarikodKeyPress
          OnKeyUp = txtCarikodKeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = txtCarikodButtonClick
        end
        object txtCARI_AD: TIB_Edit
          Left = 244
          Top = 41
          Width = 229
          Height = 21
          TabStop = False
          AutoLabel.Kind = albLeft
          DataField = 'CARI_ADI'
          DataSource = dts_Urun_Tedarik
          Enabled = False
          ReadOnly = True
          TabOrder = 1
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
        end
        object btn_Te_Yeni: TButton
          Left = 13
          Top = 128
          Width = 60
          Height = 23
          Caption = 'Ekle (INS)'
          TabOrder = 5
          OnClick = btn_Te_YeniClick
        end
        object btn_Te_Kaydet: TButton
          Left = 72
          Top = 128
          Width = 94
          Height = 23
          Caption = 'Kaydet (CTRL+S)'
          TabOrder = 6
          OnClick = btn_Te_KaydetClick
        end
        object btn_Te_Iptal: TButton
          Left = 165
          Top = 128
          Width = 86
          Height = 23
          Caption = #304'ptal(CTRL+P)'
          TabOrder = 7
          OnClick = btn_Te_IptalClick
        end
        object btn_Te_Sil: TButton
          Left = 432
          Top = 128
          Width = 97
          Height = 23
          Caption = 'Sil (CTRL + DEL)'
          TabOrder = 8
          OnClick = btn_Te_SilClick
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 435
    Width = 558
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 200
      end
      item
        Width = 125
      end
      item
        Alignment = taCenter
        Text = 'Bakiye'
        Width = 40
      end
      item
        Alignment = taCenter
        Text = 'BA'
        Width = 25
      end
      item
        Alignment = taRightJustify
        Text = '0'
        Width = 50
      end>
  end
  object qry_Urun: TIB_Query
    ColumnAttributes.Strings = (
      'KOMPLEX=REQUIRED;BOOLEAN=1,0'
      'HIZMET=REQUIRED;BOOLEAN=1,0'
      'KARMARJ=BOOLEAN=1,0;REQUIRED'
      'KDV_DAHIL=BOOLEAN=1,0;REQUIRED')
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    FieldsDisplayFormat.Strings = (
      'BAKIYE=#,##.00'
      'VADELI_MIKTAR_BORC=#,##.00'
      'VADELI_MIKTAR_ALACAK=#,##.00'
      'DEV_BORC_VPB=Dev.Brc'
      'DEV_ALACAK_VPB=Dev.Alc.')
    FieldsDisplayLabel.Strings = (
      'URUN_KOD='#220'r'#252'n Kodu '
      'URUN_AD='#220'r'#252'n Ad'#305' '
      'URUN_AD_ENG='#220'r'#252'n Ad'#305' ('#304'ng.) :'
      'ASGARIMIK=Asgari Miktar '
      'AZAMIMIK=Azami Miktar '
      'SIPMIKTAR=Sipari'#351' Miktar'#305' '
      'DEPOSURE=Depo S'#252're '
      'OLCUBIRIM='#214'l'#231#252' Birimi '
      'KOMPLEX=Komplex'
      'BORC=Bor'#231' '
      'ALACAK=Alacak '
      'BAKIYE=Bakiye :'
      'D_BARCODE=Depo Barkod '
      'UBARCODE='#220'r'#252'n Barkod '
      'ACIKLAMALAR=A'#231#305'klamalar '
      'HIZMET=Hizmet'
      'ALISKDV=Al'#305#351' KDV :'
      'SATISKDV=Sat'#305#351' KDV :'
      'BIRIMFIY=Birim Fiyat'#305' '
      'BIRIMDOVKOD=Birim D'#246'viz Kodu :'
      'SATISFIY=Sat'#305#351' Fiyat'#305' '
      'SATISDOVKOD=Sat'#305#351' D'#246'viz Kodu :'
      'MUHASKOD=Muhasebe Kodu :'
      'GTIPNO=GTip '
      'OLCU_TIP='#214'l'#231#252' Tipi '
      'DEPO_ADI=Depo Ad'#305' '
      'KARMARJ=Kar Marj'#305
      'MUH_ALIS_HES=Al'#305#351' Hesab'#305
      'MUH_SATIS_IADE_HES=Sat'#305#351' '#304'ade Hesab'#305
      'MUH_SATIS_HES=Sat'#305#351' Hesab'#305
      'MUH_ALIS_IADE_HES=Al'#305#351' '#304'ade Hesab'#305
      'MUH_ALIS_HES_AD=Hesap Ad'#305
      'MUH_SATIS_IADE_HES_AD=Hesap Ad'#305
      'MUH_SATIS_HES_AD=Hesap Ad'#305
      'MUH_ALIS_IADE_HES_AD=Hesap Ad'#305
      'URUN_AD_YD='#220'r'#252'n Ad'#305' ('#304'ng.) '
      'KDV=KDV'
      'DOVKOD=Para Birimi'
      'DEPO_KOD=Depo Kodu'
      'BORC_VPB=Borc VPB'
      'ALACAK_VPB=Alacak VPB'
      'MIKTAR_BORC=Miktar Borc'
      'MIKTAR_ALACAK=Miktar Alacak'
      'VADELI_MIKTAR_BORC=Vadeli Miktar Borc'
      'VADELI_MIKTAR_ALACAK=Vadeli Miktar Alacak'
      'KDV_DAHIL=KDV Dahil'
      'MUH_YD_SATIS_HES=YD Sat'#305#351' Hesab'#305
      'MUH_YD_SATIS_HES_AD=Hesap Ad'#305
      'URUN_TIP='#220'r'#252'n Tipi'
      'DEV_BORC=Dev.Brc'
      'DEV_ALACAK=Dev.Alc.')
    FieldsReadOnly.Strings = (
      'BIRIMDOVKOD=NOEDIT'
      'SATISDOVKOD=NOEDIT'
      'DEPO_ADI=NOEDIT'
      'BORC=TRUE'
      'ALACAK=TRUE'
      'BAKIYE=NOEDIT'
      'ASGARIMIK=TRUE'
      'AZAMIMIK=TRUE'
      'BORC_VPB=TRUE'
      'ALACAK_VPB=TRUE'
      'MIKTAR_BORC=TRUE'
      'MIKTAR_ALACAK=TRUE'
      'VADELI_MIKTAR_BORC=TRUE'
      'VADELI_MIKTAR_ALACAK=TRUE'
      'SIPMIKTAR=TRUE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT URUN_KOD'
      '     , URUN_SID'
      '     , URUN_AD'
      '     , URUN_AD_YD'
      '     , TIP'
      '     , ASGARIMIK'
      '     , AZAMIMIK'
      '     , SIPMIKTAR'
      '     , DEPOSURE'
      '     , OLCU_TIP'
      '     , OLCUBIRIM'
      '     , DEPO_KOD'
      '     , KOMPLEX'
      '     , BORC'
      '     , ALACAK'
      '     , BORC_VPB'
      '     , ALACAK_VPB'
      '     , MIKTAR_BORC'
      '     , MIKTAR_ALACAK'
      '     , D_BARCODE'
      '     , UBARCODE'
      '     , ACIKLAMALAR'
      '     , HIZMET'
      '     , KDV'
      '     , DOVKOD'
      '     , BIRIMFIY'
      '     , SATISFIY'
      '     , GTIPNO'
      '     , KARMARJ'
      
        '     , (SELECT ADI FROM DEPO WHERE DEPO.DEPO_KOD = URUN.DEPO_KOD' +
        ' ) AS DEPO_ADI'
      '     , KDV_DAHIL'
      '     , URUN_TIP'
      '     , DEV_BORC'
      '     , DEV_ALACAK'
      ' '
      'FROM URUN Where URUN_KOD=:PRM_URUN_KOD')
    ColorScheme = False
    DefaultValues.Strings = (
      'HIZMET=0'
      'KOMPLEX=0'
      'BORC=0'
      'ALACAK=0'
      'BAKIYE=0'
      'BIRIMFIY=0'
      'SATISFIY=0'
      'BORC_VPB=0'
      'ALACAK_VPB=0')
    KeyLinks.Strings = (
      'URUN.URUN_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qry_UrunAfterInsert
    BeforeDelete = qry_UrunBeforeDelete
    BeforePost = qry_UrunBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 162
    Top = 112
    ParamValues = (
      'PRM_URUN_KOD=')
  end
  object dts_Urun: TIB_DataSource
    AutoInsert = False
    Dataset = qry_Urun
    OnStateChanged = dts_UrunStateChanged
    Left = 54
    Top = 118
  end
  object qryBut_Urun_Grup: TIB_Query
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    FieldsDisplayLabel.Strings = (
      'UGKOD=Grup Kodu'
      'UGADI=Grup Ad'#305
      'UG_KOD='#220'r'#252'n Grup Kodu'
      'URUN_GRUP_KOD='#220'r'#252'n Grup Kodu')
    FieldsDisplayWidth.Strings = (
      'UGKOD=59'
      'UGADI=102'
      'UG_KOD=83'
      'URUN_GRUP_KOD=98')
    FieldsVisible.Strings = (
      'URUN_GRUP_ID=FALSE'
      'URUN_GRUP_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT URUN_GRUP_KOD'
      '     , URUN_GRUP_SID'
      '     , UGADI'
      'From URUN_GRUP'
      'Where not exists '
      '          (Select * '
      '           From URUN_GRUP_UYE '
      
        '           where URUN_GRUP_UYE.URUN_GRUP_KOD = URUN_GRUP.URUN_GR' +
        'UP_KOD'
      '           AND URUN_KOD =:PRM_URUN_KOD)')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 168
    Top = 171
    ParamValues = (
      'PRM_URUN_KOD=')
  end
  object qryUrun_Grup_Uye: TIB_Query
    ColumnAttributes.Strings = (
      'VARSAY=BOOLEAN=1,0')
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    FieldsDisplayLabel.Strings = (
      'UGKOD=Grup Kodu'
      'UGADI=Grup Ad'#305
      'VARSAY=Var Say'
      'UG_KOD='#220'r'#252'n Grup Kodu'
      'URUN_GRUP_KOD='#220'r'#252'n Grup Kodu')
    FieldsDisplayWidth.Strings = (
      'UGKOD=58'
      'UGADI=85'
      'VARSAY=43'
      'UG_KOD=87'
      'URUN_GRUP_KOD=98')
    FieldsVisible.Strings = (
      'URUN_GRUP_ID=FALSE'
      'URUN_GRUP_SID=FALSE'
      'URUNID=FALSE'
      'URUN_SID=FALSE'
      'URUN_ID=FALSE'
      'URUN_KOD=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'Select '
      '  URUN_GRUP.URUN_GRUP_KOD,'
      '  URUN_GRUP.UGADI,  '
      '  URUN_GRUP_UYE.VARSAY,'
      '  URUN_GRUP_UYE.URUN_KOD'
      ''
      'From URUN_GRUP_UYE,URUN_GRUP'
      'Where '
      '  URUN_GRUP_UYE.URUN_GRUP_KOD = URUN_GRUP.URUN_GRUP_KOD And'
      '  URUN_GRUP_UYE.URUN_KOD=:PRM_URUN_KOD')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 161
    Top = 236
    ParamValues = (
      'PRM_URUN_KOD=')
  end
  object dtsBut_Urun_Grup: TIB_DataSource
    Dataset = qryBut_Urun_Grup
    Left = 58
    Top = 175
  end
  object dtsUrun_Grup_Uye: TIB_DataSource
    Dataset = qryUrun_Grup_Uye
    Left = 58
    Top = 228
  end
  object qry_FiyCari: TIB_Query
    ColumnAttributes.Strings = (
      'FIY_TIP=BOOLEAN=1,0;REQUIRED')
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    FieldsDisplayLabel.Strings = (
      'CARI_KOD=Cari Kodu'
      'CARI_AD=Cari Ad'#305
      'SATISDOVKOD=Para Birim'
      'SATISFIY=Sat'#305#351' Fiyat'#305' '
      'BIRIMORAN=Oran'
      'FIY_TIP=Fiyat')
    FieldsGridLabel.Strings = (
      'FIY_TIP=Fiyat')
    FieldsDisplayWidth.Strings = (
      'SATISFIY=83'
      'CARI_KOD=76'
      'CARI_AD=221'
      'SATISDOVKOD=54'
      'BIRIMORAN=41'
      'FIY_TIP=33')
    FieldsIndex.Strings = (
      'URUN_ID'
      'URUN_SID'
      'CARI_ID'
      'CARI_SID'
      'CARI_KOD'
      'CARI_AD'
      'FIY_TIP'
      'SATISDOVKOD'
      'SATISFIY'
      'BIRIMORAN')
    FieldsVisible.Strings = (
      'URUN_ID=FALSE'
      'URUN_SID=FALSE'
      'CARI_ID=FALSE'
      'CARI_SID=FALSE'
      'URUN_KOD=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT  URUN_KOD'
      '     , CARI_KOD'
      
        '     , (Select CARI.CARI_AD from CARI Where CARI.CARI_KOD=URUN_C' +
        'ARI_FIY.CARI_KOD ) as CARI_AD'
      '     , FIY_TIP'
      '     , SATISFIY'
      '     , SATISDOVKOD'
      '     , BIRIMORAN'
      'FROM URUN_CARI_FIY Where URUN_KOD=:PRM_URUN_KOD ')
    ColorScheme = False
    DefaultValues.Strings = (
      'FIY_TIP=1')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qry_FiyCariAfterInsert
    BeforeDelete = qry_FiyCariBeforeDelete
    BeforePost = qry_FiyCariBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 162
    Top = 298
    ParamValues = (
      'PRM_URUN_KOD=')
  end
  object qry_FiyCariDovKod: TIB_Query
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT DOVKOD'
      'FROM DOVKART')
    ColorScheme = False
    KeyLinks.Strings = (
      'DOVKART.DOVKOD=URUN_CARI_FIY.SATISDOVKOD')
    KeyDescLinks.Strings = (
      'DOVKART.DOVKOD=SATISDOVKOD')
    KeySource = dts_FiyCari
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItems.Strings = (
      'DOVKOD=DOVKOD;DOVKOD DESC')
    OrderingLinks.Strings = (
      'DOVKOD=ITEM=1')
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 162
    Top = 356
  end
  object dts_FiyCari: TIB_DataSource
    AutoInsert = False
    Dataset = qry_FiyCari
    OnStateChanged = dts_FiyCariStateChanged
    Left = 62
    Top = 282
  end
  object dts_FiyCariDovKod: TIB_DataSource
    Dataset = qry_FiyCariDovKod
    Left = 64
    Top = 340
  end
  object dts_FiyCGroup: TIB_DataSource
    AutoInsert = False
    Dataset = qry_FiyCGroup
    Left = 338
    Top = 118
  end
  object qry_FiyCGroup: TIB_Query
    ColumnAttributes.Strings = (
      'FIY_TIP=BOOLEAN=1,0;REQUIRED')
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    FieldsDisplayLabel.Strings = (
      'CG_KOD=Cari Grup Kodu'
      'CG_ADI=Cari Grup Ad'#305
      'SATISFIY=Sat'#305#351' Fiyat'#305' '
      'SATISDOVKOD=Para Birim'
      'BIRIMORAN=Oran'
      'FIY_TIP=Fiyat')
    FieldsDisplayWidth.Strings = (
      'CG_KOD=82'
      'CG_ADI=212'
      'FIY_TIP=33'
      'SATISDOVKOD=54'
      'SATISFIY=68'
      'BIRIMORAN=41')
    FieldsIndex.Strings = (
      'URUN_ID'
      'URUN_SID'
      'CARI_GRUP_ID'
      'CARI_GRUP_SID'
      'CG_KOD'
      'CG_ADI'
      'FIY_TIP'
      'SATISDOVKOD'
      'SATISFIY'
      'BIRIMORAN')
    FieldsVisible.Strings = (
      'URUN_ID=FALSE'
      'URUN_SID=FALSE'
      'CARI_GRUP_ID=FALSE'
      'CARI_GRUP_SID=FALSE'
      'CARI_GRUP_KOD=FALSE'
      'URUN_KOD=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT '
      '      URUN_KOD '
      '     ,  CARI_GRUP_KOD'
      
        '     , (Select CARI_GRUP.CGADI From CARI_GRUP where CARI_GRUP.CA' +
        'RI_GRUP_KOD = URUN_CGRUP_FIY.CARI_GRUP_KOD ) As CG_ADI'
      '     , SATISFIY'
      '     , SATISDOVKOD'
      '     , BIRIMORAN'
      '     , FIY_TIP'
      ''
      'FROM URUN_CGRUP_FIY Where URUN_KOD=:PRM_URUN_KOD ')
    ColorScheme = False
    DefaultValues.Strings = (
      'FIY_TIP=1')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qry_FiyCGroupAfterInsert
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 379
    Top = 171
    ParamValues = (
      'PRM_URUN_KOD=')
  end
  object qry_FiyCGroupDovKod: TIB_Query
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT DOVKOD'
      'FROM DOVKART')
    ColorScheme = False
    KeyLinks.Strings = (
      'DOVKART.DOVKOD=URUN_CGRUP_FIY.SATISDOVKOD')
    KeyDescLinks.Strings = (
      'DOVKART.DOVKOD=SATISDOVKOD')
    KeySource = dts_FiyCGroup
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItems.Strings = (
      'DOVKOD=DOVKOD;DOVKOD DESC')
    OrderingLinks.Strings = (
      'DOVKOD=ITEM=1')
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 381
    Top = 228
  end
  object dts_FiyCGroupDovKod: TIB_DataSource
    Dataset = qry_FiyCGroupDovKod
    OnStateChanged = dts_FiyCGroupDovKodStateChanged
    Left = 285
    Top = 206
  end
  object qry_Urun_Tedarik: TIB_Query
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    FieldsDisplayFormat.Strings = (
      'FIYAT=#,##.00')
    FieldsDisplayLabel.Strings = (
      'URUN_KOD='#220'r'#252'n Kodu'
      'CARI_KOD=Cari Kod'
      'TEDARIK_SURESI=Tedarik S'#252'resi'
      'FIYAT=Fiyat'#305
      'ACIKLAMA=A'#231#305'klama'
      'CARI_ADI=Cari Ad'#305)
    FieldsDisplayWidth.Strings = (
      'TEDARIK_SURESI=73'
      'CARI_KOD=125'
      'FIYAT=106'
      'ACIKLAMA=267'
      'CARI_ADI=250')
    FieldsIndex.Strings = (
      'URUN_KOD'
      'CARI_KOD'
      'CARI_ADI'
      'TEDARIK_SURESI'
      'FIYAT'
      'ACIKLAMA')
    FieldsVisible.Strings = (
      'URUN_KOD=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT'
      '       URUN_KOD'
      '     , CARI_KOD'
      '     , TEDARIK_SURESI'
      '     , FIYAT'
      '     , ACIKLAMA'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE URUN_TEDARIK.CARI_KOD=CARI' +
        '.CARI_KOD) AS CARI_ADI    '
      'FROM URUN_TEDARIK'
      'WHERE'
      '  URUN_TEDARIK.URUN_KOD=:PRM_URUN_KOD     ')
    ColorScheme = False
    KeyLinks.Strings = (
      'URUN_TEDARIK.URUN_KOD'
      'URUN_TEDARIK.CARI_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qry_Urun_TedarikAfterInsert
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 380
    Top = 283
    ParamValues = (
      'PRM_URUN_KOD=')
  end
  object dts_Urun_Tedarik: TIB_DataSource
    AutoInsert = False
    Dataset = qry_Urun_Tedarik
    OnStateChanged = dts_Urun_TedarikStateChanged
    Left = 276
    Top = 283
  end
end
