object frmFAT_IRS: TfrmFAT_IRS
  Left = 124
  Top = 121
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Fatura / Irsaliye'
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
      Caption = 'Fatura Bilgileri'
      PopupMenu = PopupMenu1
      object Label2: TLabel
        Left = 27
        Top = 41
        Width = 46
        Height = 13
        Caption = 'Seri / No:'
      end
      object grpBoxMuhtelif: TGroupBox
        Left = 234
        Top = 5
        Width = 543
        Height = 196
        Caption = 'Cari Bilgiler'
        TabOrder = 20
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
      object Panel5: TPanel
        Left = 0
        Top = 401
        Width = 782
        Height = 30
        Align = alBottom
        TabOrder = 18
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
          Left = 91
          Top = 3
          Width = 119
          Height = 25
          Caption = 'Kaydet ( CTRL + END)'
          TabOrder = 0
          OnClick = btnTRN_KAYDETClick
        end
        object btnTRN_IPTAL: TButton
          Left = 209
          Top = 3
          Width = 108
          Height = 25
          Caption = 'Iptal (CTRL + A)'
          TabOrder = 4
          OnClick = btnTRN_IPTALClick
        end
        object btnFaturaSil: TBitBtn
          Left = 320
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
          Caption = '&'#214'nceki Fatura'
          TabOrder = 6
          OnClick = Btn_OncekiClick
        end
        object Btn_Sonraki: TBitBtn
          Left = 503
          Top = 3
          Width = 75
          Height = 25
          Caption = '&Sonraki Fatura'
          TabOrder = 7
          OnClick = Btn_SonrakiClick
        end
      end
      object txtFaturaDepoAD: TIB_Edit
        Left = 221
        Top = 225
        Width = 300
        Height = 21
        TabStop = False
        DataField = 'DEPO_AD'
        DataSource = dtsFAT_IRS
        Enabled = False
        TabOrder = 16
      end
      object txtFaturaPlasiyerAD: TIB_Edit
        Left = 221
        Top = 248
        Width = 300
        Height = 21
        TabStop = False
        DataField = 'PLASIYER_AD'
        DataSource = dtsFAT_IRS
        Enabled = False
        TabOrder = 17
      end
      object IB_Edit40: TIB_Edit
        Left = 76
        Top = 296
        Width = 445
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'ACIKLAMA'
        DataSource = dtsFAT_IRS
        TabOrder = 13
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
        DataSource = dtsFAT_IRS
        Enabled = False
        TabOrder = 21
      end
      object IB_Edit1: TIB_Edit
        Left = 76
        Top = 36
        Width = 49
        Height = 21
        DataField = 'FAT_IRS_SERI'
        DataSource = dtsFAT_IRS
        TabOrder = 0
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_Edit3: TIB_Edit
        Left = 124
        Top = 36
        Width = 96
        Height = 21
        DataField = 'BELGE_NO'
        DataSource = dtsFAT_IRS
        TabOrder = 1
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit3Exit
      end
      object IB_Date1: TIB_Date
        Left = 76
        Top = 108
        Width = 100
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'TARIH'
        DataSource = dtsFAT_IRS
        TabOrder = 5
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object cmbFATURA_TIP: TIB_ComboBox
        Left = 76
        Top = 155
        Width = 144
        Height = 19
        AutoLabel.Kind = albLeft
        DataField = 'FAT_IRS_TIP'
        DataSource = dtsFAT_IRS
        TabOrder = 7
        OnEnter = cmbFATURA_TIPEnter
        OnExit = cmbFATURA_TIPExit
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
        Top = 176
        Width = 100
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'VADE_TARIH'
        DataSource = dtsFAT_IRS
        TabOrder = 8
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_Edit9: TIB_Edit
        Left = 76
        Top = 200
        Width = 49
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'VADE_GUN'
        DataSource = dtsFAT_IRS
        ReadOnly = True
        TabOrder = 9
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_Date4: TIB_Date
        Left = 76
        Top = 131
        Width = 100
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'DOV_BAZ_TAR'
        DataSource = dtsFAT_IRS
        TabOrder = 6
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
        DataSource = dtsFAT_IRS
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
        DataSource = dtsFAT_IRS
        TabOrder = 10
        OnEnter = txtFaturaDepoKodEnter
        OnExit = txtFaturaDepoKodExit
        OnKeyPress = txtFaturaDepoKodKeyPress
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
        DataSource = dtsFAT_IRS
        TabOrder = 11
        OnEnter = txtPlasiyerKodEnter
        OnExit = txtPlasiyerKodExit
        OnKeyPress = txtPlasiyerKodKeyPress
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
        DataSource = dtsFAT_IRS
        TabOrder = 12
        OnEnter = txtProjeKodEnter
        OnExit = txtProjeKodExit
        OnKeyPress = txtProjeKodKeyPress
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
        AutoLabel.Caption = 'Fi'#351' No'
        DataField = 'FAT_IRS_ID'
        DataSource = dtsFAT_IRS
        Enabled = False
        TabOrder = 2
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_CheckBox1: TIB_CheckBox
        Left = 534
        Top = 327
        Width = 97
        Height = 17
        DataField = 'YAZILDI'
        DataSource = dtsFAT_IRS
        BorderStyle = bsNone
        PreventEditing = True
        ReadOnly = True
        TabOrder = 22
        Caption = 'Yazd'#305'r'#305'ld'#305
      end
      object rgYAZICI: TRadioGroup
        Left = 530
        Top = 222
        Width = 101
        Height = 69
        Caption = 'Yazd'#305'rma'
        ItemIndex = 2
        Items.Strings = (
          'Yazd'#305'r'
          #214'n '#304'zleme'
          'Sadece Kay'#305't')
        TabOrder = 23
      end
      object IB_Edit26: TIB_Edit
        Left = 76
        Top = 320
        Width = 445
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'YEV_ACIKLAMA'
        DataSource = dtsFAT_IRS
        Visible = False
        TabOrder = 14
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object btnCikti: TButton
        Left = 530
        Top = 293
        Width = 100
        Height = 25
        Caption = 'Yaz'#305'c'#305' '#199#305'kt'#305's'#305
        TabOrder = 24
        TabStop = False
        OnClick = btnCiktiClick
      end
      object grpBoxCari: TGroupBox
        Left = 238
        Top = 7
        Width = 465
        Height = 194
        Caption = 'Cari Bilgiler'
        TabOrder = 19
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
          Top = 30
          Width = 350
          Height = 17
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object Label7: TLabel
          Left = 46
          Top = 33
          Width = 28
          Height = 13
          Caption = 'Yetkili'
        end
        object Label6: TLabel
          Left = 5
          Top = 50
          Width = 71
          Height = 13
          Caption = 'Vergi Daire\No'
        end
        object lblVNO: TLabel
          Tag = 1
          Left = 334
          Top = 49
          Width = 95
          Height = 17
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object lblVDAIRE: TLabel
          Tag = 1
          Left = 80
          Top = 49
          Width = 246
          Height = 17
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object Adres: TLabel
          Left = 49
          Top = 69
          Width = 27
          Height = 13
          Caption = 'Adres'
        end
        object lblADRES_1: TLabel
          Tag = 1
          Left = 80
          Top = 68
          Width = 350
          Height = 17
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object lblADRES_2: TLabel
          Tag = 1
          Left = 80
          Top = 87
          Width = 350
          Height = 17
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object lblILCE: TLabel
          Tag = 1
          Left = 80
          Top = 106
          Width = 166
          Height = 17
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object lblSEHIR: TLabel
          Tag = 1
          Left = 80
          Top = 125
          Width = 166
          Height = 17
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object lblPOSTA_KOD: TLabel
          Tag = 1
          Left = 80
          Top = 144
          Width = 166
          Height = 16
          AutoSize = False
          Color = clInfoBk
          ParentColor = False
        end
        object Label1: TLabel
          Left = 60
          Top = 108
          Width = 17
          Height = 13
          Caption = #304'l'#231'e'
        end
        object Label14: TLabel
          Left = 53
          Top = 126
          Width = 24
          Height = 13
          Caption = #350'ehir'
        end
        object Label38: TLabel
          Left = 22
          Top = 145
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
        TabOrder = 15
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
      object Btn_Siparis_Secimi: TBitBtn
        Left = 648
        Top = 227
        Width = 97
        Height = 25
        Caption = 'Sipari'#351' Faturala'#351't'#305'r'
        TabOrder = 25
        OnClick = Btn_Siparis_SecimiClick
      end
      object BitBtn1: TBitBtn
        Left = 648
        Top = 251
        Width = 97
        Height = 25
        Caption = #304'rsaliye Faturala'#351't'#305'r'
        TabOrder = 26
        OnClick = BitBtn1Click
      end
      object Memo1: TMemo
        Left = 760
        Top = 288
        Width = 185
        Height = 89
        Lines.Strings = (
          'irsaliye fatura da ayn'#305' birle'#351'tirilmesi '
          'fatura siliminde geri d'#246'n'#252'lmeyecegi '
          'i'#231'in'
          'vazge'#231'ildi'
          '')
        TabOrder = 27
        Visible = False
      end
      object txt_Sevk_Adres: TIB_Edit
        Left = 76
        Top = 83
        Width = 145
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'SEVK_ADRES_KOD'
        DataSource = dtsFAT_IRS
        TabOrder = 4
        OnEnter = txt_Sevk_AdresEnter
        OnExit = txt_Sevk_AdresExit
        OnKeyPress = txtCariKodKeyPress
        OnKeyUp = txt_Sevk_AdresKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txt_Sevk_AdresButtonClick
      end
    end
    object tabKalem: TTabSheet
      Caption = 'Kalem Bilgileri'
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
          ItemHeight = 13
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
        object txtKasaKod: TIB_Edit
          Left = 112
          Top = 248
          Width = 121
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'KASA_KOD'
          DataSource = dtsFAT_IRS
          TabOrder = 4
          OnEnter = txtKasaKodEnter
          OnExit = txtKasaKodExit
          OnKeyPress = txtKasaKodKeyPress
          OnKeyUp = txtKasaKodKeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = txtKasaKodButtonClick
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
      object txtKasaAd: TIB_Edit
        Left = 301
        Top = 256
        Width = 283
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'KASA_AD'
        DataSource = dtsFAT_IRS
        TabOrder = 2
      end
    end
    object tabAciklama: TTabSheet
      Caption = 'Ek A'#231#305'klamalar'
      ImageIndex = 3
      object lblAck301: TIB_Text
        Left = 10
        Top = 2
        Width = 233
        Height = 15
        DataField = 'ACK_30K_1_CAP'
        DataSource = dtsFAT_IRS_ACK
      end
      object lblAck302: TIB_Text
        Left = 290
        Top = 1
        Width = 233
        Height = 15
        DataField = 'ACK_30K_2_CAP'
        DataSource = dtsFAT_IRS_ACK
      end
      object lblAck303: TIB_Text
        Left = 10
        Top = 33
        Width = 277
        Height = 15
        DataField = 'ACK_30K_3_CAP'
        DataSource = dtsFAT_IRS_ACK
      end
      object lblAck501: TIB_Text
        Left = 10
        Top = 65
        Width = 277
        Height = 15
        DataField = 'ACK_50K_1_CAP'
        DataSource = dtsFAT_IRS_ACK
      end
      object lblAck502: TIB_Text
        Left = 10
        Top = 97
        Width = 277
        Height = 15
        DataField = 'ACK_50K_2_CAP'
        DataSource = dtsFAT_IRS_ACK
      end
      object lblAck503: TIB_Text
        Left = 10
        Top = 128
        Width = 277
        Height = 15
        DataField = 'ACK_50K_3_CAP'
        DataSource = dtsFAT_IRS_ACK
      end
      object lblAck504: TIB_Text
        Left = 10
        Top = 160
        Width = 277
        Height = 15
        DataField = 'ACK_50K_4_CAP'
        DataSource = dtsFAT_IRS_ACK
      end
      object lblAck505: TIB_Text
        Left = 10
        Top = 192
        Width = 277
        Height = 15
        DataField = 'ACK_50K_5_CAP'
        DataSource = dtsFAT_IRS_ACK
      end
      object lblAck1002: TIB_Text
        Left = 10
        Top = 255
        Width = 277
        Height = 15
        DataField = 'ACK_100K_2_CAP'
        DataSource = dtsFAT_IRS_ACK
      end
      object lblAck1001: TIB_Text
        Left = 10
        Top = 223
        Width = 277
        Height = 15
        DataField = 'ACK_100K_1_CAP'
        DataSource = dtsFAT_IRS_ACK
      end
      object lblAck1003: TIB_Text
        Left = 10
        Top = 287
        Width = 277
        Height = 15
        DataField = 'ACK_100K_3_CAP'
        DataSource = dtsFAT_IRS_ACK
      end
      object lblAck1004: TIB_Text
        Left = 10
        Top = 318
        Width = 277
        Height = 15
        DataField = 'ACK_100K_4_CAP'
        DataSource = dtsFAT_IRS_ACK
      end
      object lblAck1005: TIB_Text
        Left = 10
        Top = 349
        Width = 277
        Height = 15
        DataField = 'ACK_100K_5_CAP'
        DataSource = dtsFAT_IRS_ACK
      end
      object txtAck301: TIB_Edit
        Left = 10
        Top = 13
        Width = 277
        Height = 21
        DataField = 'ACK_30K_1'
        DataSource = dtsFAT_IRS_ACK
        TabOrder = 0
        OnEnter = IB_Edit24Enter
        OnExit = IB_Edit24Exit
      end
      object txtAck302: TIB_Edit
        Left = 288
        Top = 13
        Width = 277
        Height = 21
        DataField = 'ACK_30K_2'
        DataSource = dtsFAT_IRS_ACK
        TabOrder = 1
        OnEnter = IB_Edit24Enter
        OnExit = IB_Edit24Exit
      end
      object txtAck303: TIB_Edit
        Left = 10
        Top = 45
        Width = 277
        Height = 21
        DataField = 'ACK_30K_3'
        DataSource = dtsFAT_IRS_ACK
        TabOrder = 2
        OnEnter = IB_Edit24Enter
        OnExit = IB_Edit24Exit
      end
      object txtAck501: TIB_Edit
        Left = 10
        Top = 77
        Width = 467
        Height = 21
        DataField = 'ACK_50K_1'
        DataSource = dtsFAT_IRS_ACK
        TabOrder = 3
        OnEnter = IB_Edit24Enter
        OnExit = IB_Edit24Exit
      end
      object txtAck502: TIB_Edit
        Left = 10
        Top = 109
        Width = 467
        Height = 21
        DataField = 'ACK_50K_2'
        DataSource = dtsFAT_IRS_ACK
        TabOrder = 4
        OnEnter = IB_Edit24Enter
        OnExit = IB_Edit24Exit
      end
      object txtAck503: TIB_Edit
        Left = 10
        Top = 140
        Width = 467
        Height = 21
        DataField = 'ACK_50K_3'
        DataSource = dtsFAT_IRS_ACK
        TabOrder = 5
        OnEnter = IB_Edit24Enter
        OnExit = IB_Edit24Exit
      end
      object txtAck504: TIB_Edit
        Left = 10
        Top = 172
        Width = 467
        Height = 21
        DataField = 'ACK_50K_4'
        DataSource = dtsFAT_IRS_ACK
        TabOrder = 6
        OnEnter = IB_Edit24Enter
        OnExit = IB_Edit24Exit
      end
      object txtAck505: TIB_Edit
        Left = 10
        Top = 204
        Width = 467
        Height = 21
        DataField = 'ACK_50K_5'
        DataSource = dtsFAT_IRS_ACK
        TabOrder = 7
        OnEnter = IB_Edit24Enter
        OnExit = IB_Edit24Exit
      end
      object txtAck1001: TIB_Edit
        Left = 10
        Top = 235
        Width = 713
        Height = 21
        DataField = 'ACK_100K_1'
        DataSource = dtsFAT_IRS_ACK
        TabOrder = 8
        OnEnter = IB_Edit24Enter
        OnExit = IB_Edit24Exit
      end
      object txtAck1002: TIB_Edit
        Left = 10
        Top = 267
        Width = 713
        Height = 21
        DataField = 'ACK_100K_2'
        DataSource = dtsFAT_IRS_ACK
        TabOrder = 9
        OnEnter = IB_Edit24Enter
        OnExit = IB_Edit24Exit
      end
      object txtAck1003: TIB_Edit
        Left = 10
        Top = 299
        Width = 713
        Height = 21
        DataField = 'ACK_100K_3'
        DataSource = dtsFAT_IRS_ACK
        TabOrder = 10
        OnEnter = IB_Edit24Enter
        OnExit = IB_Edit24Exit
      end
      object txtAck1004: TIB_Edit
        Left = 10
        Top = 330
        Width = 713
        Height = 21
        DataField = 'ACK_100K_4'
        DataSource = dtsFAT_IRS_ACK
        TabOrder = 11
        OnEnter = IB_Edit24Enter
        OnExit = IB_Edit24Exit
      end
      object txtAck1005: TIB_Edit
        Left = 10
        Top = 361
        Width = 713
        Height = 21
        DataField = 'ACK_100K_5'
        DataSource = dtsFAT_IRS_ACK
        TabOrder = 12
        OnEnter = IB_Edit24Enter
        OnExit = IB_Edit24Exit
      end
    end
  end
  object qryFAT_IRS: TIB_Query
    ColumnAttributes.Strings = (
      'IPTAL=BOOLEAN=1,0'
      'YAZILDI=BOOLEAN=1,0')
    DatabaseName = 'C:\CedaLite\Trans_Db\EKINCI2008.FDB'
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
      'OTV=#,##')
    FieldsDisplayLabel.Strings = (
      'FATSERI=Seri No'
      'FATURA_KOD=Kodu'
      'REF_BELGE_TUR=Belge T'#252'r'#252
      'PLASIYER_KOD=Plasiyer Kodu'
      'VADE_TARIH=Vade Tarihi'
      'VADE_GUN=Vade G'#252'n'
      'TARIH='#304#351'lem Tarih'
      'FATURA_TIP=Fatura Tipi'
      'ACIKLAMA=Ac'#305'klama'
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
      'SEVK_ADRES_KOD=Sevk Adresi')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    SQL.Strings = (
      'SELECT FAT_IRS_SEP     '
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
      
        '     , (Select KASA.ACIKLAMA From KASA where KASA.KASA_KOD=FAT_I' +
        'RS.KASA_KOD) as KASA_AD'
      
        '     , (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=FAT_IR' +
        'S.CARI_KOD) As CARI_AD   '
      
        '     , (Select DEPO.ADI From DEPO Where DEPO.DEPO_KOD=FAT_IRS.DE' +
        'PO_KOD ) As DEPO_AD'
      
        '     , (Select PLASIYER.ADISOY from PLASIYER Where PLASIYER.PLAS' +
        'IYER_KOD=FAT_IRS.PLASIYER_KOD) AS PLASIYER_AD'
      '     , PROJE_KOD'
      
        '     , (Select PROJE.PROJE_AD From PROJE Where PROJE.PROJE_KOD=F' +
        'AT_IRS.PROJE_KOD) As PROJE_AD'
      '     , YEV_ACIKLAMA'
      '     , KAPANDI'
      '     , SEVK_ADRES_KOD'
      'FROM FAT_IRS '
      
        'WHERE FAT_IRS_SEP=:PRM_FAT_IRS_SEP AND FAT_IRS_ID=:PRM_FAT_IRS_I' +
        'D AND FAT_IRS_SID=:PRM_FAT_IRS_SID')
    ColorScheme = False
    DefaultValues.Strings = (
      'FATURA_ID=0'
      'FATURA_SID=0'
      'CARI_ID=0'
      'CARI_SID=0'
      'REF_BELGE_ID=0'
      'REF_BELGE_SID=0'
      'BRUTTOP=0'
      'NETTOP=0'
      'GENELTOP=0'
      'KDVTOP=0'
      'YAZILDI=0'
      'PLASIYER_ID=0'
      'PLASIYER_SID=0'
      'DEPO_ID=0'
      'DEPO_SID=0'
      'KALEM_ISKONTO_TOPLAMVBP=0'
      'FATURA_ISKONTO_TUTARVPB=0'
      'ISKONTO_TOPLAMIVPB=0'
      'KDV1=0'
      'KDV2=0'
      'KDV3=0'
      'KDV4=0'
      'KDV5=0'
      'OTV=0'
      'IPTAL=0')
    KeyLinks.Strings = (
      'FAT_IRS.FAT_IRS_SEP'
      'FAT_IRS.FAT_IRS_ID'
      'FAT_IRS.FAT_IRS_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterEdit = qryFAT_IRSAfterEdit
    AfterInsert = qryFAT_IRSAfterInsert
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 148
    Top = 268
    ParamValues = (
      'PRM_FAT_IRS_SEP=0')
  end
  object trnFAT_IRS: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 444
    Top = 202
  end
  object dtsFAT_IRS: TIB_DataSource
    AutoInsert = False
    Dataset = qryFAT_IRS
    OnDataChange = dtsFAT_IRSDataChange
    OnStateChanged = dtsFAT_IRSStateChanged
    Left = 150
    Top = 318
  end
  object qryFAT_IRS_MUH_CARI: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\EKINCI2008.FDB'
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
    Left = 334
    Top = 267
    ParamValues = (
      'PRM_FAT_IRS_SEP=0')
  end
  object dtsFAT_IRS_MUH_CARI: TIB_DataSource
    Dataset = qryFAT_IRS_MUH_CARI
    Left = 332
    Top = 325
  end
  object qryURUNHAR: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\EKINCI2008.FDB'
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
    FieldsEditMask.Strings = (
      'KDV_TUTAR=#,##.00')
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
      'CIKIS_MIKTAR=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    SQL.Strings = (
      'SELECT URUNHAR_ID'
      '     , URUNHAR_SID'
      '     , TARIH'
      '     , FIILI_TAR'
      '     , DOV_BAZ_TAR'
      '     , URUN_KOD'
      
        '     , (SELECT  URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD=URUNH' +
        'AR.URUN_KOD) AS URUN_AD'
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
      
        '     , (SELECT DEPO.ADI FROM DEPO WHERE DEPO.DEPO_KOD = URUNHAR.' +
        'DEPO_KOD) AS DEPO_AD'
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
      '     , BIRIM_FIY_URN_OB'
      '     , SECIM'
      '     , CIKIS_MIKTAR'
      'FROM URUNHAR'
      'WHERE FATURA_ID=:PRM_FATURA_ID And FATURA_SID=:PRM_FATURA_SID'
      'ORDER BY URUNHAR_ID;')
    ColorScheme = False
    KeyLinks.Strings = (
      'URUNHAR.URUNHAR_ID'
      'URUNHAR.URUNHAR_SID')
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
    Top = 268
    ParamValues = (
      'PRM_FATURA_ID=0')
  end
  object dtsURUNHAR: TIB_DataSource
    AutoInsert = False
    Dataset = qryURUNHAR
    OnDataChange = dtsURUNHARDataChange
    OnStateChanged = dtsURUNHARStateChanged
    Left = 228
    Top = 320
  end
  object qryFAT_IRS_ACK: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    SQL.Strings = (
      'SELECT FAT_IRS_SEP'
      '     , FAT_IRS_ID'
      '     , FAT_IRS_SID'
      '     , ACK_30K_1'
      '     , ACK_30K_2'
      '     , ACK_30K_3'
      '     , ACK_50K_1'
      '     , ACK_50K_2'
      '     , ACK_50K_3'
      '     , ACK_50K_4'
      '     , ACK_50K_5'
      '     , ACK_100K_1'
      '     , ACK_100K_2'
      '     , ACK_100K_3'
      '     , ACK_100K_4'
      '     , ACK_100K_5'
      '     , ACK_30K_1_CAP'
      '     , ACK_30K_2_CAP'
      '     , ACK_30K_3_CAP'
      '     , ACK_50K_1_CAP'
      '     , ACK_50K_2_CAP'
      '     , ACK_50K_3_CAP'
      '     , ACK_50K_4_CAP'
      '     , ACK_50K_5_CAP'
      '     , ACK_100K_1_CAP'
      '     , ACK_100K_2_CAP'
      '     , ACK_100K_3_CAP'
      '     , ACK_100K_4_CAP'
      '     , ACK_100K_5_CAP'
      
        'FROM FAT_IRS_ACK  WHERE FAT_IRS_SEP=:PRM_FAT_IRS_SEP AND FAT_IRS' +
        '_ID=:PRM_FAT_IRS_ID AND FAT_IRS_SID=:PRM_FAT_IRS_SID;')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 446
    Top = 270
    ParamValues = (
      'PRM_FAT_IRS_SEP=0')
  end
  object dtsFAT_IRS_ACK: TIB_DataSource
    Dataset = qryFAT_IRS_ACK
    Left = 450
    Top = 326
  end
  object PopupMenu1: TPopupMenu
    Left = 292
    Top = 207
    object FaturaKopyala1: TMenuItem
      Caption = 'Fatura Kopyala'
      OnClick = FaturaKopyala1Click
    end
  end
  object trn_Sip: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 396
    Top = 202
  end
  object qry_Temp: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnFAT_IRS
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 210
    Top = 210
  end
end
