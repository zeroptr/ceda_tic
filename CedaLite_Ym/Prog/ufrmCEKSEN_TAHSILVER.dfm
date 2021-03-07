object frmCEKSEN_TAHSILVER: TfrmCEKSEN_TAHSILVER
  Left = 319
  Top = 162
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'M'#252#351'teri '#199'ek / Senet Tahsile Verme'
  ClientHeight = 274
  ClientWidth = 495
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object lblNO: TLabel
    Left = 6
    Top = 11
    Width = 14
    Height = 13
    Caption = 'No'
  end
  object lblSUBEKODL: TLabel
    Left = 189
    Top = 9
    Width = 56
    Height = 13
    Caption = #350'ube Kodu:'
  end
  object lblSUBEKOD: TLabel
    Left = 249
    Top = 9
    Width = 45
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblCARIKOD: TLabel
    Left = 8
    Top = 54
    Width = 69
    Height = 13
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblCARIAD: TLabel
    Left = 88
    Top = 54
    Width = 399
    Height = 13
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblTANZIMTAR: TLabel
    Left = 80
    Top = 74
    Width = 74
    Height = 13
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblTANZIMTARL: TLabel
    Left = 8
    Top = 74
    Width = 66
    Height = 13
    Caption = 'Tanzim Tarihi:'
  end
  object lblTUTARBIL: TLabel
    Left = 8
    Top = 98
    Width = 54
    Height = 13
    Caption = 'Tutar Bilgisi'
  end
  object lblDOVKOD: TLabel
    Left = 8
    Top = 114
    Width = 44
    Height = 13
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblDOVKUR: TLabel
    Left = 58
    Top = 114
    Width = 99
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblTUTAR: TLabel
    Left = 162
    Top = 114
    Width = 145
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblTUTAR_VPB: TLabel
    Left = 312
    Top = 114
    Width = 174
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblSAHIPL: TLabel
    Left = 164
    Top = 74
    Width = 29
    Height = 13
    Caption = 'Sahibi'
  end
  object lblCEKSAHIBI: TLabel
    Left = 198
    Top = 74
    Width = 289
    Height = 13
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblCIROCARI_AD: TLabel
    Left = 165
    Top = 150
    Width = 322
    Height = 17
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblCiroCariKod: TLabel
    Left = 7
    Top = 137
    Width = 140
    Height = 13
    Caption = 'Tahsil Edilecek Banka Kodu :'
  end
  object Label5: TLabel
    Left = 6
    Top = 182
    Width = 53
    Height = 13
    Caption = #304#351'lem Tarihi'
  end
  object Label7: TLabel
    Left = 7
    Top = 201
    Width = 112
    Height = 13
    Caption = 'Cari Hareket A'#231#305'klamas'#305
  end
  object Label9: TLabel
    Left = 105
    Top = 98
    Width = 52
    Height = 13
    Caption = 'D'#246'viz Kuru'
  end
  object Label10: TLabel
    Left = 280
    Top = 98
    Width = 25
    Height = 13
    Caption = 'Tutar'
  end
  object Label11: TLabel
    Left = 436
    Top = 100
    Width = 49
    Height = 13
    Caption = 'Tutar VPB'
  end
  object Label12: TLabel
    Left = -74
    Top = 287
    Width = 64
    Height = 13
    Caption = #304#351'lem Merkezi'
  end
  object lblCEKNUML: TLabel
    Left = 303
    Top = 9
    Width = 72
    Height = 13
    Caption = #199'ek Numaras'#305' :'
  end
  object lblCEKNUM: TLabel
    Left = 381
    Top = 9
    Width = 106
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object Label18: TLabel
    Left = 6
    Top = 33
    Width = 96
    Height = 13
    Caption = 'Belge Fi'#351' Numaras'#305' :'
  end
  object lblBelgeFisNo: TLabel
    Left = 107
    Top = 33
    Width = 140
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object txtNO: TEdit
    Left = 27
    Top = 5
    Width = 125
    Height = 21
    Enabled = False
    TabOrder = 0
  end
  object btnCEKSENLIST: TButton
    Left = 156
    Top = 6
    Width = 18
    Height = 20
    Caption = '...'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnCEKSENLISTClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 244
    Width = 495
    Height = 30
    Align = alBottom
    TabOrder = 6
    object btnYeni: TBitBtn
      Left = 3
      Top = 3
      Width = 70
      Height = 24
      Caption = 'Yeni (INS)'
      TabOrder = 0
      OnClick = btnYeniClick
      NumGlyphs = 2
    end
    object btnCIRO: TButton
      Left = 72
      Top = 3
      Width = 94
      Height = 24
      Caption = '&Kaydet(CTRL+S) '
      Enabled = False
      TabOrder = 1
      OnClick = btnCIROClick
    end
    object btnIPTAL: TButton
      Left = 165
      Top = 3
      Width = 79
      Height = 24
      Caption = #304'ptal(CTRL+P)'
      Enabled = False
      TabOrder = 2
      OnClick = btnIPTALClick
    end
    object btnAra: TBitBtn
      Left = 354
      Top = 3
      Width = 68
      Height = 24
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
    object btnSil: TButton
      Left = 243
      Top = 3
      Width = 87
      Height = 24
      Caption = 'Sil (CTRL+DEL)'
      TabOrder = 3
      OnClick = btnSilClick
    end
    object btnCIKIS: TBitBtn
      Left = 421
      Top = 3
      Width = 70
      Height = 24
      Caption = #199#305'&k'#305#351
      TabOrder = 5
      OnClick = btnCIKISClick
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
  end
  object btnCariKod: TButton
    Left = 144
    Top = 149
    Width = 18
    Height = 20
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    TabStop = False
    OnClick = btnCariKodClick
  end
  object txtCARIKOD: TEdit
    Left = 6
    Top = 149
    Width = 138
    Height = 21
    TabOrder = 2
    OnExit = txt_CARIKODExit
    OnKeyDown = txt_CARIKODKeyDown
    OnKeyPress = txt_CARIKODKeyPress
  end
  object dtpIslemTar: TDateTimePicker
    Left = 66
    Top = 176
    Width = 139
    Height = 21
    Date = 37673.434705185190000000
    Time = 37673.434705185190000000
    TabOrder = 4
  end
  object txtCARIHARACK: TEdit
    Left = 7
    Top = 215
    Width = 481
    Height = 21
    TabOrder = 5
  end
  object trnCekSenHar: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    Left = 409
    Top = 54
  end
end
