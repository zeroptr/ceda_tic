object frm_Kantar_Degistir: Tfrm_Kantar_Degistir
  Left = 350
  Top = 81
  Width = 559
  Height = 521
  Caption = 'Kantar Fi'#351'i Degistir'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Giris: TPanel
    Left = 0
    Top = 0
    Width = 548
    Height = 457
    TabOrder = 0
    object txtPlaka_No: TIB_Edit
      Left = 72
      Top = 24
      Width = 116
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'PLAKA_NO'
      DataSource = frm_Kantar.DtsKantar
      TabOrder = 0
      ButtonStyle = ebsEllipsis
    end
    object txtCari_Kod: TIB_Edit
      Left = 72
      Top = 56
      Width = 116
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'CARI_KOD'
      DataSource = frm_Kantar.DtsKantar
      TabOrder = 1
      ButtonStyle = ebsEllipsis
    end
    object IB_Edit3: TIB_Edit
      Left = 256
      Top = 56
      Width = 280
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'CARI_AD'
      DataSource = frm_Kantar.DtsKantar
      Enabled = False
      TabOrder = 2
    end
    object txtUrun_Kod: TIB_Edit
      Left = 72
      Top = 88
      Width = 116
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'URUN_KOD'
      DataSource = frm_Kantar.DtsKantar
      TabOrder = 3
      ButtonStyle = ebsEllipsis
    end
    object IB_Edit5: TIB_Edit
      Left = 256
      Top = 88
      Width = 280
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'URUN_AD'
      DataSource = frm_Kantar.DtsKantar
      Enabled = False
      TabOrder = 4
    end
    object IB_Edit10: TIB_Edit
      Left = 248
      Top = 216
      Width = 112
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'ARAC_KILO'
      DataSource = frm_Kantar.DtsKantar
      TabOrder = 5
    end
    object IB_Edit11: TIB_Edit
      Left = 248
      Top = 248
      Width = 112
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'GIRIS_KILO'
      DataSource = frm_Kantar.DtsKantar
      TabOrder = 6
    end
    object IB_Date1: TIB_Date
      Left = 72
      Top = 216
      Width = 92
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'GIRIS_TARIHI'
      DataSource = frm_Kantar.DtsKantar
      TabOrder = 7
      IncCellHeight = 1
      IncCellWidth = 2
      DrawYearArrow = False
    end
    object IB_ComboBox1: TIB_ComboBox
      Left = 216
      Top = 24
      Width = 140
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'TIPI'
      DataSource = frm_Kantar.DtsKantar
      Enabled = False
      TabOrder = 8
      Style = csDropDownList
      ItemHeight = 13
      Items.Strings = (
        'Giri'#351
        #199#305'k'#305#351)
      ItemValues.Strings = (
        'G'
        'C')
    end
    object IB_Edit2: TIB_Edit
      Left = 432
      Top = 24
      Width = 104
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'MAKBUZ_NO'
      DataSource = frm_Kantar.DtsKantar
      TabOrder = 9
    end
    object BitBtn1: TBitBtn
      Left = 376
      Top = 248
      Width = 53
      Height = 25
      Caption = 'Kilo Al'
      TabOrder = 10
    end
    object Cb_Geldigi_Yer: TIB_ComboBox
      Left = 70
      Top = 120
      Width = 466
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'GELDIGI_YER'
      DataSource = frm_Kantar.DtsKantar
      TabOrder = 11
      ItemHeight = 13
    end
    object Cb_Gittigi_Yer: TIB_ComboBox
      Left = 70
      Top = 152
      Width = 466
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'GITTIGI_YER'
      DataSource = frm_Kantar.DtsKantar
      TabOrder = 12
      ItemHeight = 13
    end
    object Cb_Aciklama: TIB_ComboBox
      Left = 70
      Top = 184
      Width = 466
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'ACIKLAMA'
      DataSource = frm_Kantar.DtsKantar
      TabOrder = 13
      ItemHeight = 13
    end
    object IB_Date4: TIB_Date
      Left = 72
      Top = 248
      Width = 92
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'GIRIS_SAATI'
      DataSource = frm_Kantar.DtsKantar
      TabOrder = 14
      IncCellHeight = 1
      IncCellWidth = 2
      DrawYearArrow = False
    end
    object Btn_Cikis_Yap: TBitBtn
      Left = 456
      Top = 248
      Width = 75
      Height = 25
      Caption = #199#305'k'#305#351#305'n'#305' Yap'
      TabOrder = 15
    end
    object grpRapKod: TGroupBox
      Left = 1
      Top = 365
      Width = 546
      Height = 91
      Align = alBottom
      TabOrder = 16
      object IB_Edit1: TIB_Edit
        Left = 8
        Top = 21
        Width = 79
        Height = 21
        AutoLabel.Kind = albTop
        AutoLabel.Caption = #304#351'lem Merkezi'
        DataField = 'MASRAF_MERK'
        DataSource = frm_Kantar.DtsKantar
        TabOrder = 0
        ButtonStyle = ebsEllipsis
      end
      object IB_Edit6: TIB_Edit
        Left = 118
        Top = 21
        Width = 85
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KOD1'
        DataSource = frm_Kantar.DtsKantar
        TabOrder = 1
        ButtonStyle = ebsEllipsis
      end
      object IB_Edit7: TIB_Edit
        Left = 226
        Top = 21
        Width = 81
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KOD2'
        DataSource = frm_Kantar.DtsKantar
        TabOrder = 2
        ButtonStyle = ebsEllipsis
      end
      object IB_Edit24: TIB_Edit
        Left = 334
        Top = 21
        Width = 85
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KOD3'
        DataSource = frm_Kantar.DtsKantar
        TabOrder = 3
        ButtonStyle = ebsEllipsis
      end
      object IB_Edit25: TIB_Edit
        Left = 445
        Top = 21
        Width = 85
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KOD4'
        DataSource = frm_Kantar.DtsKantar
        TabOrder = 4
        ButtonStyle = ebsEllipsis
      end
      object txtKasaKod: TIB_Edit
        Left = 118
        Top = 52
        Width = 121
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'KASA_KOD'
        DataSource = frm_Kantar.DtsKantar
        TabOrder = 5
        ButtonStyle = ebsEllipsis
      end
      object txtKasaAd: TIB_Edit
        Left = 332
        Top = 52
        Width = 197
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'KASA_AD'
        DataSource = frm_Kantar.DtsKantar
        Enabled = False
        TabOrder = 6
      end
    end
    object Btn_Giris_Yaz: TBitBtn
      Left = 456
      Top = 219
      Width = 73
      Height = 25
      Caption = 'Fi'#351' Yazd'#305'r'
      TabOrder = 17
    end
    object Pnl_Cikis: TPanel
      Left = 1
      Top = 284
      Width = 546
      Height = 81
      Align = alBottom
      TabOrder = 18
      Visible = False
      object IB_Edit12: TIB_Edit
        Left = 224
        Top = 16
        Width = 89
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'CIKIS_KILO'
        DataSource = frm_Kantar.DtsKantar
        TabOrder = 0
      end
      object IB_Edit13: TIB_Edit
        Left = 224
        Top = 48
        Width = 89
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'FARK_KILO'
        DataSource = frm_Kantar.DtsKantar
        ReadOnly = True
        TabOrder = 1
      end
      object IB_Date3: TIB_Date
        Left = 56
        Top = 48
        Width = 87
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'CIKIS_SAATI'
        DataSource = frm_Kantar.DtsKantar
        TabOrder = 2
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
      object IB_Edit4: TIB_Edit
        Left = 424
        Top = 16
        Width = 88
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'UCRETI'
        DataSource = frm_Kantar.DtsKantar
        TabOrder = 3
      end
      object BitBtn2: TBitBtn
        Left = 320
        Top = 16
        Width = 57
        Height = 25
        Caption = 'Kilo Al'
        TabOrder = 4
        Visible = False
      end
      object IB_Date2: TIB_Date
        Left = 56
        Top = 12
        Width = 88
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'CIKIS_TARIHI'
        DataSource = frm_Kantar.DtsKantar
        TabOrder = 5
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
    end
  end
  object BitBtn3: TBitBtn
    Left = 8
    Top = 464
    Width = 75
    Height = 25
    Caption = 'Kaydet '#199#305'k'
    TabOrder = 1
  end
  object BitBtn4: TBitBtn
    Left = 448
    Top = 464
    Width = 91
    Height = 25
    Caption = 'Kaydetmeden '#199#305'k'
    TabOrder = 2
  end
end
