object frmSiparis: TfrmSiparis
  Left = 110
  Top = 103
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'frmSiparis'
  ClientHeight = 460
  ClientWidth = 798
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
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgFAT_IRS: TPageControl
    Left = 0
    Top = 0
    Width = 798
    Height = 460
    ActivePage = tabFAT_IRS
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    TabStop = False
    OnChange = pgFAT_IRSChange
    OnChanging = pgFAT_IRSChanging
    object tabFAT_IRS: TTabSheet
      Caption = 'Siparis Bilgileri'
      object Label2: TLabel
        Left = 27
        Top = 41
        Width = 46
        Height = 13
        Caption = 'Seri / No:'
      end
      object Panel5: TPanel
        Left = 0
        Top = 399
        Width = 790
        Height = 30
        Align = alBottom
        TabOrder = 17
        TabStop = True
        OnDblClick = Panel5DblClick
        object btnAra: TBitBtn
          Left = 662
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
          Left = 723
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
          Top = 2
          Width = 92
          Height = 26
          Caption = 'Sil (CTRL + DEL)'
          TabOrder = 5
          OnClick = btnFaturaSilClick
        end
      end
      object txtFaturaDepoAD: TIB_Edit
        Left = 221
        Top = 225
        Width = 300
        Height = 21
        TabStop = False
        DataField = 'DEPO_AD'
        DataSource = dtsSiparis
        Enabled = False
        TabOrder = 15
      end
      object txtFaturaPlasiyerAD: TIB_Edit
        Left = 221
        Top = 248
        Width = 300
        Height = 21
        TabStop = False
        DataField = 'PLASIYER_AD'
        DataSource = dtsSiparis
        Enabled = False
        TabOrder = 16
      end
      object IB_Edit40: TIB_Edit
        Left = 76
        Top = 296
        Width = 445
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'ACIKLAMA'
        DataSource = dtsSiparis
        TabOrder = 12
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit40Exit
      end
      object txtFaturaProjeAD: TIB_Edit
        Left = 221
        Top = 271
        Width = 300
        Height = 21
        TabStop = False
        DataField = 'PROJE_AD'
        DataSource = dtsSiparis
        Enabled = False
        TabOrder = 19
      end
      object IB_Edit1: TIB_Edit
        Left = 76
        Top = 36
        Width = 49
        Height = 21
        DataField = 'FAT_IRS_SERI'
        DataSource = dtsSiparis
        TabOrder = 0
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        OnKeyPress = IB_Edit1KeyPress
      end
      object IB_Edit3: TIB_Edit
        Left = 124
        Top = 36
        Width = 96
        Height = 21
        DataField = 'BELGE_NO'
        DataSource = dtsSiparis
        TabOrder = 1
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit3Exit
        OnKeyPress = IB_Edit1KeyPress
      end
      object IB_Date1: TIB_Date
        Left = 76
        Top = 84
        Width = 100
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'TARIH'
        DataSource = dtsSiparis
        TabOrder = 4
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object cmbFATURA_TIP: TIB_ComboBox
        Left = 260
        Top = 195
        Width = 144
        Height = 19
        AutoLabel.Kind = albLeft
        DataField = 'FAT_IRS_TIP'
        DataSource = dtsSiparis
        Visible = False
        TabOrder = 6
        OnExit = IB_Edit1Exit
        Style = csOwnerDrawVariable
        ItemHeight = 13
        Items.Strings = (
          'A'#199'IK'
          'KAPALI')
        ItemValues.Strings = (
          '2'
          '1')
      end
      object IB_Date2: TIB_Date
        Left = 76
        Top = 152
        Width = 100
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'VADE_TARIH'
        DataSource = dtsSiparis
        TabOrder = 7
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_Edit9: TIB_Edit
        Left = 76
        Top = 176
        Width = 49
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'VADE_GUN'
        DataSource = dtsSiparis
        ReadOnly = True
        TabOrder = 8
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_Date4: TIB_Date
        Left = 76
        Top = 107
        Width = 100
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'DOV_BAZ_TAR'
        DataSource = dtsSiparis
        TabOrder = 5
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object txtCariKod: TIB_Edit
        Left = 76
        Top = 59
        Width = 145
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'CARI_KOD'
        DataSource = dtsSiparis
        TabOrder = 3
        OnEnter = txtCariKodEnter
        OnExit = txtCariKodExit
        OnKeyPress = txtCariKodKeyPress
        OnKeyUp = txtCariKodKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtCariKodButtonClick
      end
      object txtFaturaDepoKod: TIB_Edit
        Left = 76
        Top = 225
        Width = 145
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'DEPO_KOD'
        DataSource = dtsSiparis
        TabOrder = 9
        OnEnter = txtFaturaDepoKodEnter
        OnExit = txtFaturaDepoKodExit
        OnKeyPress = txtCariKodKeyPress
        OnKeyUp = txtFaturaDepoKodKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtFaturaDepoKodButtonClick
      end
      object txtPlasiyerKod: TIB_Edit
        Left = 76
        Top = 248
        Width = 145
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'PLASIYER_KOD'
        DataSource = dtsSiparis
        TabOrder = 10
        OnEnter = txtPlasiyerKodEnter
        OnExit = txtPlasiyerKodExit
        OnKeyPress = txtCariKodKeyPress
        OnKeyUp = txtPlasiyerKodKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtPlasiyerKodButtonClick
      end
      object txtProjeKod: TIB_Edit
        Left = 76
        Top = 271
        Width = 145
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'PROJE_KOD'
        DataSource = dtsSiparis
        TabOrder = 11
        OnEnter = txtProjeKodEnter
        OnExit = txtProjeKodExit
        OnKeyPress = txtCariKodKeyPress
        OnKeyUp = txtProjeKodKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtProjeKodButtonClick
      end
      object IB_Edit2: TIB_Edit
        Left = 76
        Top = 12
        Width = 144
        Height = 21
        AutoLabel.Kind = albLeft
        AutoLabel.Caption = 'FIS NO'
        DataField = 'FAT_IRS_ID'
        DataSource = dtsSiparis
        Enabled = False
        TabOrder = 2
        OnExit = IB_Edit1Exit
      end
      object IB_CheckBox1: TIB_CheckBox
        Left = 686
        Top = 327
        Width = 97
        Height = 17
        DataField = 'YAZILDI'
        DataSource = dtsSiparis
        BorderStyle = bsNone
        PreventEditing = True
        ReadOnly = True
        TabOrder = 20
        Caption = 'Yazd'#305'r'#305'ld'#305
      end
      object rgYAZICI: TRadioGroup
        Left = 682
        Top = 222
        Width = 101
        Height = 69
        Caption = 'Yazd'#305'rma'
        ItemIndex = 2
        Items.Strings = (
          'Yazd'#305'r'
          #214'n '#304'zleme'
          'Sadece Kay'#305't')
        TabOrder = 21
      end
      object IB_Edit26: TIB_Edit
        Left = 76
        Top = 320
        Width = 445
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'YEV_ACIKLAMA'
        DataSource = dtsSiparis
        Visible = False
        TabOrder = 13
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object btnCikti: TButton
        Left = 682
        Top = 293
        Width = 100
        Height = 25
        Caption = 'Yaz'#305'c'#305' '#199#305'kt'#305's'#305
        TabOrder = 22
        TabStop = False
        OnClick = btnCiktiClick
      end
      object grpBoxCari: TGroupBox
        Left = 318
        Top = 7
        Width = 465
        Height = 194
        Caption = 'Cari Bilgiler'
        TabOrder = 18
        Visible = False
        object Label4: TLabel
          Left = 39
          Top = 14
          Width = 36
          Height = 13
          Caption = 'Cari Ad'#305
        end
        object lblCariAD: TLabel
          Tag = 1
          Left = 80
          Top = 11
          Width = 350
          Height = 17
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object lblYETKISI: TLabel
          Tag = 1
          Left = 80
          Top = 29
          Width = 350
          Height = 17
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object Label7: TLabel
          Left = 46
          Top = 32
          Width = 28
          Height = 13
          Caption = 'Yetkili'
        end
        object Label6: TLabel
          Left = 5
          Top = 49
          Width = 71
          Height = 13
          Caption = 'Vergi Daire\No'
        end
        object lblVNO: TLabel
          Tag = 1
          Left = 334
          Top = 48
          Width = 95
          Height = 17
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object lblVDAIRE: TLabel
          Tag = 1
          Left = 80
          Top = 48
          Width = 246
          Height = 17
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object Adres: TLabel
          Left = 49
          Top = 67
          Width = 27
          Height = 13
          Caption = 'Adres'
        end
        object lblADRES_1: TLabel
          Tag = 1
          Left = 80
          Top = 66
          Width = 350
          Height = 17
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object lblADRES_2: TLabel
          Tag = 1
          Left = 80
          Top = 85
          Width = 350
          Height = 17
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object lblILCE: TLabel
          Tag = 1
          Left = 80
          Top = 104
          Width = 166
          Height = 17
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object lblSEHIR: TLabel
          Tag = 1
          Left = 80
          Top = 123
          Width = 166
          Height = 17
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object lblPOSTA_KOD: TLabel
          Tag = 1
          Left = 80
          Top = 142
          Width = 165
          Height = 16
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object Label1: TLabel
          Left = 60
          Top = 106
          Width = 17
          Height = 13
          Caption = #304'l'#231'e'
        end
        object Label14: TLabel
          Left = 53
          Top = 124
          Width = 24
          Height = 13
          Caption = #350'ehir'
        end
        object Label38: TLabel
          Left = 22
          Top = 143
          Width = 55
          Height = 13
          Caption = 'Posta Kodu'
        end
      end
      object grpRapKod: TGroupBox
        Left = 75
        Top = 343
        Width = 556
        Height = 50
        TabOrder = 14
        object IB_Edit5: TIB_Edit
          Left = 16
          Top = 21
          Width = 83
          Height = 21
          AutoLabel.Kind = albTop
          AutoLabel.Caption = #304#351'lem Merkezi'
          DataField = 'MASRAF_MERK'
          DataSource = dtsSiparis
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
          DataSource = dtsSiparis
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
          DataSource = dtsSiparis
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
          DataSource = dtsSiparis
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
          DataSource = dtsSiparis
          TabOrder = 4
          OnEnter = IB_Edit25Enter
          OnExit = IB_Edit25Exit
          OnKeyUp = IB_Edit25KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit25ButtonClick
        end
      end
      object grpBoxMuhtelif: TGroupBox
        Left = 234
        Top = 5
        Width = 543
        Height = 196
        Caption = 'Cari Bilgiler'
        TabOrder = 23
        Visible = False
        object IB_Edit8: TIB_Edit
          Left = 65
          Top = 12
          Width = 400
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'CARI_AD'
          DataSource = dtsFAT_IRS_MUH_CARI
          TabOrder = 0
        end
        object IB_Edit10: TIB_Edit
          Left = 65
          Top = 35
          Width = 400
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'YETKISI'
          DataSource = dtsFAT_IRS_MUH_CARI
          TabOrder = 1
        end
        object IB_Edit11: TIB_Edit
          Left = 65
          Top = 57
          Width = 140
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'VERDAIRE'
          DataSource = dtsFAT_IRS_MUH_CARI
          TabOrder = 2
        end
        object IB_Edit12: TIB_Edit
          Left = 65
          Top = 78
          Width = 400
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ADRES_1'
          DataSource = dtsFAT_IRS_MUH_CARI
          TabOrder = 3
        end
        object IB_Edit13: TIB_Edit
          Left = 65
          Top = 101
          Width = 400
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ADRES_2'
          DataSource = dtsFAT_IRS_MUH_CARI
          TabOrder = 4
        end
        object IB_Edit14: TIB_Edit
          Left = 250
          Top = 56
          Width = 161
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'VERNO'
          DataSource = dtsFAT_IRS_MUH_CARI
          TabOrder = 5
        end
        object IB_Edit15: TIB_Edit
          Left = 65
          Top = 123
          Width = 125
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ILCE'
          DataSource = dtsFAT_IRS_MUH_CARI
          TabOrder = 6
        end
        object IB_Edit16: TIB_Edit
          Left = 217
          Top = 123
          Width = 163
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'SEHIR'
          DataSource = dtsFAT_IRS_MUH_CARI
          TabOrder = 7
        end
        object IB_Edit17: TIB_Edit
          Left = 406
          Top = 123
          Width = 59
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'POSTA_KOD'
          DataSource = dtsFAT_IRS_MUH_CARI
          TabOrder = 8
        end
        object IB_Edit18: TIB_Edit
          Left = 64
          Top = 145
          Width = 119
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'TEL_NO_1'
          DataSource = dtsFAT_IRS_MUH_CARI
          TabOrder = 9
        end
        object IB_Edit19: TIB_Edit
          Left = 212
          Top = 145
          Width = 119
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'TEL_NO_2'
          DataSource = dtsFAT_IRS_MUH_CARI
          TabOrder = 10
        end
        object IB_Edit20: TIB_Edit
          Left = 354
          Top = 145
          Width = 111
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'FAX'
          DataSource = dtsFAT_IRS_MUH_CARI
          TabOrder = 11
        end
        object IB_Edit21: TIB_Edit
          Left = 65
          Top = 167
          Width = 400
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'E_MAIL'
          DataSource = dtsFAT_IRS_MUH_CARI
          TabOrder = 12
        end
        object btnMuhtelifIptal: TButton
          Left = 464
          Top = 167
          Width = 75
          Height = 20
          Caption = #304'ptal'
          TabOrder = 13
          OnClick = btnMuhtelifIptalClick
        end
      end
    end
    object tabKalem: TTabSheet
      Caption = 'Kalem Bilgileri'
      ImageIndex = 1
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 790
        Height = 25
        Align = alTop
        TabOrder = 0
        object Label18: TLabel
          Left = 363
          Top = 3
          Width = 36
          Height = 13
          Caption = 'Cari Ad'#305
        end
        object Label19: TLabel
          Left = 237
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
          Width = 33
          Height = 13
          DataField = 'FAT_IRS_SERI'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text2: TIB_Text
          Left = 88
          Top = 3
          Width = 56
          Height = 13
          DataField = 'BELGE_NO'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text3: TIB_Text
          Left = 170
          Top = 3
          Width = 65
          Height = 13
          DataField = 'TARIH'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object Label21: TLabel
          Left = 143
          Top = 3
          Width = 24
          Height = 13
          Caption = 'Tarih'
        end
        object IB_Text4: TIB_Text
          Left = 286
          Top = 3
          Width = 77
          Height = 13
          DataField = 'CARI_KOD'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text5: TIB_Text
          Left = 403
          Top = 3
          Width = 314
          Height = 13
          DataField = 'CARI_AD'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 399
        Width = 790
        Height = 30
        Align = alBottom
        TabOrder = 1
        object IB_Text22: TIB_Text
          Left = 627
          Top = 6
          Width = 116
          Height = 17
          DataField = 'BRUT_TOP'
          DataSource = dtsSiparis
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
        Top = 25
        Width = 790
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
          Left = 638
          Top = 112
          Width = 97
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
          DataSource = dstSiparis_D
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
          DataSource = dstSiparis_D
          Enabled = False
          TabOrder = 1
          OnExit = IB_Edit1Exit
        end
        object txtOlcuBirim: TIB_Edit
          Left = 45
          Top = 51
          Width = 121
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'OLCUBIRIM'
          DataSource = dstSiparis_D
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
          DataSource = dstSiparis_D
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
          DataSource = dstSiparis_D
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
          DataSource = dstSiparis_D
          Enabled = False
          TabOrder = 9
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object IB_Currency1: TIB_Currency
          Left = 545
          Top = 51
          Width = 112
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'TUTAR_VPB'
          DataSource = dstSiparis_D
          Enabled = False
          TabOrder = 10
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
          CalculatorKind = cucInline
        end
        object IB_Edit22: TIB_Edit
          Left = 656
          Top = 51
          Width = 39
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KDV'
          DataSource = dstSiparis_D
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
          DataSource = dstSiparis_D
          TabOrder = 2
          OnEnter = txtDepoKodEnter
          OnExit = txtDepoKodExit
          OnKeyPress = txtUrunKoduKeyPress
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
          DataSource = dstSiparis_D
          Enabled = False
          TabOrder = 8
          OnExit = IB_Edit1Exit
        end
        object rdIskonto: TIB_RadioGroup
          Left = 5
          Top = 87
          Width = 103
          Height = 22
          DataField = 'ISKONTO_TIP'
          DataSource = dstSiparis_D
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
          DataSource = dstSiparis_D
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
          DataSource = dstSiparis_D
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
          DataSource = dstSiparis_D
          Enabled = False
          TabOrder = 15
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
          DataSource = dstSiparis_D
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
          DataSource = dstSiparis_D
          Enabled = False
          TabOrder = 21
          OnExit = IB_Edit1Exit
        end
        object IB_Currency7: TIB_Currency
          Left = 4
          Top = 51
          Width = 39
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'MIKTAR'
          DataSource = dstSiparis_D
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
          DataSource = dstSiparis_D
          TabOrder = 6
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
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
        Top = 163
        Width = 790
        Height = 236
        TabStop = False
        CustomGlyphsSupplied = []
        DataSource = dstSiparis_D
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
        Left = 7
        Top = 12
        Width = 234
        Height = 281
        Caption = 'Sipari'#351' Bilgileri'
        TabOrder = 0
        object Label5: TLabel
          Left = 31
          Top = 179
          Width = 62
          Height = 13
          Caption = 'KDV Toplam'#305
        end
        object lblTOP_PAG_KAL_ISK_TOP: TLabel
          Left = 22
          Top = 41
          Width = 72
          Height = 13
          Caption = 'Kal. '#304's. Toplam'#305
        end
        object Label9: TLabel
          Left = 36
          Top = 17
          Width = 57
          Height = 13
          Caption = 'Br'#252't Toplam'
        end
        object Label10: TLabel
          Left = 38
          Top = 158
          Width = 55
          Height = 13
          Caption = 'Net Toplam'
        end
        object Label11: TLabel
          Left = 28
          Top = 224
          Width = 66
          Height = 13
          Caption = 'Genel Toplam'
        end
        object IB_Text15: TIB_Text
          Left = 96
          Top = 16
          Width = 122
          Height = 17
          DataField = 'BRUT_TOP'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object txtTOP_PAG_KAL_ISK_TOP: TIB_Text
          Left = 96
          Top = 40
          Width = 122
          Height = 17
          DataField = 'KALEM_ISKONTO_TOPLAM_VPB'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text17: TIB_Text
          Left = 96
          Top = 157
          Width = 122
          Height = 17
          DataField = 'NET_TOP'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text18: TIB_Text
          Left = 96
          Top = 178
          Width = 122
          Height = 17
          DataField = 'KDV_TOP'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text19: TIB_Text
          Left = 96
          Top = 224
          Width = 122
          Height = 17
          DataField = 'GENEL_TOP'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object Label35: TLabel
          Left = 36
          Top = 63
          Width = 55
          Height = 13
          Caption = #304'skonto Tipi'
          Visible = False
        end
        object IB_Text21: TIB_Text
          Left = 96
          Top = 136
          Width = 122
          Height = 17
          DataField = 'ISKONTO_TOPLAM_VPB'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object Label36: TLabel
          Left = 19
          Top = 136
          Width = 75
          Height = 13
          Caption = #304'skonto Toplam'#305
        end
        object rdFatIsTip: TIB_RadioGroup
          Left = 96
          Top = 60
          Width = 122
          Height = 22
          DataField = 'ISKONTO_TIP'
          DataSource = dtsSiparis
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
          Left = 96
          Top = 86
          Width = 33
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ISKONTO_ORAN'
          DataSource = dtsSiparis
          Visible = False
          TabOrder = 1
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object txtFatIskontoTutar: TIB_Currency
          Left = 96
          Top = 112
          Width = 122
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ISKONTO_TUTAR_VPB'
          DataSource = dtsSiparis
          Visible = False
          TabOrder = 2
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object IB_Currency6: TIB_Currency
          Left = 96
          Top = 197
          Width = 121
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'OTV'
          DataSource = dtsSiparis
          TabOrder = 3
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object txtKasaKod: TIB_Edit
          Left = 96
          Top = 248
          Width = 121
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'KASA_KOD'
          DataSource = dtsSiparis
          Visible = False
          TabOrder = 4
          OnEnter = txtKasaKodEnter
          OnExit = txtKasaKodExit
          OnKeyPress = txtUrunKoduKeyPress
          OnKeyUp = txtKasaKodKeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = txtKasaKodButtonClick
        end
      end
      object GroupBox3: TGroupBox
        Left = 248
        Top = 12
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
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text7: TIB_Text
          Left = 99
          Top = 16
          Width = 121
          Height = 17
          DataField = 'KDV1'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text8: TIB_Text
          Left = 38
          Top = 63
          Width = 19
          Height = 17
          DataField = 'KDV3_ORAN'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text9: TIB_Text
          Left = 38
          Top = 40
          Width = 19
          Height = 17
          DataField = 'KDV2_ORAN'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text10: TIB_Text
          Left = 99
          Top = 40
          Width = 121
          Height = 17
          DataField = 'KDV2'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text11: TIB_Text
          Left = 38
          Top = 87
          Width = 19
          Height = 17
          DataField = 'KDV4_ORAN'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text12: TIB_Text
          Left = 99
          Top = 63
          Width = 121
          Height = 17
          DataField = 'KDV3'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text13: TIB_Text
          Left = 99
          Top = 87
          Width = 121
          Height = 17
          DataField = 'KDV4'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text14: TIB_Text
          Left = 99
          Top = 111
          Width = 121
          Height = 17
          DataField = 'KDV5'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text20: TIB_Text
          Left = 38
          Top = 111
          Width = 19
          Height = 17
          DataField = 'KDV5_ORAN'
          DataSource = dtsSiparis
          Color = clInfoBk
          ParentColor = False
        end
        object IB_Text23: TIB_Text
          Left = 99
          Top = 133
          Width = 121
          Height = 17
          DataField = 'KDV_TOP'
          DataSource = dtsSiparis
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
      object txtKasaAd: TIB_Edit
        Left = 293
        Top = 256
        Width = 283
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'KASA_AD'
        DataSource = dtsSiparis
        Visible = False
        TabOrder = 2
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
    end
  end
  object dtsSiparis: TIB_DataSource
    AutoInsert = False
    Dataset = qrySiparis
    OnDataChange = dtsSiparisDataChange
    OnStateChanged = dtsSiparisStateChanged
    Left = 156
    Top = 363
  end
  object qrySiparis: TIB_Query
    ColumnAttributes.Strings = (
      'YAZILDI=BOOLEAN=1,0')
    DatabaseName = 'c:\CedaLite\Trans_Db\Transport.FDB'
    FieldsDisplayFormat.Strings = (
      'BRUT_TOP=#,##.00'
      'NET_TOP=#,##'
      'GENEL_TOP=#,##'
      'KDV_TOP=#,##.'
      'KDV1=#,##'
      'KDV2=#,##'
      'KDV3=#,##'
      'KDV4=#,##'
      'KDV5=#,##'
      'OTV=#,##'
      'KALEM_ISKONTO_TOPLAM_VPB=#,##.00'
      'ISKONTO_TUTAR_VPB=#,##.00'
      'ISKONTO_TOPLAM_VPB=#,##.00')
    FieldsDisplayLabel.Strings = (
      'KASA_AD=Kasa Ad'#305
      'CARI_AD=Cari Ad'#305
      'DEPO_AD=Depo Ad'#305
      'PLASIYER_AD=Plasiyer Ad'#305
      'PROJE_KOD=Proje Kodu'
      'PROJE_AD=Proje Ad'#305
      'YEV_ACIKLAMA=Yevmiye ACK'
      'VADE_GUN=Teslim G'#252'n'#252
      'VADE_TARIH=Teslim Tarihi'
      'FAT_IRS_TIP=Sipari'#351' Tipi'
      'DOV_BAZ_TAR=D'#246'v.Baz.Tarihi'
      'KASA_KOD=Kasa Kodu'
      'DEPO_KOD=Depo Kodu'
      'PLASIYER_KOD=Plasiyer Kodu'
      'ACIKLAMA=A'#231#305'klama'
      'TARIH='#304#351'lem Tarihi'
      'CARI_KOD=Cari Kodu'
      'KDV1_ORAN=Tutar'
      'KDV2_ORAN=Tutar'
      'KDV3_ORAN=Tutar'
      'KDV4_ORAN=Tutar'
      'KDV5_ORAN=Tutar'
      'ISKONTO_TUTAR_VPB='#304'skonto Tutar'#305
      'ISKONTO_ORAN='#304'skonto Oran'#305
      'OTV='#214'TV')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    SQL.Strings = (
      'SELECT '
      '       FAT_IRS_SEP'
      '     , FAT_IRS_ID'
      '     , FAT_IRS_SID'
      '     , CARI_KOD'
      '     , FAT_IRS_SERI'
      '     , BELGE_NO'
      '     , TARIH'
      '     , REF_BELGE_TUR'
      '     , REF_BELGE_ID'
      '     , REF_BELGE_SID'
      '     , ACIKLAMA'
      '     , BRUT_TOP'
      '     , NET_TOP'
      '     , GENEL_TOP'
      '     , KDV_TOP'
      '     , TIP'
      '     , YAZILDI'
      '     , IPTAL'
      '     , PLASIYER_KOD  '
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
      '     , FAT_IRS_TIP'
      '     , KDV1_ORAN'
      '     , KDV2_ORAN'
      '     , KDV3_ORAN'
      '     , KDV4_ORAN'
      '     , KDV5_ORAN'
      '     , DOV_BAZ_TAR'
      '     , MUHTELIF'
      '     , KASA_KOD'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4      '
      
        '     , (Select KASA.ACIKLAMA From KASA where KASA.KASA_KOD=SIPAR' +
        'IS.KASA_KOD) as KASA_AD'
      
        '     , (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=SIPARI' +
        'S.CARI_KOD) As CARI_AD   '
      
        '     , (Select DEPO.ADI From DEPO Where DEPO.DEPO_KOD=SIPARIS.DE' +
        'PO_KOD ) As DEPO_AD'
      
        '     , (Select PLASIYER.ADISOY from PLASIYER Where PLASIYER.PLAS' +
        'IYER_KOD=SIPARIS.PLASIYER_KOD) AS PLASIYER_AD'
      '     , PROJE_KOD'
      
        '     , (Select PROJE.PROJE_AD From PROJE Where PROJE.PROJE_KOD=S' +
        'IPARIS.PROJE_KOD) As PROJE_AD'
      '     , YEV_ACIKLAMA'
      'FROM SIPARIS'
      
        'WHERE FAT_IRS_SEP=:PRM_FAT_IRS_SEP AND FAT_IRS_ID=:PRM_FAT_IRS_I' +
        'D AND FAT_IRS_SID=:PRM_FAT_IRS_SID')
    ColorScheme = False
    DefaultValues.Strings = (
      'KDV1=0'
      'KDV2=0'
      'KDV3=0'
      'KDV4=0'
      'KDV5=0'
      'OTV=0'
      'YAZILDI=0'
      'IPTAL=0'
      'REF_BELGE_ID=0')
    KeyLinks.Strings = (
      'SIPARIS.FAT_IRS_SEP'
      'SIPARIS.FAT_IRS_ID'
      'SIPARIS.FAT_IRS_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qrySiparisAfterInsert
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 156
    Top = 307
    ParamValues = (
      'PRM_FAT_IRS_SEP=0')
  end
  object dstSiparis_D: TIB_DataSource
    AutoInsert = False
    Dataset = qrySiparis_D
    OnDataChange = dstSiparis_DDataChange
    OnStateChanged = dstSiparis_DStateChanged
    Left = 252
    Top = 355
  end
  object qrySiparis_D: TIB_Query
    DatabaseName = 'c:\CedaLite\Trans_Db\Transport.FDB'
    FieldsDisplayFormat.Strings = (
      'ISKONTO_ORAN=#,##.00'
      'ISKONTO_TUTAR=#,##.00'
      'ISKONTO_TUTAR_VPB=#,##.00'
      'KDV=#,##.00'
      'KDV_TUTAR=#,##.00'
      'BIRIM_FIY=#,##.00'
      'BIRIM_FIY_VPB=#,##.00'
      'BIRIM_FIY_URN_DOVKOD=#,##.00'
      'DOVKUR=#,##.00'
      'TUTAR=#,##.00'
      'TUTAR_VPB=#,##.00'
      'URUN_DOVKOD=#,##.00'
      'TUTAR_URUN_DOVKOD=#,##.00'
      'MIKTAR=#,##.00'
      'MIKTAR_URN_OB=#,##.00'
      'TARIH=Tarihi'
      'DOV_BAZ_TAR=D'#246'viz Baz Tarihi'
      'BELGE_TUR=Belge T'#252'r'#252)
    FieldsDisplayLabel.Strings = (
      'TUTAR=Tutar'
      'MIKTAR=Miktar'#305
      'BIRIM_FIY=Birim Fiyat'#305
      'ISKONTO_ORAN='#304's.Or.'
      'ISKONTO_TUTAR='#304'skonto Tutar'#305
      'DEPO_AD=Depo Ad'#305
      'ISKONTO_TUTAR_VPB='#304'skonto Tutar Vpb'
      'DEPO_KOD=Depo kodu'
      'TUTAR_VPB=Tutar Vbp'
      'KDV=Kdv'
      'KDV_TUTAR=Kdv Tutar'#305
      'ACIKLAMA=A'#231#305'klama'
      'DOVKOD=D'#246'viz Kodu'
      'DOVKUR=D'#246'viz Kuru'
      'URUN_KOD='#220'r'#252'n kodu'
      'URUN_AD='#220'r'#252'n Ad'#305
      'OLCUBIRIM='#214'l'#231#252' Birim')
    FieldsDisplayWidth.Strings = (
      'URUN_KOD=92'
      'OLCUBIRIM=73'
      'MIKTAR=74'
      'TUTAR=86'
      'TUTAR_VPB=86'
      'ACIKLAMA=139')
    FieldsIndex.Strings = (
      'URUNHAR_ID'
      'URUNHAR_SID'
      'TARIH'
      'FIILI_TAR'
      'DOV_BAZ_TAR'
      'URUN_KOD'
      'URUN_AD'
      'ACIKLAMA'
      'TIP'
      'BELGE_TUR'
      'BELGE_ID'
      'BELGE_SID'
      'BELGE_SIRA_NO'
      'OLCUBIRIM_URN_OB'
      'BIRIM_FIY'
      'MIKTAR'
      'OLCUBIRIM'
      'MIKTAR_URN_OB'
      'DOVKOD'
      'DOVKUR'
      'TUTAR'
      'TUTAR_VPB'
      'URUN_DOVKOD'
      'TUTAR_URUN_DOVKOD'
      'BIRIM_FIY_VPB'
      'BIRIM_FIY_URN_DOVKOD'
      'ISKONTO_TIP'
      'ISKONTO_ORAN'
      'ISKONTO_TUTAR'
      'ISKONTO_TUTAR_VPB'
      'DEPO_KOD'
      'DEPO_AD'
      'FATURA_ID'
      'FATURA_SID'
      'IRSALIYE_ID'
      'IRSALIYE_SID'
      'MASRAF_MERK'
      'KDV'
      'KDV_TUTAR'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4')
    FieldsVisible.Strings = (
      'URUNHAR_ID=FALSE'
      'URUNHAR_SID=FALSE'
      'TARIH=FALSE'
      'DOV_BAZ_TAR=FALSE'
      'FATURA_ID=FALSE'
      'FATURA_SID=FALSE'
      'IRSALIYE_ID=FALSE'
      'IRSALIYE_SID=FALSE'
      'BELGE_TUR=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE'
      'BELGE_SIRA_NO=FALSE'
      'OLCUBIRIM=TRUE'
      'OLCUBIRIM_URN_OB=FALSE'
      'FIILI_TAR=FALSE'
      'KOD1=FALSE'
      'KOD2=FALSE'
      'KOD3=FALSE'
      'KOD4=FALSE'
      'URUN_AD=FALSE'
      'TUTAR_URUN_DOVKOD=FALSE'
      'URUN_DOVKOD=FALSE'
      'MASRAF_MERK=FALSE'
      'TIP=FALSE'
      'BIRIM_FIY_VPB=FALSE'
      'BIRIM_FIY_URN_DOVKOD=FALSE'
      'MIKTAR_URN_OB=FALSE'
      'ISKONTO_TIP=FALSE'
      'ISKONTO_ORAN=FALSE'
      'ISKONTO_TUTAR=FALSE'
      'ISKONTO_TUTAR_VPB=FALSE'
      'KDV=FALSE'
      'KDV_TUTAR=FALSE'
      'DOVKUR=FALSE'
      'DEPO_KOD=FALSE'
      'DEPO_AD=FALSE'
      'FAT_IRS_SEP=FALSE'
      'KAPANDI=FALSE'
      'AKTARILAN_MIKTAR=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    SQL.Strings = (
      'SELECT URUNHAR_ID'
      '     , URUNHAR_SID'
      '     , TARIH'
      '     , FIILI_TAR'
      '     , DOV_BAZ_TAR'
      '     , URUN_KOD'
      
        '     , (SELECT  URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD=SIPAR' +
        'IS_D.URUN_KOD) AS URUN_AD'
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
      
        '     , (SELECT DEPO.ADI FROM DEPO WHERE DEPO.DEPO_KOD = SIPARIS_' +
        'D.DEPO_KOD) AS DEPO_AD'
      '     , FAT_IRS_SEP'
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
      '     , KAPANDI'
      '     , AKTARILAN_MIKTAR'
      'FROM SIPARIS_D'
      'WHERE FATURA_ID=:PRM_FATURA_ID And FATURA_SID=:PRM_FATURA_SID'
      'ORDER BY URUNHAR_ID;')
    ColorScheme = False
    KeyLinks.Strings = (
      'SIPARIS_D.URUNHAR_ID'
      'SIPARIS_D.URUNHAR_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterDelete = qrySiparis_DAfterDelete
    AfterInsert = qrySiparis_DAfterInsert
    AfterPost = qrySiparis_DAfterPost
    BeforePost = qrySiparis_DBeforePost
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 252
    Top = 307
    ParamValues = (
      'PRM_FATURA_ID=0')
  end
  object trnFAT_IRS: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 148
    Top = 202
  end
  object qry_Siparis_Fat: TIB_Query
    DatabaseName = 'c:\CedaLite\Trans_Db\Transport.FDB'
    IB_Connection = DataMod.dbaMain
    IB_Transaction = frmFAT_IRS.trnFAT_IRS
    SQL.Strings = (
      'SELECT SIPARIS_D_FAT_ID'
      '     , SIPARIS_ID'
      '     , SIPARISD_ID'
      '     , MIKTAR'
      '     , FATURA_ID'
      '     , FATURAD_ID'
      'FROM SIPARIS_D_FAT'
      'WHERE SIPARIS_ID=:SIPARIS_ID AND SIPARISD_ID=:SIPARISD_ID')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 408
    Top = 319
  end
  object qryFAT_IRS_MUH_CARI: TIB_Query
    DatabaseName = 'c:\CedaLite\Trans_Db\Transport.FDB'
    FieldsDisplayLabel.Strings = (
      'CARI_AD=Cari Ad'#305
      'YETKISI=Yetkilisi'
      'VERDAIRE=V. Dairesi'
      'VERNO=V. Nosu'
      'ADRES_1=Adres 1'
      'ADRES_2=Adres 2'
      'ILCE='#304'l'#231'e'
      'SEHIR='#350'ehir'
      'POSTA_KOD=P.K.'
      'TEL_NO_1=Tel 1'
      'TEL_NO_2=Tel 2'
      'FAX=Fax'
      'E_MAIL=E-Mail')
    FieldsVisible.Strings = (
      'FATURA_ID=FALSE'
      'FATURA_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    SQL.Strings = (
      'SELECT FAT_IRS_SEP'
      '     , FAT_IRS_ID'
      '     , FAT_IRS_SID'
      '     , CARI_AD'
      '     , YETKISI'
      '     , VERDAIRE'
      '     , VERNO'
      '     , ADRES_1'
      '     , ADRES_2'
      '     , ILCE'
      '     , SEHIR'
      '     , POSTA_KOD'
      '     , TEL_NO_1'
      '     , TEL_NO_2'
      '     , FAX'
      '     , E_MAIL'
      'FROM FAT_IRS_MUH_CARI '
      'WHERE FAT_IRS_SEP=:PRM_FAT_IRS_SEP AND '
      '      FAT_IRS_ID=:PRM_FAT_IRS_ID AND '
      '      FAT_IRS_SID=:PRM_FAT_IRS_SID;')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 590
    Top = 243
    ParamValues = (
      'PRM_FAT_IRS_SEP=0')
  end
  object dtsFAT_IRS_MUH_CARI: TIB_DataSource
    Dataset = qryFAT_IRS_MUH_CARI
    Left = 588
    Top = 301
  end
end
