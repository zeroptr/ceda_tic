object frmSeferSDLG: TfrmSeferSDLG
  Left = 153
  Top = 88
  ActiveControl = IB_Grid1
  BorderStyle = bsSingle
  Caption = 'Sefer Fi'#351'i Arama'
  ClientHeight = 533
  ClientWidth = 748
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
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 503
    Width = 748
    Height = 30
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      748
      30)
    object cmdCancel: TBitBtn
      Left = 583
      Top = 3
      Width = 85
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #304'&ptal'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = cmdCancelClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object btnTamam: TBitBtn
      Left = 673
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Tamam'
      TabOrder = 1
      OnClick = btnTamamClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
    end
    object Btn_Rapor: TButton
      Left = 4
      Top = 3
      Width = 107
      Height = 25
      Caption = '&Rapor Olu'#351'tur'
      TabOrder = 2
      OnClick = Btn_RaporClick
    end
    object cb_Tek_Satir: TCheckBox
      Left = 168
      Top = 8
      Width = 193
      Height = 17
      Caption = 'Se'#231'ilenleri Tek Sat'#305'r Olarak Aktar'
      TabOrder = 3
    end
    object cb_bf_Hesapla: TCheckBox
      Left = 368
      Top = 7
      Width = 193
      Height = 17
      Caption = 'Bf=Tutar Toplam'#305' / MiktarToplam'#305
      TabOrder = 4
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 31
    Width = 748
    Height = 346
    Align = alTop
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 10
      Width = 76
      Height = 13
      Caption = 'Ba'#351'.Tarih Aral'#305#287#305
    end
    object Label5: TLabel
      Left = 207
      Top = 10
      Width = 21
      Height = 13
      Caption = '> - <'
    end
    object LblPlaka: TLabel
      Left = 602
      Top = 55
      Width = 52
      Height = 13
      Caption = 'Ara'#231' Plaka'
    end
    object Label17: TLabel
      Left = 602
      Top = 79
      Width = 52
      Height = 13
      Caption = 'M'#252#351'teri Ad'#305
    end
    object Label18: TLabel
      Left = 602
      Top = 127
      Width = 59
      Height = 13
      Caption = 'Personel Ad'#305
    end
    object Label19: TLabel
      Left = 602
      Top = 103
      Width = 74
      Height = 13
      Caption = 'Ta'#351#305'y'#305'c'#305' Cari Ad'#305
    end
    object Label28: TLabel
      Left = 8
      Top = 34
      Width = 70
      Height = 13
      Caption = 'Bit.Tarih Aral'#305#287#305
    end
    object Label29: TLabel
      Left = 207
      Top = 34
      Width = 21
      Height = 13
      Caption = '> - <'
    end
    object Label30: TLabel
      Left = 392
      Top = 9
      Width = 55
      Height = 13
      Caption = 'Sefer Say'#305's'#305
    end
    object Label31: TLabel
      Left = 8
      Top = 110
      Width = 39
      Height = 13
      Caption = 'Ba'#351' Yeri'
    end
    object Label32: TLabel
      Left = 8
      Top = 133
      Width = 33
      Height = 13
      Caption = 'Bit Yeri'
    end
    object Label33: TLabel
      Left = 8
      Top = 86
      Width = 64
      Height = 13
      Caption = 'Ta'#351#305'nan E'#351'ya'
    end
    object Label1: TLabel
      Left = 378
      Top = 55
      Width = 50
      Height = 13
      Caption = 'Ara'#231' Kodu'
    end
    object Label34: TLabel
      Left = 378
      Top = 79
      Width = 34
      Height = 13
      Caption = 'M'#252#351'teri'
    end
    object Label35: TLabel
      Left = 378
      Top = 127
      Width = 41
      Height = 13
      Caption = 'Personel'
    end
    object Label36: TLabel
      Left = 378
      Top = 103
      Width = 56
      Height = 13
      Caption = 'Ta'#351#305'y'#305'c'#305' Cari'
    end
    object Label8: TLabel
      Left = 377
      Top = 33
      Width = 64
      Height = 13
      Caption = #304#351'lem Merkezi'
    end
    object Label9: TLabel
      Left = 547
      Top = 33
      Width = 25
      Height = 13
      Caption = 'Kod1'
    end
    object Label37: TLabel
      Left = 8
      Top = 62
      Width = 42
      Height = 13
      Caption = 'Sefer No'
    end
    object Label38: TLabel
      Left = 498
      Top = 149
      Width = 39
      Height = 13
      Caption = 'Kont No'
    end
    object Label39: TLabel
      Left = 9
      Top = 157
      Width = 70
      Height = 13
      Caption = 'Y'#252'kleyici Firma'
    end
    object dtpTanzimTar1: TDateTimePicker
      Left = 84
      Top = 7
      Width = 119
      Height = 21
      Date = 37554.393445972200000000
      Time = 37554.393445972200000000
      ShowCheckbox = True
      Checked = False
      TabOrder = 0
      OnEnter = dtpTanzimTar1Enter
      OnExit = dtpTanzimTar1Exit
    end
    object dtpTanzimTar2: TDateTimePicker
      Left = 231
      Top = 7
      Width = 128
      Height = 21
      Date = 0.393445972200425000
      Time = 0.393445972200425000
      ShowCheckbox = True
      Checked = False
      TabOrder = 1
      OnEnter = dtpTanzimTar1Enter
      OnExit = dtpTanzimTar1Exit
    end
    object btn_Ara: TButton
      Left = 667
      Top = 7
      Width = 78
      Height = 42
      Caption = '&Ara'
      TabOrder = 30
      OnClick = btn_AraClick
    end
    object GroupBox2: TGroupBox
      Left = 2
      Top = 168
      Width = 367
      Height = 34
      TabOrder = 22
      object Label3: TLabel
        Left = 6
        Top = 15
        Width = 49
        Height = 13
        Caption = 'Birim Fiyat'#305
      end
      object Label4: TLabel
        Left = 189
        Top = 13
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object TutarBas: TIB_Currency
        Left = 68
        Top = 9
        Width = 119
        Height = 21
        TabOrder = 0
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object TutarSon: TIB_Currency
        Left = 214
        Top = 9
        Width = 125
        Height = 21
        TabOrder = 1
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object chkBirim_Fiy: TCheckBox
        Left = 347
        Top = 12
        Width = 17
        Height = 17
        TabOrder = 2
        OnEnter = chkRAPKODEnter
        OnExit = chkRAPKODExit
      end
    end
    object cmbSube: TComboBox
      Left = 545
      Top = 4
      Width = 96
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 13
      OnEnter = cboISLEMEnter
      OnExit = cboISLEMExit
    end
    object GroupBox1: TGroupBox
      Left = 378
      Top = 168
      Width = 367
      Height = 34
      TabOrder = 23
      object Label6: TLabel
        Left = 6
        Top = 15
        Width = 25
        Height = 13
        Caption = 'Tutar'
      end
      object Label7: TLabel
        Left = 189
        Top = 13
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object TutarBas1: TIB_Currency
        Left = 68
        Top = 9
        Width = 119
        Height = 21
        TabOrder = 0
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object TutarSon1: TIB_Currency
        Left = 214
        Top = 9
        Width = 125
        Height = 21
        TabOrder = 1
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object ChkTutar: TCheckBox
        Left = 347
        Top = 12
        Width = 17
        Height = 17
        TabOrder = 2
        OnEnter = chkRAPKODEnter
        OnExit = chkRAPKODExit
      end
    end
    object GroupBox3: TGroupBox
      Left = 378
      Top = 202
      Width = 367
      Height = 34
      TabOrder = 24
      object Label13: TLabel
        Left = 6
        Top = 15
        Width = 47
        Height = 13
        Caption = 'Tutar Vpb'
      end
      object Label14: TLabel
        Left = 189
        Top = 13
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object TutarBas2: TIB_Currency
        Left = 68
        Top = 9
        Width = 119
        Height = 21
        TabOrder = 0
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object TutarSon2: TIB_Currency
        Left = 214
        Top = 9
        Width = 125
        Height = 21
        TabOrder = 1
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object ChkTutarVpb: TCheckBox
        Left = 347
        Top = 12
        Width = 17
        Height = 17
        TabOrder = 2
        OnEnter = chkRAPKODEnter
        OnExit = chkRAPKODExit
      end
    end
    object txtArac: TEdit
      Left = 449
      Top = 52
      Width = 127
      Height = 21
      TabOrder = 14
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtAracExit
      OnKeyDown = txtAracKeyDown
      OnKeyPress = txtAracKeyPress
    end
    object Button6: TButton
      Left = 578
      Top = 52
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 15
      OnClick = Button6Click
    end
    object txtAlanCari: TEdit
      Left = 449
      Top = 76
      Width = 127
      Height = 21
      TabOrder = 16
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtAlanCariExit
      OnKeyDown = txtAlanCariKeyDown
      OnKeyPress = txtAracKeyPress
    end
    object Button7: TButton
      Left = 578
      Top = 76
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 17
      OnClick = Button7Click
    end
    object txtAlanPers: TEdit
      Left = 449
      Top = 124
      Width = 127
      Height = 21
      TabOrder = 20
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtAlanPersExit
      OnKeyDown = txtAlanPersKeyDown
      OnKeyPress = txtAracKeyPress
    end
    object Button8: TButton
      Left = 578
      Top = 124
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 21
      OnClick = Button8Click
    end
    object TxtMazotcu: TEdit
      Left = 449
      Top = 100
      Width = 127
      Height = 21
      TabOrder = 18
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = TxtMazotcuExit
      OnKeyDown = TxtMazotcuKeyDown
      OnKeyPress = txtAracKeyPress
    end
    object Button9: TButton
      Left = 578
      Top = 100
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 19
      OnClick = Button9Click
    end
    object GroupBox4: TGroupBox
      Left = 2
      Top = 236
      Width = 367
      Height = 34
      TabOrder = 25
      object Label15: TLabel
        Left = 6
        Top = 15
        Width = 49
        Height = 13
        Caption = 'Birim Fiyat'#305
      end
      object Label16: TLabel
        Left = 189
        Top = 13
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object TutarBas21: TIB_Currency
        Left = 68
        Top = 9
        Width = 119
        Height = 21
        TabOrder = 0
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object TutarSon21: TIB_Currency
        Left = 214
        Top = 9
        Width = 125
        Height = 21
        TabOrder = 1
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object chkBirim_Fiy1: TCheckBox
        Left = 347
        Top = 12
        Width = 17
        Height = 17
        TabOrder = 2
        OnEnter = chkRAPKODEnter
        OnExit = chkRAPKODExit
      end
    end
    object GroupBox5: TGroupBox
      Left = 378
      Top = 236
      Width = 367
      Height = 34
      TabOrder = 26
      object Label20: TLabel
        Left = 6
        Top = 15
        Width = 25
        Height = 13
        Caption = 'Tutar'
      end
      object Label21: TLabel
        Left = 189
        Top = 13
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object TutarBas22: TIB_Currency
        Left = 68
        Top = 9
        Width = 119
        Height = 21
        TabOrder = 0
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object TutarSon22: TIB_Currency
        Left = 214
        Top = 9
        Width = 125
        Height = 21
        TabOrder = 1
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object ChkTutar1: TCheckBox
        Left = 347
        Top = 12
        Width = 17
        Height = 17
        TabOrder = 2
        OnEnter = chkRAPKODEnter
        OnExit = chkRAPKODExit
      end
    end
    object GroupBox6: TGroupBox
      Left = 378
      Top = 270
      Width = 367
      Height = 34
      TabOrder = 27
      object Label22: TLabel
        Left = 6
        Top = 15
        Width = 47
        Height = 13
        Caption = 'Tutar Vpb'
      end
      object Label23: TLabel
        Left = 189
        Top = 13
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object TutarBas23: TIB_Currency
        Left = 68
        Top = 9
        Width = 119
        Height = 21
        TabOrder = 0
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object TutarSon23: TIB_Currency
        Left = 214
        Top = 9
        Width = 125
        Height = 21
        TabOrder = 1
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object ChkTutarVpb1: TCheckBox
        Left = 347
        Top = 12
        Width = 17
        Height = 17
        TabOrder = 2
        OnEnter = chkRAPKODEnter
        OnExit = chkRAPKODExit
      end
    end
    object GroupBox7: TGroupBox
      Left = 2
      Top = 304
      Width = 367
      Height = 34
      TabOrder = 28
      object Label24: TLabel
        Left = 6
        Top = 15
        Width = 25
        Height = 13
        Caption = 'Tutar'
      end
      object Label25: TLabel
        Left = 189
        Top = 13
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object TutarBas31: TIB_Currency
        Left = 68
        Top = 9
        Width = 119
        Height = 21
        TabOrder = 0
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object TutarSon31: TIB_Currency
        Left = 214
        Top = 9
        Width = 125
        Height = 21
        TabOrder = 1
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object ChkTutar2: TCheckBox
        Left = 347
        Top = 12
        Width = 17
        Height = 17
        TabOrder = 2
        OnEnter = chkRAPKODEnter
        OnExit = chkRAPKODExit
      end
    end
    object GroupBox8: TGroupBox
      Left = 378
      Top = 304
      Width = 367
      Height = 34
      TabOrder = 29
      object Label26: TLabel
        Left = 6
        Top = 15
        Width = 47
        Height = 13
        Caption = 'Tutar Vpb'
      end
      object Label27: TLabel
        Left = 189
        Top = 13
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object TutarBas32: TIB_Currency
        Left = 68
        Top = 9
        Width = 119
        Height = 21
        TabOrder = 0
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object TutarSon32: TIB_Currency
        Left = 214
        Top = 9
        Width = 125
        Height = 21
        TabOrder = 1
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object ChkTutarVpb2: TCheckBox
        Left = 347
        Top = 12
        Width = 17
        Height = 17
        TabOrder = 2
        OnEnter = chkRAPKODEnter
        OnExit = chkRAPKODExit
      end
    end
    object DateTimePicker1: TDateTimePicker
      Left = 84
      Top = 31
      Width = 119
      Height = 21
      Date = 37554.393445972200000000
      Time = 37554.393445972200000000
      ShowCheckbox = True
      Checked = False
      TabOrder = 2
      OnEnter = dtpTanzimTar1Enter
      OnExit = dtpTanzimTar1Exit
    end
    object DateTimePicker2: TDateTimePicker
      Left = 231
      Top = 31
      Width = 128
      Height = 21
      Date = 0.393445972200425000
      Time = 0.393445972200425000
      ShowCheckbox = True
      Checked = False
      TabOrder = 3
      OnEnter = dtpTanzimTar1Enter
      OnExit = dtpTanzimTar1Exit
    end
    object txtSeferSay: TEdit
      Left = 449
      Top = 4
      Width = 88
      Height = 21
      TabOrder = 12
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtFisNoExit
    end
    object ComboBox1: TComboBox
      Left = 80
      Top = 102
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 5
      OnEnter = cboISLEMEnter
      OnExit = cboISLEMExit
    end
    object ComboBox2: TComboBox
      Left = 80
      Top = 126
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 6
      OnEnter = cboISLEMEnter
      OnExit = cboISLEMExit
    end
    object CheckBox1: TCheckBox
      Left = 232
      Top = 67
      Width = 105
      Height = 17
      Caption = 'Al'#305#351' Faturas'#305' Al'#305'nd'#305
      State = cbGrayed
      TabOrder = 7
    end
    object CheckBox2: TCheckBox
      Left = 232
      Top = 83
      Width = 121
      Height = 17
      Caption = 'Sat'#305#351' Faturas'#305' Kesildi'
      State = cbGrayed
      TabOrder = 8
    end
    object CheckBox3: TCheckBox
      Left = 232
      Top = 129
      Width = 105
      Height = 17
      Caption = 'Bekleme Faturas'#305
      State = cbGrayed
      TabOrder = 10
    end
    object ComboBox3: TComboBox
      Left = 80
      Top = 78
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      OnEnter = cboISLEMEnter
      OnExit = cboISLEMExit
    end
    object CheckBox4: TCheckBox
      Left = 375
      Top = 146
      Width = 121
      Height = 17
      Caption = 'Sefer Tamamlad'#305
      State = cbGrayed
      TabOrder = 11
    end
    object CheckBox5: TCheckBox
      Left = 232
      Top = 99
      Width = 137
      Height = 17
      Caption = 'Bekleme Faturas'#305' Kesildi'
      State = cbGrayed
      TabOrder = 9
    end
    object txtISLEMMERKEZI: TEdit
      Left = 449
      Top = 29
      Width = 76
      Height = 21
      TabOrder = 31
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtISLEMMERKEZIExit
      OnKeyPress = txtAracKeyPress
    end
    object Button1: TButton
      Left = 528
      Top = 29
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 32
      OnClick = Button1Click
    end
    object txtKOD1: TEdit
      Left = 573
      Top = 29
      Width = 48
      Height = 21
      TabOrder = 33
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD1Exit
      OnKeyPress = txtAracKeyPress
    end
    object Button2: TButton
      Left = 623
      Top = 29
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 34
      OnClick = Button2Click
    end
    object txtSefer_No: TEdit
      Left = 80
      Top = 57
      Width = 88
      Height = 21
      TabOrder = 35
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtFisNoExit
    end
    object CheckBox6: TCheckBox
      Left = 232
      Top = 51
      Width = 145
      Height = 17
      Caption = 'Kiral'#305'k Masraf Se'#231'ilmeyen'
      State = cbGrayed
      TabOrder = 36
    end
    object CheckBox7: TCheckBox
      Left = 232
      Top = 114
      Width = 137
      Height = 17
      Caption = 'Sat'#305'c'#305' Bek.Fat. Kesildi'
      State = cbGrayed
      TabOrder = 37
    end
    object CheckBox8: TCheckBox
      Left = 232
      Top = 146
      Width = 138
      Height = 17
      Caption = 'Sat'#305'c'#305' Bekleme Faturas'#305
      State = cbGrayed
      TabOrder = 38
    end
    object Edit1: TEdit
      Left = 570
      Top = 146
      Width = 88
      Height = 21
      TabOrder = 39
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtFisNoExit
    end
    object ComboBox4: TComboBox
      Left = 81
      Top = 150
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 40
      OnEnter = cboISLEMEnter
      OnExit = cboISLEMExit
    end
  end
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 377
    Width = 748
    Height = 126
    CustomGlyphsSupplied = []
    DataSource = dts_Liste
    Align = alClient
    OnClick = IB_Grid1Click
    OnDblClick = IB_Grid1DblClick
    BorderStyle = bsNone
    ReadOnly = True
    TabOrder = 2
    OnKeyDown = IB_Grid1KeyDown
    OnKeyPress = IB_Grid1KeyPress
    RowSelect = True
    Ctl3DShallow = True
    TabMovesOut = True
    ExplicitTop = 378
  end
  object pnlRAPKOD: TPanel
    Left = 0
    Top = 0
    Width = 748
    Height = 31
    Align = alTop
    Enabled = False
    TabOrder = 0
    Visible = False
    object Label10: TLabel
      Left = 308
      Top = 9
      Width = 29
      Height = 13
      Caption = 'KOD2'
    end
    object Label11: TLabel
      Left = 439
      Top = 9
      Width = 29
      Height = 13
      Caption = 'KOD3'
    end
    object Label12: TLabel
      Left = 570
      Top = 9
      Width = 29
      Height = 13
      Caption = 'KOD4'
    end
    object txtKOD2: TEdit
      Left = 339
      Top = 5
      Width = 79
      Height = 21
      TabOrder = 0
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD2Exit
      OnKeyPress = txtAracKeyPress
    end
    object txtKOD3: TEdit
      Left = 469
      Top = 5
      Width = 79
      Height = 21
      TabOrder = 2
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD3Exit
      OnKeyPress = txtAracKeyPress
    end
    object txtKOD4: TEdit
      Left = 600
      Top = 5
      Width = 79
      Height = 21
      TabOrder = 4
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD4Exit
      OnKeyPress = txtAracKeyPress
    end
    object Button3: TButton
      Left = 419
      Top = 5
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 549
      Top = 5
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
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 679
      Top = 5
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
      OnClick = Button5Click
    end
    object chkRAPKOD: TCheckBox
      Left = 729
      Top = 7
      Width = 15
      Height = 17
      TabOrder = 6
      OnEnter = chkRAPKODEnter
      OnExit = chkRAPKODExit
    end
  end
  object dts_Liste: TIB_DataSource
    Dataset = qrySefer
    Left = 211
    Top = 304
  end
  object qrySefer: TIB_Query
    ColumnAttributes.Strings = (
      'BEKLEME_FAT_VAR=BOOLEAN=1,0'
      'SEFER_ALIS_FAT_ALINDI=BOOLEAN=1,0'
      'SEFER_SATIS_FAT_KESILDI=BOOLEAN=1,0'
      'SECIM=BOOLEAN=1,0'
      'BEKLEME_FATURASI_KESILDI=BOOLEAN=1,0'
      'SEFER_TAMAMLANDI=BOOLEAN=1,0'
      'SBEKLEME_FAT_VAR=BOOLEAN=1,0'
      'SBEKLEME_FATURASI_KESILDI=BOOLEAN=1,0')
    DatabaseName = 'C:\DB2011.FDB'
    FieldsDisplayFormat.Strings = (
      'FATURA_MIK_SEF=Fa. Sef.Say.Mik')
    FieldsDisplayLabel.Strings = (
      'FIS_NO=Fi'#351' No'
      'KASA_KOD=Kasa Kodu'
      'TARIH=Tarih'
      'DOV_BAZ_TAR=D'#246'viz Baz Tar'
      'ACIKLAMA=Hareket A'#231#305'klamas'#305
      'KASA_AD=Kasa Ad'#305
      'CH_ACIKLAMA=C/H A'#231#305'klama'
      'YEV_ACIKLAMA=Yevmiye Defteri A'#231#305'klama'
      'KASAHAR_ID=FIS NO'
      'ARAC_KOD=Ara'#231' Kodu'
      'SEFER_SAY=Sefer Say'#305's'#305
      'ARAC_PLAKA=Ara'#231' Plaka'
      'ALICI_KOD=Al'#305'c'#305' Kodu'
      'ALICI_ADI=Al'#305'c'#305' Ad'#305
      'SATICI_KOD=Sat'#305'c'#305' Kodu'
      'SATICI_ADI=Sat'#305'c'#305' Ad'#305
      'PERSONEL_KOD=Personel Kodu'
      'PERSONEL_ADI=Personel Ad'#305
      'OLCU_TIP='#214'l'#231#252' Tip'
      'OLCU_BIRIM='#214'l'#231#252' Birim'
      'TASINAN_ESYA=Ta'#351#305'nan E'#351'ya'
      'BAS_TAR=Ba'#351'lama Tarihi'
      'BIT_TAR=Biti'#351' Tarihi'
      'CIK_YER='#199#305'k'#305#351' Yeri'
      'BIT_YER=Var'#305#351' Yeri'
      'ALICI_BORC_BIRIM_FIY=Birim Fiyat'#305
      'ALICI_B_DOVKOD=D'#246'viz Kodu'
      'ALICI_BORC=Bor'#231
      'ALICI_BORC_VPB=Bor'#231' Vpb'
      'SATICI_ALACAK_BIRIM_FIY=Birim Fiyat'#305
      'SATICI_A_DOVKOD=D'#246'viz Kodu'
      'SATICI_ALACAK=Alacak'
      'SATICI_ALACAK_VPB=Alacak Vpb'
      'BEKLEME_FAT_VAR=Bekleme Faturas'#305
      'BEKLEME_FAT_TUTAR=Tutar'
      'BEKLEME_FAT_DOV_KOD=D'#246'viz Kodu'
      'BEKLEME_FAT_VPB=Bekleme Tutar Vpb'
      'SEFER_NOTLARI=Sefer Notlar'#305
      'SEFER_ALIS_FAT_ALINDI=Al'#305#351' Faturas'#305' Al'#305'nd'#305
      'SEFER_SATIS_FAT_KESILDI=Sat'#305#351' Faturas'#305' Kesildi'
      'SEFER_ID=Sefer No'
      'MASRAF_MERK=Masraf Merkezi'
      'KOD1=Kod1'
      'KOD2=Kod2'
      'KOD3=Kod3'
      'KOD4=Kod4'
      'ALICI_B_DOV_BAZ_TAR=Al'#305'c'#305' D'#246'v.Baz.Tar'
      'SATICI_A_DOV_BAZ_TAR=Sat'#305'c'#305' D'#246'v.Baz.Tar'
      'BEKLEME_FAT_DOV_BAZ_TAR=Fatura D'#246'v.Baz.Tar'
      'SEFER_TAMAMLANDI=Sefer Tamamland'#305
      'DORSE_KOD=Dorse Kodu'
      'ALIS_URUN_HAR_ID=Al'#305#351' Faturas'#305' Hareket No'
      'SATIS_URUN_HAR_ID=Sat'#305#351' Faturas'#305' Hareket No'
      'SECIM=Se'#231'im'
      'BEKLEME_FATURASI_KESILDI=Bekleme Faturas'#305' Kesildi'
      'BEK_FAT_URUN_HAR_ID=Bekleme Faturas'#305' Al'#305#351' Hareket No'
      'MIKTAR=Miktar'#305
      'SBEKLEME_FAT_VAR=Sat'#305'c'#305' Bek.Fat.'
      'SBEKLEME_FAT_TUTAR=Sat'#305'c'#305' Bekleme Faturas'#305' Tutar'
      'SBEKLEME_FAT_DOV_KOD=Sat'#305'c'#305' Bekleme Faturas'#305' D'#246'v Kod'
      'SBEKLEME_FAT_VPB=Sat'#305'c'#305' Bekleme Faturas'#305' Tutar Vpb'
      'SBEKLEME_FAT_DOV_BAZ_TAR=Sat'#305'c'#305' Bekleme Faturas'#305' D'#246'v Baz Tar'
      'SBEKLEME_FAT_DOVKUR=Sat'#305'c'#305' Bekleme Faturas'#305' D'#246'v Kur'
      'SBEKLEME_FATURASI_KESILDI=Sat'#305'c'#305' Bekleme Faturas'#305' Kesildi'
      'SBEK_FAT_URUN_HAR_ID=Sat'#305'c'#305' Bekleme Faturas'#305'  Ur'#252'nhar id'
      'YUKLEYICI_FIRMA=Y'#252'kleyici Firma')
    FieldsDisplayWidth.Strings = (
      'BAS_TAR=74'
      'SEFER_ID=49'
      'SECIM=36'
      'ARAC_PLAKA=85'
      'CIK_YER=133'
      'BIT_YER=131'
      'TASINAN_ESYA=144'
      'MIKTAR=45'
      'SBEKLEME_FAT_VAR=76')
    FieldsIndex.Strings = (
      'SECIM'
      'SEFER_ID'
      'SEFER_SID'
      'SBEKLEME_FAT_VAR'
      'BAS_TAR'
      'ALICI_ADI'
      'CIK_YER'
      'BIT_YER'
      'TASINAN_ESYA'
      'MIKTAR'
      'ARAC_PLAKA'
      'SATICI_ADI'
      'YUKLEYICI_FIRMA'
      'SEFER_SAY'
      'DORSE_KOD'
      'ALICI_KOD'
      'ARAC_KOD'
      'SATICI_KOD'
      'PERSONEL_KOD'
      'PERSONEL_ADI'
      'OLCU_TIP'
      'OLCU_BIRIM'
      'BIT_TAR'
      'ALICI_BORC_BIRIM_FIY'
      'ALICI_B_DOVKOD'
      'ALICI_BORC'
      'ALICI_BORC_VPB'
      'SATICI_ALACAK_BIRIM_FIY'
      'SATICI_A_DOVKOD'
      'SATICI_ALACAK'
      'SATICI_ALACAK_VPB'
      'BEKLEME_FAT_TUTAR'
      'BEKLEME_FAT_DOV_KOD'
      'BEKLEME_FAT_VPB'
      'SEFER_NOTLARI'
      'MASRAF_MERK'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4'
      'ALICI_B_DOV_BAZ_TAR'
      'SATICI_A_DOV_BAZ_TAR'
      'BEKLEME_FAT_DOV_BAZ_TAR'
      'ALICI_B_DOVKUR'
      'SATICI_A_DOVKUR'
      'BEKLEME_FAT_DOVKUR'
      'SEFER_TAMAMLANDI'
      'SEFER_ALIS_FAT_ALINDI'
      'ALIS_URUN_HAR_ID'
      'SEFER_SATIS_FAT_KESILDI'
      'SATIS_URUN_HAR_ID'
      'BEKLEME_FAT_VAR'
      'BEKLEME_FATURASI_KESILDI'
      'BEK_FAT_URUN_HAR_ID'
      'FATURA_MIK_SEF'
      'SBEKLEME_FAT_TUTAR'
      'SBEKLEME_FAT_DOV_KOD'
      'SBEKLEME_FAT_VPB'
      'SBEKLEME_FAT_DOV_BAZ_TAR'
      'SBEKLEME_FAT_DOVKUR'
      'SBEKLEME_FATURASI_KESILDI'
      'SBEK_FAT_URUN_HAR_ID'
      'SEFER_TAKIP_ID')
    FieldsVisible.Strings = (
      'KASAHAR_ID=FALSE'
      'KASAHAR_SID=FALSE'
      'BELGE_TUR=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE'
      'SEFER_SID=FALSE'
      'ALICI_B_DOVKUR=FALSE'
      'SATICI_A_DOVKUR=FALSE'
      'BEKLEME_FAT_DOVKUR=FALSE'
      'MIKTAR=FALSE'
      'DORSE_KOD=FALSE'
      'ARAC_KOD=FALSE'
      'SATICI_KOD=FALSE'
      'PERSONEL_KOD=FALSE'
      'PERSONEL_ADI=FALSE'
      'OLCU_TIP=FALSE'
      'OLCU_BIRIM=FALSE'
      'BIT_TAR=FALSE'
      'ALICI_BORC_BIRIM_FIY=FALSE'
      'ALICI_B_DOVKOD=FALSE'
      'ALICI_BORC=FALSE'
      'ALICI_BORC_VPB=TRUE'
      'SATICI_ALACAK_BIRIM_FIY=FALSE'
      'SATICI_A_DOVKOD=FALSE'
      'SATICI_ALACAK=FALSE'
      'SATICI_ALACAK_VPB=TRUE'
      'BEKLEME_FAT_TUTAR=FALSE'
      'BEKLEME_FAT_DOV_KOD=FALSE'
      'BEKLEME_FAT_VPB=TRUE'
      'SEFER_NOTLARI=FALSE'
      'MASRAF_MERK=FALSE'
      'KOD1=FALSE'
      'KOD2=FALSE'
      'KOD3=FALSE'
      'KOD4=FALSE'
      'ALICI_B_DOV_BAZ_TAR=FALSE'
      'SATICI_A_DOV_BAZ_TAR=FALSE'
      'BEKLEME_FAT_DOV_BAZ_TAR=FALSE'
      'SEFER_TAMAMLANDI=FALSE'
      'SEFER_ALIS_FAT_ALINDI=FALSE'
      'ALIS_URUN_HAR_ID=FALSE'
      'SEFER_SATIS_FAT_KESILDI=FALSE'
      'SATIS_URUN_HAR_ID=FALSE'
      'BEKLEME_FAT_VAR=FALSE'
      'BEKLEME_FATURASI_KESILDI=FALSE'
      'BEK_FAT_URUN_HAR_ID=FALSE'
      'FATURA_MIK_SEF=FALSE'
      'ALICI_KOD=FALSE'
      'SEFER_TAKIP_ID=FALSE'
      'YUKLEYICI_FIRMA=TRUE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT SEFER_ID'
      '     , SEFER_SID'
      '     , SEFER_SAY'
      '     , ARAC_KOD'
      
        '     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER.ARAC_KOD' +
        ') AS ARAC_PLAKA'
      '     , ALICI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SEFER.ALICI_' +
        'KOD) AS ALICI_ADI'
      '     , SATICI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE SEFER.SATICI_KOD=CARI.CARI' +
        '_KOD) AS SATICI_ADI'
      '     , PERSONEL_KOD'
      
        '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_K' +
        'OD=SEFER.PERSONEL_KOD) AS PERSONEL_ADI'
      '     , OLCU_TIP'
      '     , OLCU_BIRIM'
      '     , TASINAN_ESYA'
      '     , BAS_TAR'
      '     , BIT_TAR'
      '     , CIK_YER'
      '     , BIT_YER'
      '     , ALICI_BORC_BIRIM_FIY'
      '     , ALICI_B_DOVKOD'
      '     , ALICI_BORC'
      '     , ALICI_BORC_VPB'
      '     , SATICI_ALACAK_BIRIM_FIY'
      '     , SATICI_A_DOVKOD'
      '     , SATICI_ALACAK'
      '     , SATICI_ALACAK_VPB'
      '     , BEKLEME_FAT_VAR'
      '     , BEKLEME_FAT_TUTAR'
      '     , BEKLEME_FAT_DOV_KOD'
      '     , BEKLEME_FAT_VPB'
      '     , SEFER_NOTLARI'
      '     , SEFER_ALIS_FAT_ALINDI'
      '     , SEFER_SATIS_FAT_KESILDI'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , ALICI_B_DOV_BAZ_TAR'
      '     , SATICI_A_DOV_BAZ_TAR'
      '     , BEKLEME_FAT_DOV_BAZ_TAR'
      '     , ALICI_B_DOVKUR'
      '     , SATICI_A_DOVKUR'
      '     , BEKLEME_FAT_DOVKUR'
      '     , SEFER_TAMAMLANDI'
      '     , DORSE_KOD'
      '     , ALIS_URUN_HAR_ID'
      '     , SATIS_URUN_HAR_ID'
      '     , SECIM'
      '     , BEKLEME_FATURASI_KESILDI'
      '     , BEK_FAT_URUN_HAR_ID'
      '     , MIKTAR'
      '     , FATURA_MIK_SEF'
      '   , SBEKLEME_FAT_VAR'
      '   , SBEKLEME_FAT_TUTAR'
      '   , SBEKLEME_FAT_DOV_KOD'
      '   , SBEKLEME_FAT_VPB'
      '   , SBEKLEME_FAT_DOV_BAZ_TAR'
      '   , SBEKLEME_FAT_DOVKUR'
      '   , SBEKLEME_FATURASI_KESILDI'
      '   , SBEK_FAT_URUN_HAR_ID'
      '   , SEFER_TAKIP_ID'
      '   , YUKLEYICI_FIRMA'
      'FROM SEFER'
      'WHERE SEFER_ID=:PRM_SEFER_ID AND SEFER_SID=:PRM_SEFER_SID')
    AutoFetchAll = True
    ColorScheme = False
    DefaultValues.Strings = (
      'BELGE_SID=1'
      'BELGE_ID=0'
      'TIP=G'
      'KASADEGER=0'
      'ISLEM_TIP=1'
      'MC=C'
      'DOVKUR=0'
      'TUTAR=0'
      'TUTAR_VPB=0'
      'MIKTAR=0')
    KeyLinks.Strings = (
      'SEFER.SEFER_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItems.Strings = (
      'Se'#231'im=SECIM;SECIM DESC'
      'Sefer No=SEFER_ID;SEFER_ID DESC'
      'Ba'#351'lama Tarihi=BAS_TAR;BAS_TAR DESC'
      #199#305'k'#305#351' Yeri=CIK_YER;CIK_YER DESC'
      'Var'#305#351' Yeri=BIT_YER;BIT_YER DESC'
      'Ta'#351#305'nan E'#351'ya=TASINAN_ESYA;TASINAN_ESYA DESC'
      'Ara'#231' Plaka=ARAC_PLAKA;ARAC_PLAKA DESC'
      'Sefer Say'#305's'#305'=SEFER_SAY;SEFER_SAY DESC'
      'Al'#305'c'#305' Kodu=ALICI_KOD;ALICI_KOD DESC'
      'Ara'#231' Kodu=ARAC_KOD;ARAC_KOD DESC'
      'Sat'#305'c'#305' Kodu=SATICI_KOD;SATICI_KOD DESC'
      'Personel Kodu=PERSONEL_KOD;PERSONEL_KOD DESC'
      'Biti'#351' Tarihi=BIT_TAR;BIT_TAR DESC')
    OrderingLinks.Strings = (
      'SECIM=ITEM=1'
      'SEFER_ID=ITEM=2'
      'BAS_TAR=ITEM=3'
      'CIK_YER=ITEM=4'
      'BIT_YER=ITEM=5'
      'TASINAN_ESYA=ITEM=6'
      'ARAC_PLAKA=ITEM=7'
      'SEFER_SAY=ITEM=8'
      'ALICI_KOD=ITEM=9'
      'ARAC_KOD=ITEM=10'
      'SATICI_KOD=ITEM=11'
      'PERSONEL_KOD=ITEM=12'
      'BIT_TAR=ITEM=13')
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 272
    Top = 312
    ParamValues = (
      'PRM_SEFER_ID=0')
  end
end
