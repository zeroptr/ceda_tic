object frmBAKIM: TfrmBAKIM
  Left = 146
  Top = 140
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Bak'#305'm '#304#351'lemleri'
  ClientHeight = 518
  ClientWidth = 752
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 489
    Width = 752
    Height = 29
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      752
      29)
    object lblKAYIT: TLabel
      Left = 322
      Top = 10
      Width = 6
      Height = 13
      Caption = '0'
    end
    object btnCikis: TBitBtn
      Left = 686
      Top = 3
      Width = 61
      Height = 25
      Anchors = [akTop, akRight]
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
    object prgISLEM: TProgressBar
      Left = 4
      Top = 9
      Width = 265
      Height = 16
      Step = 1
      TabOrder = 1
    end
    object btnRaporKaydet: TButton
      Left = 364
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Kaydet'
      TabOrder = 2
      OnClick = btnRaporKaydetClick
    end
  end
  object txtRAPOR: TMemo
    Left = 0
    Top = 265
    Width = 752
    Height = 224
    Align = alClient
    ReadOnly = True
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 752
    Height = 265
    Align = alTop
    TabOrder = 2
    OnDblClick = Panel2DblClick
    DesignSize = (
      752
      265)
    object grpCARI: TGroupBox
      Left = 8
      Top = 0
      Width = 217
      Height = 249
      Caption = 'Cari Hareket'
      TabOrder = 0
      object chkCARI_YETIM_KAY_TARA: TCheckBox
        Left = 16
        Top = 20
        Width = 161
        Height = 17
        Caption = 'Yetim Cari Hareket Taramas'#305
        TabOrder = 0
        OnClick = chkCARI_YETIM_KAY_TARAClick
      end
      object GroupBox1: TGroupBox
        Left = 12
        Top = 140
        Width = 193
        Height = 101
        Caption = 'Modul Baz'#305'nda'
        TabOrder = 1
        object chklistCARI: TCheckListBox
          Left = 2
          Top = 15
          Width = 189
          Height = 84
          Align = alClient
          BorderStyle = bsNone
          ItemHeight = 13
          Items.Strings = (
            'Fatura'
            #199'ek'
            'Senet'
            #199'ek - Senet Hareketleri'
            'Dekont'
            'Kasa')
          TabOrder = 0
        end
      end
      object chkCARI_BA_DUZELT: TCheckBox
        Left = 16
        Top = 54
        Width = 160
        Height = 16
        Caption = 'Cari Bor'#231' Alacaklar'#305'n'#305' D'#252'zenle'
        TabOrder = 2
        OnClick = chkCARI_BA_DUZELTClick
      end
      object rgCARI_BA_DUZ: TRadioGroup
        Left = 12
        Top = 72
        Width = 197
        Height = 61
        Caption = 'Bor'#231' Alacak D'#252'zenleme '#350'ekli'
        Enabled = False
        ItemIndex = 0
        Items.Strings = (
          'Carihareket Toplamlar'#305' '#252'zerinden'
          'CARIHAR_AUD ile (Uzun yontem)')
        TabOrder = 3
      end
      object chkYET_CARIHAR_SIL: TCheckBox
        Left = 36
        Top = 36
        Width = 141
        Height = 17
        Caption = 'Yetim Cari Hareketleri Sil'
        Enabled = False
        TabOrder = 4
      end
    end
    object grpENTEGRE: TGroupBox
      Left = 228
      Top = 0
      Width = 249
      Height = 181
      Caption = 'Entegrasyon Kay'#305'tlar'#305
      TabOrder = 1
      Visible = False
      object chkENT_YETIM_KAY_TARA: TCheckBox
        Left = 12
        Top = 32
        Width = 213
        Height = 17
        Caption = 'Yetim Entegrasyon Kayd'#305' Taramas'#305
        TabOrder = 0
      end
      object chkENT_BA_TUTMAYAN_BELGE: TCheckBox
        Left = 12
        Top = 48
        Width = 221
        Height = 17
        Caption = 'Bor'#231' / Alaca'#287#305' Tutmayan Belge Taramas'#305
        TabOrder = 1
      end
      object GroupBox2: TGroupBox
        Left = 10
        Top = 69
        Width = 213
        Height = 101
        Caption = 'Modul Baz'#305'nda'
        TabOrder = 2
        object chklistENTEGRE: TCheckListBox
          Left = 2
          Top = 15
          Width = 209
          Height = 84
          Align = alClient
          BorderStyle = bsNone
          ItemHeight = 13
          Items.Strings = (
            'Fatura'
            #199'ek'
            'Senet'
            #199'ek - Senet Hareketleri'
            'Dekont'
            'Kasa')
          TabOrder = 0
        end
      end
      object chkENT_DURUM_1_KAY_SIL: TCheckBox
        Left = 12
        Top = 16
        Width = 197
        Height = 17
        Caption = 'Silinmi'#351' veya De'#287'i'#351'tirilmi'#351' Kay'#305'tlar'#305' Sil'
        TabOrder = 3
      end
    end
    object Button1: TButton
      Left = 230
      Top = 220
      Width = 247
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Ba'#351'la'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 492
      Top = 10
      Width = 247
      Height = 25
      Caption = #220'r'#252'n Bor'#231' Alacaklar'#305'n'#305' Yeniden D'#252'zenle'
      TabOrder = 3
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 492
      Top = 42
      Width = 247
      Height = 25
      Caption = 'Cari Bor'#231' Alacaklar'#305'n'#305' Yeniden D'#252'zenle'
      TabOrder = 4
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 492
      Top = 72
      Width = 247
      Height = 25
      Caption = 'Proje Borc Alacaklar'#305'n'#305' Yeniden D'#252'zenle'
      TabOrder = 5
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 492
      Top = 104
      Width = 247
      Height = 25
      Caption = 'Kasa Borc Alacaklar'#305'n'#305' Yeniden D'#252'zenle'
      TabOrder = 6
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 493
      Top = 136
      Width = 246
      Height = 25
      Caption = 'Masraf Borc Alacaklar'#305'n'#305' Yeniden D'#252'zenle'
      TabOrder = 7
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 493
      Top = 168
      Width = 246
      Height = 25
      Caption = 'Ara'#231' Borc Alacaklar'#305'n'#305' Yeniden D'#252'zenle'
      TabOrder = 8
      Visible = False
      OnClick = Button7Click
    end
    object Button8: TButton
      Left = 493
      Top = 200
      Width = 246
      Height = 25
      Caption = 'Personel Borc Alacaklar'#305'n'#305' Yeniden D'#252'zenle'
      TabOrder = 9
      Visible = False
      OnClick = Button8Click
    end
  end
  object sDialog: TSaveDialog
    DefaultExt = '*.txt'
    Filter = 'Text Dosyalar'#305'|*.txt'
    Left = 492
    Top = 332
  end
end
