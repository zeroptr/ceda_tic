object frmCEKSEN_KASA: TfrmCEKSEN_KASA
  Left = 412
  Top = 171
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #199'ek / Senet Tahsil / Tediye'
  ClientHeight = 559
  ClientWidth = 498
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
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object lblNO: TLabel
    Left = 6
    Top = 14
    Width = 14
    Height = 13
    Caption = 'No'
  end
  object lblSUBEKODL: TLabel
    Left = 189
    Top = 12
    Width = 56
    Height = 13
    Caption = #350'ube Kodu:'
  end
  object lblSUBEKOD: TLabel
    Left = 249
    Top = 12
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
    Top = 65
    Width = 69
    Height = 13
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblCARIAD: TLabel
    Left = 88
    Top = 65
    Width = 399
    Height = 13
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblTANZIMTAR: TLabel
    Left = 80
    Top = 85
    Width = 74
    Height = 13
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblTANZIMTARL: TLabel
    Left = 8
    Top = 85
    Width = 66
    Height = 13
    Caption = 'Tanzim Tarihi:'
  end
  object lblTUTARBIL: TLabel
    Left = 8
    Top = 109
    Width = 54
    Height = 13
    Caption = 'Tutar Bilgisi'
  end
  object lblDOVKOD: TLabel
    Left = 8
    Top = 125
    Width = 44
    Height = 13
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblDOVKUR: TLabel
    Left = 58
    Top = 125
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
    Top = 125
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
    Top = 125
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
    Top = 85
    Width = 29
    Height = 13
    Caption = 'Sahibi'
  end
  object lblCEKSAHIBI: TLabel
    Left = 198
    Top = 85
    Width = 289
    Height = 13
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblKASA_AD: TLabel
    Left = 152
    Top = 160
    Width = 335
    Height = 17
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object Label2: TLabel
    Left = 156
    Top = 182
    Width = 48
    Height = 13
    Caption = 'Proje Ad'#305' :'
  end
  object Label4: TLabel
    Left = 156
    Top = 223
    Width = 60
    Height = 13
    Caption = 'Plasiyer Ad'#305' :'
  end
  object lblPrjAd: TLabel
    Left = 152
    Top = 197
    Width = 335
    Height = 17
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblPlasiyerAd: TLabel
    Left = 152
    Top = 236
    Width = 335
    Height = 17
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblCiroCariKod: TLabel
    Left = 7
    Top = 148
    Width = 58
    Height = 13
    Caption = 'Kasa Kodu :'
  end
  object Label1: TLabel
    Left = 6
    Top = 183
    Width = 58
    Height = 13
    Caption = 'Proje Kodu :'
  end
  object Label3: TLabel
    Left = 6
    Top = 219
    Width = 70
    Height = 13
    Caption = 'Plasiyer Kodu :'
  end
  object Label5: TLabel
    Left = 6
    Top = 269
    Width = 53
    Height = 13
    Caption = #304#351'lem Tarihi'
  end
  object Label6: TLabel
    Left = 264
    Top = 269
    Width = 77
    Height = 13
    Caption = 'D'#246'viz Baz Tarihi'
  end
  object Label7: TLabel
    Left = 7
    Top = 412
    Width = 112
    Height = 13
    Caption = 'Cari Hareket A'#231#305'klamas'#305
  end
  object Label8: TLabel
    Left = 6
    Top = 451
    Width = 93
    Height = 13
    Caption = 'Yevmiye A'#231#305'klamas'#305
    Visible = False
  end
  object Label9: TLabel
    Left = 105
    Top = 109
    Width = 52
    Height = 13
    Caption = 'D'#246'viz Kuru'
  end
  object Label10: TLabel
    Left = 280
    Top = 109
    Width = 25
    Height = 13
    Caption = 'Tutar'
  end
  object Label11: TLabel
    Left = 436
    Top = 111
    Width = 49
    Height = 13
    Caption = 'Tutar VPB'
  end
  object lblCEKNUML: TLabel
    Left = 303
    Top = 12
    Width = 72
    Height = 13
    Caption = #199'ek Numaras'#305' :'
  end
  object lblCEKNUM: TLabel
    Left = 381
    Top = 12
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
    Top = 39
    Width = 96
    Height = 13
    Caption = 'Belge Fi'#351' Numaras'#305' :'
  end
  object lblBelgeFisNo: TLabel
    Left = 107
    Top = 39
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
    Top = 8
    Width = 125
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 0
  end
  object btnCEKSENLIST: TButton
    Left = 155
    Top = 8
    Width = 17
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
    Top = 529
    Width = 498
    Height = 30
    Align = alBottom
    TabOrder = 16
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
      Left = 365
      Top = 3
      Width = 62
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
      Left = 426
      Top = 3
      Width = 67
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
  object txtDOVKUR: TIB_Currency
    Left = 65
    Top = 293
    Width = 139
    Height = 21
    AutoLabel.Kind = albLeft
    AutoLabel.Caption = 'D'#246'viz Kuru  '
    TabOrder = 10
    OnEnter = txtDOVKUREnter
    OnExit = txtDOVKURExit
    AlwaysShowButton = True
    OnChange = txtDOVKURChange
  end
  object txtTUTARVPB: TIB_Currency
    Left = 298
    Top = 293
    Width = 187
    Height = 21
    AutoLabel.Kind = albLeft
    AutoLabel.Caption = 'Tutar VPB'
    Enabled = False
    ReadOnly = True
    TabOrder = 12
    AlwaysShowButton = True
  end
  object txtKURFARK: TIB_Currency
    Left = 298
    Top = 319
    Width = 187
    Height = 21
    AutoLabel.Kind = albLeft
    AutoLabel.Caption = 'Kur Fark'#305
    Enabled = False
    ReadOnly = True
    TabOrder = 13
    AlwaysShowButton = True
  end
  object btnKASAKOD: TButton
    Left = 128
    Top = 161
    Width = 17
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
    OnClick = btnKASAKODClick
  end
  object btnProjeKod: TButton
    Left = 129
    Top = 197
    Width = 17
    Height = 20
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    TabStop = False
    OnClick = btnProjeKodClick
  end
  object btnPlasiyerKod: TButton
    Left = 129
    Top = 233
    Width = 17
    Height = 20
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    TabStop = False
    OnClick = btnPlasiyerKodClick
  end
  object txtKASAKOD: TEdit
    Left = 6
    Top = 160
    Width = 121
    Height = 21
    TabOrder = 2
    OnEnter = txtKASAKODEnter
    OnExit = txtKASAKODExit
    OnKeyDown = txtKASAKODKeyDown
    OnKeyPress = txtKASAKODKeyPress
  end
  object txtPROJEKOD: TEdit
    Left = 6
    Top = 197
    Width = 121
    Height = 21
    TabOrder = 4
    OnEnter = txtKASAKODEnter
    OnExit = txtPROJEKODExit
    OnKeyDown = txtPROJEKODKeyDown
    OnKeyPress = txtPROJEKODKeyPress
  end
  object txtPLASIYERKOD: TEdit
    Left = 6
    Top = 233
    Width = 121
    Height = 21
    TabOrder = 6
    OnEnter = txtKASAKODEnter
    OnExit = txtPLASIYERKODExit
    OnKeyDown = txtPLASIYERKODKeyDown
    OnKeyPress = txtPLASIYERKODKeyPress
  end
  object dtpISLEMTAR: TDateTimePicker
    Left = 66
    Top = 263
    Width = 139
    Height = 21
    Date = 37673.434705185190000000
    Time = 37673.434705185190000000
    TabOrder = 8
    OnEnter = dtpISLEMTAREnter
    OnExit = dtpISLEMTARExit
  end
  object dtpDOVBAZTAR: TDateTimePicker
    Left = 347
    Top = 262
    Width = 139
    Height = 21
    Date = 37673.436109803240000000
    Time = 37673.436109803240000000
    TabOrder = 9
    OnCloseUp = dtpDOVBAZTARCloseUp
    OnEnter = dtpISLEMTAREnter
    OnExit = dtpISLEMTARExit
  end
  object txtCARIHARACK: TEdit
    Left = 3
    Top = 428
    Width = 490
    Height = 21
    TabOrder = 14
    OnEnter = txtKASAKODEnter
    OnExit = txtCARIHARACKExit
  end
  object txtYEVMIYEACK: TEdit
    Left = 3
    Top = 465
    Width = 490
    Height = 21
    TabOrder = 15
    Visible = False
    OnEnter = txtKASAKODEnter
    OnExit = txtCARIHARACKExit
  end
  object rgYAZICI: TRadioGroup
    Left = 4
    Top = 488
    Width = 387
    Height = 37
    Caption = 'Yazd'#305'rma'
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      'Yazd'#305'r'
      #214'n '#304'zleme'
      'Sadece Kay'#305't')
    TabOrder = 17
  end
  object btnCikti: TButton
    Left = 395
    Top = 494
    Width = 100
    Height = 30
    Caption = 'Yaz'#305'c'#305' '#199#305'kt'#305's'#305
    TabOrder = 18
    TabStop = False
    OnClick = btnCiktiClick
  end
  object grpRapKod: TGroupBox
    Left = 4
    Top = 348
    Width = 489
    Height = 61
    TabOrder = 11
    object Label12: TLabel
      Left = 10
      Top = 12
      Width = 64
      Height = 13
      Caption = #304#351'lem Merkezi'
    end
    object Label13: TLabel
      Left = 102
      Top = 12
      Width = 29
      Height = 13
      Caption = 'KOD1'
    end
    object Label14: TLabel
      Left = 197
      Top = 12
      Width = 29
      Height = 13
      Caption = 'KOD2'
    end
    object Label15: TLabel
      Left = 293
      Top = 12
      Width = 29
      Height = 13
      Caption = 'KOD3'
    end
    object Label16: TLabel
      Left = 384
      Top = 12
      Width = 29
      Height = 13
      Caption = 'KOD4'
    end
    object txtISLEMMERKEZI: TEdit
      Left = 9
      Top = 28
      Width = 71
      Height = 21
      TabOrder = 0
      OnEnter = txtKASAKODEnter
      OnExit = txtISLEMMERKEZIExit
      OnKeyUp = txtISLEMMERKEZIKeyUp
    end
    object txtKOD1: TEdit
      Left = 102
      Top = 28
      Width = 71
      Height = 21
      TabOrder = 1
      OnEnter = txtKASAKODEnter
      OnExit = txtKOD1Exit
      OnKeyUp = txtKOD1KeyUp
    end
    object txtKOD2: TEdit
      Left = 196
      Top = 28
      Width = 71
      Height = 21
      TabOrder = 2
      OnEnter = txtKASAKODEnter
      OnExit = txtKOD2Exit
      OnKeyUp = txtKOD2KeyUp
    end
    object txtKOD3: TEdit
      Left = 289
      Top = 28
      Width = 71
      Height = 21
      TabOrder = 3
      OnEnter = txtKASAKODEnter
      OnExit = txtKOD3Exit
      OnKeyUp = txtKOD3KeyUp
    end
    object txtKOD4: TEdit
      Left = 382
      Top = 28
      Width = 71
      Height = 21
      TabOrder = 4
      OnEnter = txtKASAKODEnter
      OnExit = txtKOD4Exit
      OnKeyUp = txtKOD4KeyUp
    end
    object Button1: TButton
      Left = 81
      Top = 28
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      TabStop = False
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 175
      Top = 28
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      TabStop = False
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 268
      Top = 28
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      TabStop = False
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 361
      Top = 28
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      TabStop = False
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 453
      Top = 28
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      TabStop = False
      OnClick = Button5Click
    end
  end
  object trnCekSenHar: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    Left = 343
    Top = 137
  end
end
