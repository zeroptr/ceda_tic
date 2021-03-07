object frm_Kantar_Cikis: Tfrm_Kantar_Cikis
  Left = 121
  Top = 130
  Width = 623
  Height = 385
  ActiveControl = Pnl_Cikis
  Caption = 'Kantar Fi'#351'i '#199#305'k'#305#351#305
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object IB_Text1: TIB_Text
    Left = 104
    Top = 32
    Width = 97
    Height = 17
    DataField = 'PLAKA_NO'
    DataSource = frm_Kantar.DtsKantar
  end
  object Label1: TLabel
    Left = 32
    Top = 32
    Width = 44
    Height = 13
    Caption = 'Plaka No'
  end
  object Label2: TLabel
    Left = 32
    Top = 64
    Width = 36
    Height = 13
    Caption = 'Cari Ad'#305
  end
  object IB_Text2: TIB_Text
    Left = 104
    Top = 64
    Width = 273
    Height = 17
    DataField = 'CARI_AD'
    DataSource = frm_Kantar.DtsKantar
  end
  object Label3: TLabel
    Left = 32
    Top = 96
    Width = 41
    Height = 13
    Caption = #220'r'#252'n Ad'#305
  end
  object IB_Text3: TIB_Text
    Left = 104
    Top = 96
    Width = 273
    Height = 17
    DataField = 'URUN_AD'
    DataSource = frm_Kantar.DtsKantar
  end
  object Label4: TLabel
    Left = 32
    Top = 128
    Width = 51
    Height = 13
    Caption = 'Geldi'#287'i Yer'
  end
  object IB_Text4: TIB_Text
    Left = 104
    Top = 128
    Width = 273
    Height = 17
    DataField = 'GELDIGI_YER'
    DataSource = frm_Kantar.DtsKantar
  end
  object Label5: TLabel
    Left = 32
    Top = 160
    Width = 45
    Height = 13
    Caption = 'Gitti'#287'i Yer'
  end
  object IB_Text5: TIB_Text
    Left = 104
    Top = 160
    Width = 273
    Height = 17
    DataField = 'GITTIGI_YER'
    DataSource = frm_Kantar.DtsKantar
  end
  object IB_Text6: TIB_Text
    Left = 104
    Top = 192
    Width = 273
    Height = 17
    DataField = 'ACIKLAMA'
    DataSource = frm_Kantar.DtsKantar
  end
  object Label6: TLabel
    Left = 32
    Top = 192
    Width = 43
    Height = 13
    Caption = 'A'#231#305'klama'
  end
  object Label7: TLabel
    Left = 440
    Top = 56
    Width = 49
    Height = 13
    Caption = 'Giri'#351' Tarihi'
  end
  object IB_Text7: TIB_Text
    Left = 512
    Top = 56
    Width = 65
    Height = 17
    DataField = 'GIRIS_TARIHI'
    DataSource = frm_Kantar.DtsKantar
  end
  object Label8: TLabel
    Left = 440
    Top = 88
    Width = 47
    Height = 13
    Caption = 'Giri'#351' Saati'
  end
  object IB_Text8: TIB_Text
    Left = 512
    Top = 88
    Width = 65
    Height = 17
    DataField = 'GIRIS_SAATI'
    DataSource = frm_Kantar.DtsKantar
  end
  object Label9: TLabel
    Left = 440
    Top = 120
    Width = 45
    Height = 13
    Caption = 'Ara'#231' Kilo '
  end
  object IB_Text9: TIB_Text
    Left = 512
    Top = 120
    Width = 65
    Height = 17
    DataField = 'ARAC_KILO'
    DataSource = frm_Kantar.DtsKantar
  end
  object Label10: TLabel
    Left = 440
    Top = 152
    Width = 51
    Height = 13
    Caption = 'Giri'#351' Kilosu'
  end
  object IB_Text10: TIB_Text
    Left = 512
    Top = 152
    Width = 65
    Height = 17
    DataField = 'GIRIS_KILO'
    DataSource = frm_Kantar.DtsKantar
  end
  object Pnl_Cikis: TPanel
    Left = 8
    Top = 232
    Width = 597
    Height = 81
    TabOrder = 0
    object IB_Edit12: TIB_Edit
      Left = 240
      Top = 16
      Width = 121
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'CIKIS_KILO'
      DataSource = frm_Kantar.DtsKantar
      TabOrder = 2
    end
    object IB_Edit13: TIB_Edit
      Left = 240
      Top = 48
      Width = 119
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'FARK_KILO'
      DataSource = frm_Kantar.DtsKantar
      Enabled = False
      ReadOnly = True
      TabOrder = 4
    end
    object IB_Date3: TIB_Date
      Left = 64
      Top = 48
      Width = 89
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'CIKIS_SAATI'
      DataSource = frm_Kantar.DtsKantar
      TabOrder = 1
      IncCellHeight = 1
      IncCellWidth = 2
      DrawYearArrow = False
    end
    object IB_Date4: TIB_Date
      Left = 64
      Top = 16
      Width = 90
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'CIKIS_TARIHI'
      DataSource = frm_Kantar.DtsKantar
      TabOrder = 0
      IncCellHeight = 1
      IncCellWidth = 2
      DrawYearArrow = False
    end
    object IB_Edit4: TIB_Edit
      Left = 464
      Top = 16
      Width = 115
      Height = 21
      AutoLabel.Kind = albLeft
      DataField = 'UCRETI'
      DataSource = frm_Kantar.DtsKantar
      TabOrder = 5
    end
    object Btn_Cikis_Kilo: TBitBtn
      Left = 368
      Top = 16
      Width = 57
      Height = 25
      Caption = 'Kilo Al'
      TabOrder = 3
      Visible = False
    end
  end
  object btnCikis: TBitBtn
    Left = 532
    Top = 328
    Width = 72
    Height = 25
    Caption = #199#305'k'#305#351
    TabOrder = 1
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
  object BitBtn1: TBitBtn
    Left = 8
    Top = 328
    Width = 97
    Height = 25
    Caption = #199#305'k'#305#351' '#304#351'lemini Yap'
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn3: TBitBtn
    Left = 136
    Top = 328
    Width = 97
    Height = 25
    Caption = 'Fi'#351' Yazd'#305'r'
    TabOrder = 3
    OnClick = BitBtn3Click
  end
end
