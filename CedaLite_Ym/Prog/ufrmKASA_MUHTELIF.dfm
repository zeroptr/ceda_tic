object frmKASA_MUHTELIF: TfrmKASA_MUHTELIF
  Left = 184
  Top = 211
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Kasa - Muhtelif Tahsil / Tediye'
  ClientHeight = 449
  ClientWidth = 643
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
  object pcKASAHAR: TPageControl
    Left = 0
    Top = 0
    Width = 643
    Height = 449
    ActivePage = tabMASTER
    Align = alClient
    HotTrack = True
    Style = tsFlatButtons
    TabOrder = 0
    TabStop = False
    OnChanging = pcKASAHARChanging
    object tabMASTER: TTabSheet
      Caption = 'Kasa (F6)'
      PopupMenu = PopupMenu1
      object Panel2: TPanel
        Left = 0
        Top = 388
        Width = 635
        Height = 30
        Align = alBottom
        TabOrder = 18
        object btnYENI: TButton
          Left = 5
          Top = 3
          Width = 76
          Height = 25
          Hint = 'CTRL+N'
          Caption = 'Yeni Fi'#351' (INS)'
          TabOrder = 0
          OnClick = btnYENIClick
        end
        object btnTRN_KAYDET: TButton
          Left = 87
          Top = 3
          Width = 118
          Height = 25
          Caption = 'Kaydet ( CTRL + END)'
          TabOrder = 1
          OnClick = btnTRN_KAYDETClick
        end
        object btnTRN_IPTAL: TButton
          Left = 208
          Top = 3
          Width = 89
          Height = 25
          Caption = 'Iptal (CTRL + A)'
          TabOrder = 2
          OnClick = btnTRN_IPTALClick
        end
        object btnAra: TBitBtn
          Left = 504
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
          Left = 570
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
        object btnHareketSil: TButton
          Left = 302
          Top = 3
          Width = 105
          Height = 25
          Caption = 'Fi'#351' Sil (CTRL + DEL)'
          TabOrder = 3
          OnClick = btnHareketSilClick
        end
        object Btn_Onceki: TButton
          Left = 422
          Top = 3
          Width = 33
          Height = 25
          Caption = '<'
          TabOrder = 6
          OnClick = Btn_OncekiClick
        end
        object Btn_Sonraki: TButton
          Left = 457
          Top = 3
          Width = 33
          Height = 25
          Caption = '>'
          TabOrder = 7
          OnClick = Btn_SonrakiClick
        end
      end
      object txtMAS_PROJE_KOD: TIB_Edit
        Left = 63
        Top = 94
        Width = 121
        Height = 21
        AutoLabel.Kind = albLeft
        AutoLabel.Caption = 'Proje Kod'
        DataField = 'PROJE_KOD'
        DataSource = dtsKASAHAR_MAS
        TabOrder = 7
        OnEnter = txtMAS_PROJE_KODEnter
        OnExit = txtMAS_PROJE_KODExit
        OnKeyUp = txtMAS_PROJE_KODKeyUp
        ButtonStyle = ebsEllipsis
        AlwaysShowButton = True
        OnButtonClick = txtMAS_PROJE_KODButtonClick
      end
      object txtMAS_PROJE_AD: TIB_Edit
        Left = 191
        Top = 94
        Width = 278
        Height = 21
        DataField = 'PROJE_AD'
        DataSource = dtsKASAHAR_MAS
        Enabled = False
        TabOrder = 8
      end
      object txtMAS_PLASIYER_KOD: TIB_Edit
        Left = 63
        Top = 117
        Width = 121
        Height = 21
        AutoLabel.Kind = albLeft
        AutoLabel.Caption = 'Plasiyer Kod'
        DataField = 'PLASIYER_KOD'
        DataSource = dtsKASAHAR_MAS
        TabOrder = 9
        OnEnter = txtMAS_PLASIYER_KODEnter
        OnExit = txtMAS_PLASIYER_KODExit
        OnKeyUp = txtMAS_PLASIYER_KODKeyUp
        ButtonStyle = ebsEllipsis
        AlwaysShowButton = True
        OnButtonClick = txtMAS_PLASIYER_KODButtonClick
      end
      object txtMAS_PLASIYER_AD: TIB_Edit
        Left = 191
        Top = 117
        Width = 278
        Height = 21
        DataField = 'PLASIYER_AD'
        DataSource = dtsKASAHAR_MAS
        Enabled = False
        TabOrder = 10
      end
      object txtFIS_NO: TIB_Edit
        Left = 12
        Top = 20
        Width = 101
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KASAHAR_ID'
        DataSource = dtsKASAHAR_MAS
        Enabled = False
        TabOrder = 0
        OnEnter = txtFIS_NOEnter
        OnExit = txtFIS_NOExit
      end
      object dtpISLEMTAR: TIB_Date
        Left = 120
        Top = 20
        Width = 97
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'TARIH'
        DataSource = dtsKASAHAR_MAS
        TabOrder = 1
        OnEnter = txtFIS_NOEnter
        OnExit = txtFIS_NOExit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object dtpDOVBAZTAR: TIB_Date
        Left = 220
        Top = 20
        Width = 89
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'DOV_BAZ_TAR'
        DataSource = dtsKASAHAR_MAS
        TabOrder = 2
        OnEnter = txtFIS_NOEnter
        OnExit = txtFIS_NOExit
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_Edit1: TIB_Edit
        Left = 496
        Top = 117
        Width = 469
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'ACIKLAMA'
        DataSource = dtsKASAHAR_MAS
        Visible = False
        TabOrder = 12
        OnEnter = txtFIS_NOEnter
        OnExit = IB_Edit1Exit
      end
      object txtKASA_KOD: TIB_Edit
        Left = 63
        Top = 46
        Width = 121
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'KASA_KOD'
        DataSource = dtsKASAHAR_MAS
        TabOrder = 3
        OnEnter = txtKASA_KODEnter
        OnExit = txtKASA_KODExit
        ButtonStyle = ebsEllipsis
        AlwaysShowButton = True
        OnButtonClick = txtKASA_KODButtonClick
        OnChange = txtKASA_KODChange
      end
      object IB_Edit4: TIB_Edit
        Left = 191
        Top = 46
        Width = 278
        Height = 21
        DataField = 'KASA_AD'
        DataSource = dtsKASAHAR_MAS
        Enabled = False
        TabOrder = 4
      end
      object IB_Currency5: TIB_Currency
        Left = 235
        Top = 224
        Width = 109
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KASADEGER'
        DataSource = dtsKASAHAR_MAS
        Enabled = False
        TabOrder = 15
        AlwaysShowButton = True
      end
      object txtMAS_DOVKUR: TIB_Currency
        Left = 59
        Top = 224
        Width = 65
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'DOVKUR'
        DataSource = dtsKASAHAR_MAS
        TabOrder = 16
        OnEnter = txtFIS_NOEnter
        OnExit = txtMAS_DOVKURExit
        AlwaysShowButton = True
      end
      object IB_Edit3: TIB_Edit
        Left = 3
        Top = 224
        Width = 53
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'DOVKOD'
        DataSource = dtsKASAHAR_MAS
        Enabled = False
        TabOrder = 14
        OnEnter = txtFIS_NOEnter
      end
      object IB_Currency6: TIB_Currency
        Left = 127
        Top = 224
        Width = 109
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'TUTAR_VPB'
        DataSource = dtsKASAHAR_MAS
        Enabled = False
        TabOrder = 19
        AlwaysShowButton = True
      end
      object IB_Edit7: TIB_Edit
        Left = 0
        Top = 184
        Width = 469
        Height = 21
        AutoLabel.Kind = albTop
        AutoLabel.Caption = 'Yevmiye A'#231#305'klamas'#305
        DataField = 'YEVMIYE_ACK'
        DataSource = dtsKASAHAR_MAS
        Visible = False
        TabOrder = 13
        OnEnter = txtFIS_NOEnter
        OnExit = txtFIS_NOExit
      end
      object rgYAZICI: TRadioGroup
        Left = 2
        Top = 301
        Width = 353
        Height = 36
        Caption = 'Yazd'#305'rma'
        Columns = 3
        ItemIndex = 2
        Items.Strings = (
          'Yazd'#305'r'
          #214'n '#304'zleme'
          'Sadece Kay'#305't')
        TabOrder = 20
      end
      object rgTIP: TIB_RadioGroup
        Left = 317
        Top = 19
        Width = 152
        Height = 21
        DataField = 'TIP'
        DataSource = dtsKASAHAR_MAS
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 21
        OnEnter = rgTIPEnter
        OnExit = rgTIPExit
        Columns = 2
        Items.Strings = (
          'Giri'#351
          #199#305'k'#305#351)
        Values.Strings = (
          'G'
          'C')
        OnChange = rgTIPChange
      end
      object btnCikti: TButton
        Left = 358
        Top = 307
        Width = 112
        Height = 29
        Caption = 'Yaz'#305'c'#305' '#199#305'kt'#305's'#305
        TabOrder = 22
        TabStop = False
        OnClick = btnCiktiClick
      end
      object grpRapKod: TGroupBox
        Left = 2
        Top = 246
        Width = 469
        Height = 55
        TabOrder = 17
        object IB_Edit8: TIB_Edit
          Left = 7
          Top = 24
          Width = 83
          Height = 21
          AutoLabel.Kind = albTop
          AutoLabel.Caption = #304#351'lem Merkezi'
          DataField = 'MASRAF_MERK'
          DataSource = dtsKASAHAR_MAS
          TabOrder = 0
          OnEnter = IB_Edit8Enter
          OnExit = IB_Edit8Exit
          OnKeyUp = IB_Edit8KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit8ButtonClick
        end
        object IB_Edit10: TIB_Edit
          Left = 99
          Top = 24
          Width = 85
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD1'
          DataSource = dtsKASAHAR_MAS
          TabOrder = 1
          OnEnter = IB_Edit10Enter
          OnExit = IB_Edit10Exit
          OnKeyUp = IB_Edit10KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit10ButtonClick
        end
        object IB_Edit11: TIB_Edit
          Left = 193
          Top = 24
          Width = 81
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD2'
          DataSource = dtsKASAHAR_MAS
          TabOrder = 2
          OnEnter = IB_Edit11Enter
          OnExit = IB_Edit11Exit
          OnKeyUp = IB_Edit11KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit11ButtonClick
        end
        object IB_Edit12: TIB_Edit
          Left = 281
          Top = 24
          Width = 85
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD3'
          DataSource = dtsKASAHAR_MAS
          TabOrder = 3
          OnEnter = IB_Edit12Enter
          OnExit = IB_Edit12Exit
          OnKeyUp = IB_Edit12KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit12ButtonClick
        end
        object IB_Edit13: TIB_Edit
          Left = 375
          Top = 24
          Width = 85
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KOD4'
          DataSource = dtsKASAHAR_MAS
          TabOrder = 4
          OnEnter = IB_Edit13Enter
          OnExit = IB_Edit13Exit
          OnKeyUp = IB_Edit13KeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = IB_Edit13ButtonClick
        end
      end
      object txt_Cari_Kod: TIB_Edit
        Left = 63
        Top = 70
        Width = 121
        Height = 21
        AutoLabel.Kind = albLeft
        AutoLabel.Caption = 'Cari Kod'
        DataField = 'KARSIKOD'
        DataSource = dtsKASAHAR_MAS
        TabOrder = 5
        OnEnter = txtMAS_PROJE_KODEnter
        OnExit = txt_Cari_KodExit
        ButtonStyle = ebsEllipsis
        AlwaysShowButton = True
        OnButtonClick = txt_Cari_KodButtonClick
      end
      object IB_Edit9: TIB_Edit
        Left = 190
        Top = 70
        Width = 278
        Height = 21
        DataField = 'KARSI_AD'
        DataSource = dtsKASAHAR_MAS
        Enabled = False
        TabOrder = 6
      end
      object Cb_Aciklama: TIB_ComboBox
        Left = 0
        Top = 152
        Width = 471
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'ACIKLAMA'
        DataSource = dtsKASAHAR_MAS
        TabOrder = 11
        OnExit = IB_Edit1Exit
        ItemHeight = 13
      end
    end
    object tabDETAY: TTabSheet
      Caption = 'Kalemler (F6)'
      ImageIndex = 1
      object sbDEKONT: TStatusBar
        Left = 0
        Top = 399
        Width = 635
        Height = 19
        Panels = <
          item
            Bevel = pbRaised
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            Text = 'KASA'
            Width = 72
          end
          item
            Alignment = taCenter
            Width = 80
          end
          item
            Alignment = taCenter
            Bevel = pbRaised
            Text = 'TAHSIL'
            Width = 60
          end
          item
            Alignment = taCenter
            Bevel = pbRaised
            Text = 'KASA DE'#286'ER TOPLAMI'
            Width = 125
          end
          item
            Alignment = taCenter
            Text = 'KASA PB'
            Width = 50
          end
          item
            Alignment = taRightJustify
            Width = 50
          end>
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 635
        Height = 177
        Align = alTop
        TabOrder = 1
        object rdoCM: TIB_RadioGroup
          Left = 5
          Top = 7
          Width = 92
          Height = 30
          DataField = 'MC'
          DataSource = dtsKASAHAR
          OnClick = rdoCMClick
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 0
          OnEnter = rdoCMEnter
          OnExit = rdoCMExit
          Items.Strings = (
            'Cari'
            'Masraf')
          Values.Strings = (
            'C'
            'M')
        end
        object txtKARSI_KOD: TIB_Edit
          Left = 99
          Top = 16
          Width = 122
          Height = 21
          AutoLabel.Caption = 'Cari'
          DataField = 'KARSIKOD'
          DataSource = dtsKASAHAR
          TabOrder = 1
          OnEnter = txtFIS_NOEnter
          OnExit = txtKARSI_KODExit
          OnKeyPress = txtKARSI_KODKeyPress
          OnKeyUp = txtKARSI_KODKeyUp
          ButtonStyle = ebsEllipsis
          AlwaysShowButton = True
          OnButtonClick = txtKARSI_KODButtonClick
        end
        object edtDOVKUR: TIB_Currency
          Left = 98
          Top = 58
          Width = 99
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'DOVKUR'
          DataSource = dtsKASAHAR
          TabOrder = 4
          OnEnter = txtFIS_NOEnter
          OnExit = edtDOVKURExit
          AlwaysShowButton = True
        end
        object edtTUTAR: TIB_Currency
          Left = 201
          Top = 58
          Width = 135
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'TUTAR'
          DataSource = dtsKASAHAR
          TabOrder = 5
          OnEnter = txtFIS_NOEnter
          OnExit = edtTUTARExit
          AlwaysShowButton = True
        end
        object edtTUTARVPB: TIB_Currency
          Left = 339
          Top = 58
          Width = 136
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'TUTAR_VPB'
          DataSource = dtsKASAHAR
          Enabled = False
          TabOrder = 9
          AlwaysShowButton = True
        end
        object btnEKLE: TButton
          Left = 6
          Top = 146
          Width = 75
          Height = 23
          Caption = 'Ekle (INS)'
          TabOrder = 10
          OnClick = btnEKLEClick
        end
        object btnKAYDET: TButton
          Left = 83
          Top = 146
          Width = 97
          Height = 23
          Caption = 'Kaydet (CTRL+S)'
          TabOrder = 11
          OnClick = btnKAYDETClick
        end
        object btnSIL: TButton
          Left = 536
          Top = 146
          Width = 95
          Height = 23
          Caption = 'Sil (CTRL + DEL)'
          TabOrder = 12
          OnClick = btnSILClick
        end
        object btnIptal: TButton
          Left = 183
          Top = 146
          Width = 78
          Height = 23
          Caption = #304'ptal(CTRL+P)'
          TabOrder = 13
          OnClick = btnIptalClick
        end
        object IB_Edit5: TIB_Edit
          Left = 227
          Top = 16
          Width = 384
          Height = 21
          TabStop = False
          DataField = 'KARSI_AD'
          DataSource = dtsKASAHAR
          Enabled = False
          TabOrder = 2
        end
        object IB_Edit6: TIB_Edit
          Left = 295
          Top = 111
          Width = 604
          Height = 21
          DataField = 'ACIKLAMA'
          DataSource = dtsKASAHAR
          Visible = False
          TabOrder = 7
          OnEnter = txtFIS_NOEnter
          OnExit = IB_Edit6Exit
        end
        object IB_Currency4: TIB_Currency
          Left = 476
          Top = 58
          Width = 136
          Height = 21
          AutoLabel.Kind = albTop
          DataField = 'KASADEGER'
          DataSource = dtsKASAHAR
          Enabled = False
          TabOrder = 14
          AlwaysShowButton = True
        end
        object IB_Edit14: TIB_Edit
          Left = 7
          Top = 122
          Width = 604
          Height = 21
          AutoLabel.Kind = albTop
          AutoLabel.Caption = 'Yevmiye A'#231#305'klamas'#305
          DataField = 'YEVMIYE_ACK'
          DataSource = dtsKASAHAR
          Visible = False
          TabOrder = 8
          OnEnter = txtFIS_NOEnter
          OnExit = txtFIS_NOExit
        end
        object cboDOVKOD: TIB_ComboBox
          Left = 5
          Top = 58
          Width = 89
          Height = 21
          AutoLabel.Kind = albTop
          AutoLabel.Caption = 'D'#246'viz Kodu'
          DataField = 'DOVKOD'
          DataSource = dtsKASAHAR
          TabOrder = 3
          OnEnter = cboDOVKODEnter
          OnExit = cboDOVKODExit
          Style = csDropDownList
          ItemHeight = 13
        end
        object Cb_Aciklama1: TIB_ComboBox
          Left = 5
          Top = 85
          Width = 606
          Height = 21
          DataField = 'ACIKLAMA'
          DataSource = dtsKASAHAR
          TabOrder = 6
          OnExit = IB_Edit1Exit
          ItemHeight = 13
        end
      end
      object grdDekontKontrol: TIB_Grid
        Left = 0
        Top = 177
        Width = 635
        Height = 222
        CustomGlyphsSupplied = []
        DataSource = dtsKASAHAR
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
  object qryKASAHAR: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    FieldsDisplayLabel.Strings = (
      'FIS_NO=Fi'#351' No'
      'KASADEGER=KASADE'#286'ER'
      'PROJE_KOD=Proje Kod'
      'PROJE_AD=Proje Ad'
      'PLASIYER_KOD=Plasiyer Kod'
      'MC=MC'
      'KARSIKOD=Hesap Kodu'
      'KARSI_AD=Hesap Ad'#305
      'DOVKOD=Para Birimi'
      'DOVKUR=D'#246'viz Kuru'
      'TUTAR=Tutar'
      'TUTAR_VPB=Tutar VPB'
      'OLCUBIRIM='#214'l'#231#252' Birimi'
      'MIKTAR=Miktar')
    FieldsDisplayWidth.Strings = (
      'KARSIKOD=95'
      'DOVKOD=53')
    FieldsIndex.Strings = (
      'KASAHAR_ID'
      'KASAHAR_SID'
      'FIS_NO'
      'KASA_KOD'
      'TARIH'
      'DOV_BAZ_TAR'
      'BELGE_TUR'
      'BELGE_ID'
      'BELGE_SID'
      'TIP'
      'ACIKLAMA'
      'KARSIKOD'
      'KARSI_AD'
      'ISLEM_TIP'
      'PROJE_KOD'
      'PROJE_AD'
      'PLASIYER_KOD'
      'PLASIYER_AD'
      'MC'
      'SIRA_NO'
      'DOVKOD'
      'DOVKUR'
      'TUTAR'
      'KASADEGER'
      'TUTAR_VPB'
      'OLCUBIRIM'
      'MIKTAR')
    FieldsVisible.Strings = (
      'KASAHAR_ID=FALSE'
      'KASAHAR_SID=FALSE'
      'FIS_NO=FALSE'
      'KASA_KOD=FALSE'
      'TARIH=FALSE'
      'DOV_BAZ_TAR=FALSE'
      'BELGE_TUR=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE'
      'TIP=FALSE'
      'ISLEM_TIP=FALSE'
      'SIRA_NO=FALSE'
      'OLCUBIRIM=FALSE'
      'MIKTAR=FALSE'
      'PLASIYER_AD=FALSE'
      'PROJE_KOD=FALSE'
      'PROJE_AD=FALSE'
      'ACIKLAMA=FALSE'
      'PLASIYER_KOD=FALSE'
      'MC=FALSE'
      'DOVKOD=TRUE'
      'DOVKUR=FALSE'
      'TUTAR_VPB=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnKASAMUH
    SQL.Strings = (
      'SELECT KASAHAR_ID'
      '     , KASAHAR_SID'
      '     , KASA_KOD'
      '     , TARIH'
      '     , DOV_BAZ_TAR'
      '     , BELGE_TUR'
      '     , BELGE_ID'
      '     , BELGE_SID'
      '     , TIP'
      '     , ACIKLAMA'
      '     , KASADEGER'
      '     , ISLEM_TIP'
      '     , MC'
      '     , KARSIKOD'
      
        '     , (SELECT PRM_KARSI_AD FROM GET_KARSI_AD(KASAHAR.MC,KASAHAR' +
        '.KARSIKOD)) AS KARSI_AD'
      '     , SIRA_NO'
      '     , DOVKOD'
      '     , DOVKUR'
      '     , TUTAR'
      '     , TUTAR_VPB'
      '     , OLCUBIRIM'
      '     , MIKTAR'
      '     , YEVMIYE_ACK'
      'FROM KASAHAR'
      
        'WHERE ISLEM_TIP = 5 AND BELGE_ID=:PRM_BELGE_ID AND BELGE_SID=:PR' +
        'M_BELGE_SID'
      'ORDER BY KASAHAR_ID')
    ColorScheme = False
    DefaultValues.Strings = (
      'MIKTAR=0')
    GeneratorLinks.Strings = (
      'KASAHAR.KASAHAR_ID=GEN_KASAHAR')
    KeyLinks.Strings = (
      'KASAHAR.KASAHAR_ID'
      'KASAHAR.KASAHAR_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItemNo = 1
    OrderingItems.Strings = (
      'KASAHAR_ID=KASAHAR_ID;KASAHAR_ID DESC')
    OrderingLinks.Strings = (
      'KASAHAR_ID=ITEM=1')
    RequestLive = True
    AfterDelete = qryKASAHARAfterDelete
    AfterInsert = qryKASAHARAfterInsert
    AfterOpen = qryKASAHARAfterOpen
    AfterPost = qryKASAHARAfterPost
    AfterScroll = qryKASAHARAfterScroll
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 548
    Top = 30
    ParamValues = (
      'PRM_BELGE_ID=0')
  end
  object dtsKASAHAR: TIB_DataSource
    AutoInsert = False
    Dataset = qryKASAHAR
    OnDataChange = dtsKASAHARDataChange
    OnStateChanged = dtsKASAHARStateChanged
    Left = 540
    Top = 262
  end
  object trnKASAMUH: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 586
    Top = 54
  end
  object qryKASAHAR_MAS: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    FieldsDisplayLabel.Strings = (
      'FIS_NO=Fi'#351' No'
      'KASADEGER=Kasa De'#287'eri'
      'PROJE_KOD=Proje Kod'
      'PROJE_AD=Proje Ad'
      'PLASIYER_KOD=Plasiyer Kod'
      'MC=MC'
      'KARSIKOD=Hesap Kodu'
      'KARSI_AD=Hesap Ad'#305
      'DOVKOD=Para Birimi'
      'DOVKUR=D'#246'viz Kuru'
      'TUTAR=Tutar'
      'TUTAR_VPB=Tutar VPB'
      'OLCUBIRIM='#214'l'#231#252' Birimi'
      'MIKTAR=Miktar'
      'KASA_DOVKOD=P. Birimi'
      'KASA_KOD=Kasa'
      'TARIH='#304#351'lem Tarihi'
      'DOV_BAZ_TAR=D'#246'viz Baz Tarihi'
      'ACIKLAMA=A'#231#305'klama'
      'PLASIYER_AD=Plasiyer Ad'
      'KASAHAR_ID=FIS_NO')
    FieldsVisible.Strings = (
      'KASAHAR_ID=FALSE'
      'KASAHAR_SID=FALSE'
      'FIS_NO=FALSE'
      'KASA_KOD=FALSE'
      'TARIH=FALSE'
      'DOV_BAZ_TAR=FALSE'
      'BELGE_TUR=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE'
      'TIP=FALSE'
      'ISLEM_TIP=FALSE'
      'SIRA_NO=FALSE'
      'OLCUBIRIM=FALSE'
      'MIKTAR=FALSE'
      'PLASIYER_AD=FALSE'
      'PROJE_KOD=FALSE'
      'PROJE_AD=FALSE'
      'ACIKLAMA=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnKASAMUH
    SQL.Strings = (
      'SELECT KASAHAR_ID'
      '     , KASAHAR_SID'
      '     , KASA_KOD'
      
        '     , (SELECT ACIKLAMA FROM KASA WHERE KASAHAR.KASA_KOD = KASA.' +
        'KASA_KOD) AS KASA_AD'
      '     , TARIH'
      '     , DOV_BAZ_TAR'
      '     , BELGE_TUR'
      '     , BELGE_ID'
      '     , BELGE_SID'
      '     , TIP'
      '     , ACIKLAMA'
      '     , KASADEGER'
      '     , ISLEM_TIP'
      '     , PROJE_KOD'
      
        '     , (Select PROJE_AD from PROJE Where KASAHAR.PROJE_KOD = PRO' +
        'JE.PROJE_KOD) AS PROJE_AD'
      '     , PLASIYER_KOD'
      
        '     , (Select ADISOY from PLASIYER Where KASAHAR.PLASIYER_KOD =' +
        ' PLASIYER.PLASIYER_KOD) AS PLASIYER_AD'
      '     , MC'
      '     , KARSIKOD'
      
        '     , (SELECT PRM_KARSI_AD FROM GET_KARSI_AD(KASAHAR.MC,KASAHAR' +
        '.KARSIKOD)) AS KARSI_AD'
      '     , SIRA_NO'
      '     , DOVKOD'
      '     , DOVKUR'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2 '
      '     , KOD3'
      '     , KOD4'
      '     , TUTAR'
      '     , TUTAR_VPB'
      '     , OLCUBIRIM'
      '     , MIKTAR'
      '     , YEVMIYE_ACK'
      'FROM KASAHAR'
      
        'WHERE ISLEM_TIP = 5 AND KASAHAR_ID=:PRM_BELGE_ID AND KASAHAR_SID' +
        '=:PRM_BELGE_SID')
    ColorScheme = False
    DefaultValues.Strings = (
      'MIKTAR=0')
    GeneratorLinks.Strings = (
      'KASAHAR.KASAHAR_ID=GEN_KASAHAR')
    KeyLinks.Strings = (
      'KASAHAR.KASAHAR_ID'
      'KASAHAR.KASAHAR_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryKASAHAR_MASAfterInsert
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 510
    Top = 134
  end
  object dtsKASAHAR_MAS: TIB_DataSource
    AutoInsert = False
    Dataset = qryKASAHAR_MAS
    OnDataChange = dtsKASAHAR_MASDataChange
    OnStateChanged = dtsKASAHAR_MASStateChanged
    Left = 510
    Top = 198
  end
  object PopupMenu1: TPopupMenu
    Left = 574
    Top = 189
    object KasaMuhtelifTahsilTediyeKaydnKopyala1: TMenuItem
      Caption = 'Kasa - Muhtelif Tahsil / Tediye Kayd'#305'n'#305' Kopyala'
      OnClick = KasaMuhtelifTahsilTediyeKaydnKopyala1Click
    end
  end
end
