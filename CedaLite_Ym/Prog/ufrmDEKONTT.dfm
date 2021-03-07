object frmDEKONTT: TfrmDEKONTT
  Left = 59
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Dekont'
  ClientHeight = 451
  ClientWidth = 703
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
  object pcDEKONT: TPageControl
    Left = 0
    Top = 0
    Width = 703
    Height = 451
    ActivePage = tabMASTER
    Align = alClient
    HotTrack = True
    Style = tsFlatButtons
    TabOrder = 0
    TabStop = False
    OnChanging = pcDEKONTChanging
    object tabMASTER: TTabSheet
      Caption = 'Dekont'
      PopupMenu = PopupMenu1
      object edtACIKLAMA: TIB_Edit
        Left = 12
        Top = 288
        Width = 606
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'ACIKLAMA'
        DataSource = dtsDEKONT
        Visible = False
        TabOrder = 5
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_Date1: TIB_Date
        Left = 133
        Top = 16
        Width = 92
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'ISLEM_TAR'
        DataSource = dtsDEKONT
        TabOrder = 1
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object dtpDOVBAZTAR: TIB_Date
        Left = 230
        Top = 16
        Width = 91
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'DOV_BAZ_TAR'
        DataSource = dtsDEKONT
        TabOrder = 2
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object Panel2: TPanel
        Left = 0
        Top = 304
        Width = 695
        Height = 116
        Align = alBottom
        TabOrder = 22
        DesignSize = (
          695
          116)
        object btnYENI: TButton
          Left = 5
          Top = 85
          Width = 101
          Height = 27
          Anchors = [akLeft, akBottom]
          Caption = 'Yeni Dekont (INS)'
          TabOrder = 0
          OnClick = btnYENIClick
        end
        object btnTRN_KAYDET: TButton
          Left = 105
          Top = 85
          Width = 118
          Height = 27
          Anchors = [akLeft, akBottom]
          Caption = 'Kaydet ( CTRL + END)'
          TabOrder = 1
          OnClick = btnTRN_KAYDETClick
        end
        object btnTRN_IPTAL: TButton
          Left = 222
          Top = 85
          Width = 118
          Height = 27
          Anchors = [akLeft, akBottom]
          Caption = #304'ptal (CTRL + A)'
          TabOrder = 2
          OnClick = btnTRN_IPTALClick
        end
        object btnAra: TBitBtn
          Left = 563
          Top = 85
          Width = 62
          Height = 27
          Anchors = [akLeft, akBottom]
          Caption = '&Ara'
          TabOrder = 3
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
          Left = 628
          Top = 85
          Width = 61
          Height = 27
          Anchors = [akLeft, akBottom]
          Caption = #199#305'&k'#305#351
          TabOrder = 4
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
        object btnDekontSil: TButton
          Left = 339
          Top = 85
          Width = 127
          Height = 27
          Anchors = [akLeft, akBottom]
          Caption = 'Dekont Sil (CTRL+DEL)'
          TabOrder = 5
          OnClick = btnDekontSilClick
        end
        object btnCikti: TButton
          Left = 586
          Top = 43
          Width = 100
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = 'Yaz'#305'c'#305' '#199#305'kt'#305's'#305
          TabOrder = 6
          TabStop = False
          OnClick = btnCiktiClick
        end
        object rgYAZICI: TRadioGroup
          Left = 480
          Top = 6
          Width = 101
          Height = 69
          Caption = 'Yazd'#305'rma'
          ItemIndex = 2
          Items.Strings = (
            'Yazd'#305'r'
            #214'n '#304'zleme'
            'Sadece Kay'#305't')
          TabOrder = 7
        end
        object Btn_Onceki: TButton
          Left = 480
          Top = 86
          Width = 33
          Height = 25
          Caption = '<'
          TabOrder = 8
          OnClick = Btn_OncekiClick
        end
        object Btn_Sonraki: TButton
          Left = 520
          Top = 86
          Width = 33
          Height = 25
          Caption = '>'
          TabOrder = 9
          OnClick = Btn_SonrakiClick
        end
      end
      object IB_Edit1: TIB_Edit
        Left = 11
        Top = 16
        Width = 116
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'DEKONT_ID'
        DataSource = dtsDEKONT
        Enabled = False
        TabOrder = 0
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_Edit2: TIB_Edit
        Left = 11
        Top = 213
        Width = 121
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'PROJE_KOD'
        DataSource = dtsDEKONT
        Visible = False
        TabOrder = 23
        OnEnter = IB_Edit2Enter
        OnExit = IB_Edit2Exit
        OnKeyPress = IB_Edit2KeyPress
        OnKeyUp = IB_Edit2KeyUp
        ButtonStyle = ebsEllipsis
        AlwaysShowButton = True
        OnButtonClick = IB_Edit2ButtonClick
      end
      object IB_Edit7: TIB_Edit
        Left = 135
        Top = 212
        Width = 394
        Height = 21
        DataField = 'PROJE_AD'
        DataSource = dtsDEKONT
        Enabled = False
        Visible = False
        TabOrder = 24
      end
      object grpRapKod: TGroupBox
        Left = 11
        Top = 240
        Width = 518
        Height = 59
        TabOrder = 21
        object IB_Edit8: TIB_Edit
          Left = 15
          Top = 25
          Width = 83
          Height = 21
          AutoLabel.Kind = albTop
          AutoLabel.Caption = #304#351'lem Merkezi'
          DataField = 'MASRAF_MERK'
          DataSource = dtsDEKONT
          TabOrder = 0
          OnExit = IB_Edit8Exit
          OnKeyUp = IB_Edit8KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit8ButtonClick
        end
        object IB_Edit10: TIB_Edit
          Left = 111
          Top = 25
          Width = 85
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD1'
          DataSource = dtsDEKONT
          TabOrder = 1
          OnExit = IB_Edit10Exit
          OnKeyUp = IB_Edit10KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit10ButtonClick
        end
        object IB_Edit11: TIB_Edit
          Left = 213
          Top = 25
          Width = 81
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD2'
          DataSource = dtsDEKONT
          TabOrder = 2
          OnExit = IB_Edit11Exit
          OnKeyUp = IB_Edit11KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit11ButtonClick
        end
        object IB_Edit12: TIB_Edit
          Left = 309
          Top = 25
          Width = 85
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD3'
          DataSource = dtsDEKONT
          TabOrder = 3
          OnExit = IB_Edit12Exit
          OnKeyUp = IB_Edit12KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit12ButtonClick
        end
        object IB_Edit13: TIB_Edit
          Left = 412
          Top = 25
          Width = 85
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD4'
          DataSource = dtsDEKONT
          TabOrder = 4
          OnExit = IB_Edit13Exit
          OnKeyUp = IB_Edit13KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit13ButtonClick
        end
      end
      object txtUrunKodu: TIB_Edit
        Left = 171
        Top = 96
        Width = 116
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'URUN_KOD'
        DataSource = dtsDEKONT
        Visible = False
        TabOrder = 6
        OnEnter = txtUrunKoduEnter
        OnExit = txtUrunKoduExit
        OnKeyPress = txtUrunKoduKeyPress
        OnKeyUp = txtUrunKoduKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtUrunKoduButtonClick
      end
      object IB_Edit23: TIB_Edit
        Left = 289
        Top = 96
        Width = 328
        Height = 21
        TabStop = False
        AutoLabel.Kind = albTop
        DataField = 'URUN_AD'
        DataSource = dtsDEKONT
        Enabled = False
        Visible = False
        TabOrder = 7
      end
      object txtOlcuBirim: TIB_Edit
        Left = 226
        Top = 131
        Width = 121
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'OLCUBIRIM'
        DataSource = dtsDEKONT
        Visible = False
        TabOrder = 11
        OnEnter = txtOlcuBirimEnter
        OnExit = txtOlcuBirimExit
        OnKeyPress = txtOlcuBirimKeyPress
        OnKeyUp = txtOlcuBirimKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtOlcuBirimButtonClick
      end
      object IB_Currency7: TIB_Currency
        Left = 154
        Top = 131
        Width = 71
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'MIKTAR'
        DataSource = dtsDEKONT
        Visible = False
        ReadOnly = True
        TabOrder = 10
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        AlwaysShowButton = True
      end
      object IB_Currency5: TIB_Currency
        Left = 347
        Top = 131
        Width = 94
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'BIRIM_FIY'
        DataSource = dtsDEKONT
        Visible = False
        TabOrder = 12
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        AlwaysShowButton = True
      end
      object IB_ComboBox1: TIB_ComboBox
        Left = 442
        Top = 131
        Width = 89
        Height = 21
        AutoLabel.Kind = albTop
        AutoLabel.Caption = 'D'#246'viz Kodu'
        DataField = 'DOVKOD'
        DataSource = dtsDEKONT
        Visible = False
        TabOrder = 13
        OnEnter = cboDOVKODEnter
        OnExit = cboDOVKODExit
        Style = csDropDownList
        ItemHeight = 13
      end
      object IB_Currency1: TIB_Currency
        Left = 531
        Top = 131
        Width = 86
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'DOVKUR'
        DataSource = dtsDEKONT
        Visible = False
        TabOrder = 14
        OnEnter = IB_Edit1Enter
        OnExit = edtDOVKURExit
        AlwaysShowButton = True
      end
      object IB_Currency2: TIB_Currency
        Left = 98
        Top = 171
        Width = 102
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'TUTAR'
        DataSource = dtsDEKONT
        Enabled = False
        Visible = False
        TabOrder = 17
        AlwaysShowButton = True
      end
      object IB_Currency3: TIB_Currency
        Left = 202
        Top = 171
        Width = 124
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'TUTAR_VPB'
        DataSource = dtsDEKONT
        Enabled = False
        Visible = False
        TabOrder = 18
        AlwaysShowButton = True
        CalculatorKind = cucInline
      end
      object txtDepoKod: TIB_Edit
        Left = 329
        Top = 172
        Width = 117
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'DEPO_KOD'
        DataSource = dtsDEKONT
        Visible = False
        TabOrder = 19
        OnEnter = txtDepoKodEnter
        OnExit = txtDepoKodExit
        OnKeyPress = txtDepoKodKeyPress
        OnKeyUp = txtDepoKodKeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = txtDepoKodButtonClick
      end
      object txtDepoAd: TIB_Edit
        Left = 448
        Top = 172
        Width = 169
        Height = 21
        TabStop = False
        AutoLabel.Kind = albTop
        DataField = 'DEPO_AD'
        DataSource = dtsDEKONT
        Enabled = False
        Visible = False
        TabOrder = 20
      end
      object IB_Edit22: TIB_Edit
        Left = 12
        Top = 171
        Width = 25
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KDV'
        DataSource = dtsDEKONT
        Visible = False
        TabOrder = 15
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
      end
      object IB_Edit3: TIB_Edit
        Left = 37
        Top = 171
        Width = 58
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KDV_TUTAR'
        DataSource = dtsDEKONT
        Enabled = False
        Visible = False
        TabOrder = 16
      end
      object IB_Currency4: TIB_Currency
        Left = 82
        Top = 131
        Width = 71
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'FIRE'
        DataSource = dtsDEKONT
        Visible = False
        TabOrder = 9
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        AlwaysShowButton = True
      end
      object IB_Currency6: TIB_Currency
        Left = 10
        Top = 131
        Width = 71
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'NET_MIKTAR'
        DataSource = dtsDEKONT
        Visible = False
        TabOrder = 8
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        AlwaysShowButton = True
      end
      object rg_Giris_Cikis: TIB_RadioGroup
        Left = 12
        Top = 96
        Width = 155
        Height = 20
        DataField = 'TIPI'
        DataSource = dtsDEKONT
        Visible = False
        TabOrder = 25
        Columns = 2
        Items.Strings = (
          #199#305'k'#305#351
          'Giri'#351)
        Values.Strings = (
          'A'
          'B')
      end
      object txtCari_Kod: TIB_Edit
        Left = 327
        Top = 16
        Width = 122
        Height = 21
        AutoLabel.Kind = albTop
        AutoLabel.Caption = 'Cari'
        DataField = 'CARI_KOD'
        DataSource = dtsDEKONT
        TabOrder = 3
        OnEnter = txtCari_KodEnter
        OnExit = txtCari_KodExit
        OnKeyDown = txtCari_KodKeyDown
        OnKeyPress = txtCari_KodKeyPress
        ButtonStyle = ebsEllipsis
        AlwaysShowButton = True
        OnButtonClick = txtCari_KodButtonClick
      end
      object IB_Edit4: TIB_Edit
        Left = 449
        Top = 16
        Width = 168
        Height = 21
        TabStop = False
        AutoLabel.Kind = albTop
        DataField = 'CARI_ADI'
        DataSource = dtsDEKONT
        Enabled = False
        TabOrder = 26
      end
      object Cb_Aciklama: TIB_ComboBox
        Left = 11
        Top = 54
        Width = 606
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'ACIKLAMA'
        DataSource = dtsDEKONT
        TabOrder = 4
        OnEnter = IB_Edit1Enter
        OnExit = IB_Edit1Exit
        ItemHeight = 13
      end
    end
    object tabDETAY: TTabSheet
      Caption = 'Kalemler'
      ImageIndex = 1
      object sbDEKONT: TStatusBar
        Left = 0
        Top = 401
        Width = 695
        Height = 19
        Panels = <
          item
            Bevel = pbRaised
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            Text = 'Bor'#231' Toplam'#305':'
            Width = 72
          end
          item
            Alignment = taRightJustify
            Width = 150
          end
          item
            Bevel = pbRaised
            Text = 'Alacak Toplam'#305':'
            Width = 80
          end
          item
            Alignment = taRightJustify
            Width = 150
          end
          item
            Bevel = pbRaised
            Text = 'Bakiye:'
            Width = 50
          end
          item
            Alignment = taCenter
            Width = 30
          end
          item
            Alignment = taRightJustify
            Width = 150
          end
          item
            Width = 50
          end>
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 695
        Height = 176
        Align = alTop
        TabOrder = 1
        object rdoCM: TIB_RadioGroup
          Left = 61
          Top = 7
          Width = 157
          Height = 21
          DataField = 'MC'
          DataSource = dtsDEKONT_D
          OnClick = rdoCMClick
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 0
          Columns = 2
          Items.Strings = (
            'Cari'
            'Masraf')
          Values.Strings = (
            'C'
            'M')
        end
        object IB_RadioGroup2: TIB_RadioGroup
          Left = 221
          Top = 7
          Width = 121
          Height = 21
          DataField = 'BA'
          DataSource = dtsDEKONT_D
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 1
          Columns = 2
          Items.Strings = (
            'Bor'#231
            'Alacak')
          Values.Strings = (
            'B'
            'A')
        end
        object txtKARSI_KOD: TIB_Edit
          Left = 63
          Top = 31
          Width = 122
          Height = 21
          AutoLabel.Kind = albLeft
          AutoLabel.Caption = 'Cari'
          DataField = 'KARSI_KOD'
          DataSource = dtsDEKONT_D
          TabOrder = 2
          OnEnter = txtKARSI_KODEnter
          OnExit = txtKARSI_KODExit
          OnKeyPress = txtKARSI_KODKeyPress
          OnKeyUp = txtKARSI_KODKeyUp
          ButtonStyle = ebsEllipsis
          AlwaysShowButton = True
          OnButtonClick = txtKARSI_KODButtonClick
        end
        object edtDOVKUR: TIB_Currency
          Left = 104
          Top = 89
          Width = 99
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'DOVKUR'
          DataSource = dtsDEKONT_D
          TabOrder = 7
          OnEnter = IB_Edit1Enter
          OnExit = edtDOVKURExit
          AlwaysShowButton = True
        end
        object edtTUTAR: TIB_Currency
          Left = 207
          Top = 89
          Width = 135
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'TUTAR'
          DataSource = dtsDEKONT_D
          TabOrder = 8
          OnEnter = IB_Edit1Enter
          OnExit = edtTUTARExit
          AlwaysShowButton = True
        end
        object edtTUTAR_VPB: TIB_Currency
          Left = 345
          Top = 89
          Width = 136
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'TUTAR_VPB'
          DataSource = dtsDEKONT_D
          Enabled = False
          TabOrder = 9
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          AlwaysShowButton = True
        end
        object btnEKLE: TButton
          Left = 6
          Top = 147
          Width = 76
          Height = 23
          Caption = 'Ekle (INS)'
          TabOrder = 12
          OnClick = btnEKLEClick
        end
        object btnKAYDET: TButton
          Left = 81
          Top = 147
          Width = 96
          Height = 23
          Caption = 'Kaydet (CTRL+S)'
          TabOrder = 13
          OnClick = btnKAYDETClick
        end
        object btnSIL: TButton
          Left = 484
          Top = 147
          Width = 95
          Height = 23
          Caption = 'Sil (CTRL + DEL)'
          TabOrder = 14
          OnClick = btnSILClick
        end
        object btnIptal: TButton
          Left = 176
          Top = 147
          Width = 78
          Height = 23
          Caption = #304'ptal(CTRL+P)'
          TabOrder = 15
          OnClick = btnIptalClick
        end
        object IB_Edit5: TIB_Edit
          Left = 191
          Top = 31
          Width = 386
          Height = 21
          TabStop = False
          DataField = 'KARSI_AD'
          DataSource = dtsDEKONT_D
          Enabled = False
          TabOrder = 3
        end
        object txtProjeKod: TIB_Edit
          Left = 63
          Top = 53
          Width = 121
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'PROJE_KOD'
          DataSource = dtsDEKONT_D
          TabOrder = 4
          OnEnter = txtProjeKodEnter
          OnExit = txtProjeKodExit
          OnKeyPress = txtProjeKodKeyPress
          OnKeyUp = txtProjeKodKeyUp
          ButtonStyle = ebsEllipsis
          AlwaysShowButton = True
          OnButtonClick = txtProjeKodButtonClick
        end
        object IB_Edit9: TIB_Edit
          Left = 191
          Top = 53
          Width = 386
          Height = 21
          DataField = 'PROJE_AD'
          DataSource = dtsDEKONT_D
          Enabled = False
          TabOrder = 5
        end
        object IB_Edit6: TIB_Edit
          Left = 484
          Top = 4
          Width = 573
          Height = 21
          DataField = 'ACIKLAMA1'
          DataSource = dtsDEKONT_D
          Visible = False
          TabOrder = 11
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
        end
        object Button1: TButton
          Left = 325
          Top = 147
          Width = 96
          Height = 23
          Caption = '&De'#287'i'#351'tir'
          TabOrder = 16
          OnClick = Button1Click
        end
        object cboDOVKOD: TIB_ComboBox
          Left = 9
          Top = 90
          Width = 89
          Height = 21
          AutoLabel.Kind = albTop
          AutoLabel.Caption = 'D'#246'viz Kodu'
          DataField = 'DOVKOD'
          DataSource = dtsDEKONT_D
          TabOrder = 6
          OnEnter = cboDOVKODEnter
          OnExit = cboDOVKODExit
          Style = csDropDownList
          ItemHeight = 13
        end
        object Cb_Aciklama1: TIB_ComboBox
          Left = 9
          Top = 116
          Width = 606
          Height = 21
          DataField = 'ACIKLAMA1'
          DataSource = dtsDEKONT_D
          TabOrder = 10
          OnEnter = IB_Edit1Enter
          OnExit = IB_Edit1Exit
          ItemHeight = 13
        end
      end
      object grdDekontKontrol: TIB_Grid
        Left = 0
        Top = 176
        Width = 695
        Height = 225
        CustomGlyphsSupplied = []
        DataSource = dtsDEKONT_D
        Align = alClient
        BorderStyle = bsNone
        PreventDeleting = True
        PreventEditing = True
        PreventInserting = True
        TabOrder = 2
        RowSelect = True
        Ctl3DShallow = True
      end
    end
  end
  object qryDEKONT: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    FieldsDisplayLabel.Strings = (
      'DEKONT_KOD=Dekont Kod'
      'FIS_NO=Fi'#351' No'
      'ISLEM_TAR='#304#351'lem Tarihi'
      'DOV_BAZ_TAR=D'#246'viz Baz Tarihi'
      'ACIKLAMA=A'#231#305'klama'
      'DEKONT_ID=Dekont No'
      'DEKONT_SID=Dekont '#350'ube'
      'URUN_KOD='#220'r'#252'n Kod'
      'URUN_AD='#220'r'#252'n Ad'
      'DEPO_KOD=Depo Kod'
      'DEPO_AD=Depo Ad'#305
      'OLCUBIRIM='#214'l'#231#252' Birimi'
      'MIKTAR=Net Miktar'
      'DOVKOD=D'#246'viz Kodu'
      'DOVKUR=Doviz Kuru'
      'TUTAR=Tutar'
      'TUTAR_VPB=Tutar Vpb'
      'BIRIM_FIY=Birim Fiyat'#305
      'FIRE=Fire'
      'NET_MIKTAR=Miktar'
      'TIPI=Tipi'
      'CARI_KOD=Cari Kod'
      'CARI_ADI=Cari Ad'#305)
    FieldsVisible.Strings = (
      'DEKONT_ID=FALSE'
      'DEKONT_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnDEKONT
    SQL.Strings = (
      'SELECT DEKONT_ID'
      '     , DEKONT_SID'
      '     , TIP'
      '     , ISLEM_TAR'
      '     , DOV_BAZ_TAR'
      '     , ACIKLAMA'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , PROJE_KOD'
      
        '     , (SELECT PROJE_AD FROM PROJE WHERE DEKONT.PROJE_KOD=PROJE.' +
        'PROJE_KOD) AS PROJE_AD'
      ''
      '     , URUN_KOD'
      
        '     , (SELECT  URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD=DEKON' +
        'T.URUN_KOD) AS URUN_AD'
      '     , DEPO_KOD'
      
        '     , (SELECT DEPO.ADI FROM DEPO WHERE DEPO.DEPO_KOD = DEKONT.D' +
        'EPO_KOD) AS DEPO_AD'
      ''
      '     , CARI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=DEKONT.CARI_' +
        'KOD) AS CARI_ADI'
      ''
      '     , OLCUBIRIM'
      '     , MIKTAR'
      '     , DOVKOD'
      '     , DOVKUR'
      '     , TUTAR'
      '     , TUTAR_VPB'
      '     , URUN_DOVKOD'
      '     , TUTAR_URUN_DOVKOD'
      '     , BIRIM_FIY'
      '     , BIRIM_FIY_VPB'
      '     , BIRIM_FIY_URN_DOVKOD'
      '     , OLCUBIRIM_URN_OB'
      '     , MIKTAR_URN_OB'
      '     , URUNHAR_ID '
      '     , URUNHAR_SID '
      '     , KDV'
      '     , KDV_TUTAR'
      '     , FIRE'
      '     , NET_MIKTAR'
      '     , TIPI'
      
        'FROM DEKONT Where DEKONT_ID=:PRM_DEKONT_ID And DEKONT_SID=:PRM_D' +
        'EKONT_SID')
    ColorScheme = False
    GeneratorLinks.Strings = (
      'DEKONT.DEKONT_ID=GEN_DEKONT')
    KeyLinks.Strings = (
      'DEKONT.DEKONT_ID'
      'DEKONT.DEKONT_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryDEKONTAfterInsert
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 212
    Top = 322
    ParamValues = (
      'PRM_DEKONT_ID=0')
  end
  object dtsDEKONT: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = qryDEKONT
    OnDataChange = FR
    OnStateChanged = dtsDEKONTStateChanged
    Left = 208
    Top = 378
  end
  object qryDEKONT_D: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    FieldsDisplayFormat.Strings = (
      'MIKTAR=#,##.00')
    FieldsDisplayLabel.Strings = (
      'BA=BA'
      'MC=MC'
      'SIRA_NO=S'#305'ra No'
      'FIILI_TAR=Fiili Tarih'
      'TUTAR=Tutar'
      'DOVKOD=Para Birimi'
      'DOVKUR=D'#246'viz Kuru'
      'TUTAR_VPB=Tutar VPB'
      'ACIKLAMA1=A'#231#305'klama 1'
      'ACIKLAMA2=A'#231#305'klama 2'
      'MUHAS_KOD=Muh. Kodu'
      'OLCUBIRIM='#214'l'#231#252' Birimi'
      'MIKTAR=Miktar'
      'CARI_KOD=Cari Kodu'
      'CARI_AD=Cari Ad'#305
      'HESAP_AD=Hesap Ad'#305
      'PROJE_KOD=Proje Kodu'
      'PROJE_AD=Proje Ad'#305
      'KARSI_KOD=KOD')
    FieldsDisplayWidth.Strings = (
      'DOVKOD=56'
      'TUTAR=101'
      'DOVKUR=70'
      'TUTAR_VPB=99'
      'SIRA_NO=42'
      'FIILI_TAR=61'
      'MUHAS_KOD=89'
      'BA=29'
      'MC=27'
      'CARI_KOD=68'
      'KARSI_KOD=115'
      'KARSI_AD=270')
    FieldsIndex.Strings = (
      'DEKONT_D_ID'
      'DEKONT_D_SID'
      'DEKONT_ID'
      'DEKONT_SID'
      'BA'
      'MC'
      'KARSI_KOD'
      'KARSI_AD'
      'DOVKOD'
      'TUTAR'
      'DOVKUR'
      'TUTAR_VPB'
      'ACIKLAMA1'
      'ACIKLAMA2'
      'OLCUBIRIM'
      'MIKTAR'
      'PROJE_KOD'
      'PROJE_AD')
    FieldsVisible.Strings = (
      'DEKONT_D_ID=FALSE'
      'DEKONT_D_SID=FALSE'
      'DEKONT_ID=FALSE'
      'DEKONT_SID=FALSE'
      'DB_KEY=FALSE'
      'MIKTAR=FALSE'
      'OLCUBIRIM=FALSE'
      'ACIKLAMA1=FALSE'
      'ACIKLAMA2=FALSE'
      'CARI_AD=FALSE'
      'HESAP_AD=FALSE'
      'PROJE_KOD=FALSE'
      'PROJE_AD=FALSE'
      'SIL=FALSE'
      'KARSI_AD=TRUE'
      'TUTAR_VPB=FALSE'
      'DOVKUR=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnDEKONT
    SQL.Strings = (
      'SELECT DEKONT_D_ID'
      '     , DEKONT_D_SID'
      '     , DEKONT_ID'
      '     , DEKONT_SID'
      '     , BA'
      '     , MC'
      '     , KARSI_KOD'
      
        '     , (SELECT PRM_KARSI_AD FROM GET_KARSI_AD(DEKONT_D.MC,DEKONT' +
        '_D.KARSI_KOD)) AS KARSI_AD'
      '     , TUTAR'
      '     , DOVKOD'
      '     , DOVKUR'
      '     , TUTAR_VPB'
      '     , ACIKLAMA1'
      '     , ACIKLAMA2'
      '     , OLCUBIRIM'
      '     , MIKTAR'
      '     , PROJE_KOD'
      
        '     , (Select PROJE_AD from PROJE Where DEKONT_D.PROJE_KOD=PROJ' +
        'E.PROJE_KOD) AS PROJE_AD'
      'FROM DEKONT_D '
      'WHERE  DEKONT_ID=:PRM_DEKONT_ID And DEKONT_SID=:PRM_DEKONT_SID')
    ColorScheme = False
    DefaultValues.Strings = (
      'BA=B'
      'MC=C'
      'MIKTAR=1')
    GeneratorLinks.Strings = (
      'DEKONT_D.DEKONT_D_ID=GEN_DEKONT_D')
    KeyLinks.Strings = (
      'DEKONT_D.DEKONT_D_ID'
      'DEKONT_D.DEKONT_D_SID')
    MasterSource = dtsDEKONT
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItemNo = 1
    OrderingItems.Strings = (
      'BA=BA;BA DESC')
    OrderingLinks.Strings = (
      'BA=ITEM=1')
    RequestLive = True
    AfterDelete = qryDEKONT_DAfterDelete
    AfterInsert = qryDEKONT_DAfterInsert
    AfterOpen = qryDEKONT_DAfterOpen
    AfterPost = qryDEKONT_DAfterPost
    AfterScroll = qryDEKONT_DAfterScroll
    BeforePost = qryDEKONT_DBeforePost
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 126
    Top = 322
    ParamValues = (
      'PRM_DEKONT_ID=1068'
      'PRM_DEKONT_SID=1')
  end
  object dtsDEKONT_D: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = qryDEKONT_D
    OnDataChange = dtsDEKONT_DDataChange
    OnStateChanged = dtsDEKONT_DStateChanged
    Left = 126
    Top = 378
  end
  object trnDEKONT: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    LockWait = True
    AfterCommit = trnDEKONTAfterCommit
    Left = 278
    Top = 356
  end
  object PopupMenu1: TPopupMenu
    Left = 346
    Top = 361
    object DekontuablonOlarakKopyala1: TMenuItem
      Caption = 'Dekontu '#350'ablon Olarak Kopyala'
      OnClick = DekontuablonOlarakKopyala1Click
    end
    object DekontKopyala1: TMenuItem
      Caption = 'Dekont Kopyala'
      OnClick = DekontKopyala1Click
    end
  end
end
