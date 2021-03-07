object frmMazotSDLG: TfrmMazotSDLG
  Left = 137
  Top = 155
  ActiveControl = IB_Grid1
  BorderStyle = bsSingle
  Caption = 'Mazot Fi'#351'i Arama'
  ClientHeight = 464
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
    Top = 434
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
      Anchors = [akLeft, akBottom]
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
      Anchors = [akLeft, akBottom]
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
      Left = 376
      Top = 8
      Width = 193
      Height = 17
      Caption = 'Se'#231'ilenleri Tek Sat'#305'r Olarak Aktar'
      TabOrder = 3
      Visible = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 44
    Width = 748
    Height = 203
    Align = alTop
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 10
      Width = 55
      Height = 13
      Caption = 'Tarih Aral'#305#287#305
    end
    object Label5: TLabel
      Left = 191
      Top = 10
      Width = 21
      Height = 13
      Caption = '> - <'
    end
    object Label1: TLabel
      Left = 360
      Top = 9
      Width = 30
      Height = 13
      Caption = 'Fi'#351' No'
    end
    object LblPlaka: TLabel
      Left = 250
      Top = 39
      Width = 52
      Height = 13
      Caption = 'Ara'#231' Plaka'
    end
    object Label17: TLabel
      Left = 250
      Top = 63
      Width = 74
      Height = 13
      Caption = 'Ta'#351#305'y'#305'c'#305' Cari Ad'#305
    end
    object Label18: TLabel
      Left = 250
      Top = 87
      Width = 59
      Height = 13
      Caption = 'Personel Ad'#305
    end
    object Label19: TLabel
      Left = 250
      Top = 111
      Width = 80
      Height = 13
      Caption = 'Mazotcu Cari Ad'#305
    end
    object Label20: TLabel
      Left = 10
      Top = 39
      Width = 50
      Height = 13
      Caption = 'Ara'#231' Kodu'
    end
    object Label21: TLabel
      Left = 10
      Top = 63
      Width = 56
      Height = 13
      Caption = 'Ta'#351#305'y'#305'c'#305' Cari'
    end
    object Label22: TLabel
      Left = 10
      Top = 87
      Width = 41
      Height = 13
      Caption = 'Personel'
    end
    object Label23: TLabel
      Left = 10
      Top = 111
      Width = 80
      Height = 13
      Caption = 'Mazotcu Cari Ad'#305
    end
    object dtpTanzimTar1: TDateTimePicker
      Left = 68
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
      Left = 215
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
    object txtFisNo: TEdit
      Left = 393
      Top = 4
      Width = 88
      Height = 21
      TabOrder = 2
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtFisNoExit
    end
    object btn_Ara: TButton
      Left = 667
      Top = 3
      Width = 78
      Height = 23
      Caption = '&Ara'
      TabOrder = 17
      OnClick = btn_AraClick
    end
    object GroupBox2: TGroupBox
      Left = 2
      Top = 163
      Width = 367
      Height = 34
      TabOrder = 15
      Visible = False
      object Label3: TLabel
        Left = 6
        Top = 15
        Width = 59
        Height = 13
        Caption = 'Tutar Aral'#305#287#305' '
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
      object chkTutar: TCheckBox
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
      Left = 393
      Top = 28
      Width = 109
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnEnter = cboISLEMEnter
      OnExit = cboISLEMExit
    end
    object GroupBox1: TGroupBox
      Left = 2
      Top = 128
      Width = 367
      Height = 34
      TabOrder = 13
      object Label6: TLabel
        Left = 6
        Top = 15
        Width = 20
        Height = 13
        Caption = 'Litre'
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
      object ChkLitre: TCheckBox
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
      Top = 128
      Width = 367
      Height = 34
      TabOrder = 14
      object Label13: TLabel
        Left = 6
        Top = 15
        Width = 47
        Height = 13
        Caption = 'Litre Fiyat'#305
      end
      object Label14: TLabel
        Left = 189
        Top = 13
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object TutarBas3: TIB_Currency
        Left = 68
        Top = 9
        Width = 119
        Height = 21
        TabOrder = 0
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object TutarSon3: TIB_Currency
        Left = 214
        Top = 9
        Width = 125
        Height = 21
        TabOrder = 1
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object ChkLitreFiyat: TCheckBox
        Left = 347
        Top = 12
        Width = 17
        Height = 17
        TabOrder = 2
        OnEnter = chkRAPKODEnter
        OnExit = chkRAPKODExit
      end
    end
    object GroupBox4: TGroupBox
      Left = 378
      Top = 163
      Width = 367
      Height = 34
      TabOrder = 16
      object Label15: TLabel
        Left = 6
        Top = 15
        Width = 47
        Height = 13
        Caption = 'Tutar Vpb'
      end
      object Label16: TLabel
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
      Left = 97
      Top = 36
      Width = 127
      Height = 21
      TabOrder = 4
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtAracExit
      OnKeyDown = txtAracKeyDown
      OnKeyPress = txtAracKeyPress
    end
    object Button6: TButton
      Left = 226
      Top = 36
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
      OnClick = Button6Click
    end
    object txtAlanCari: TEdit
      Left = 97
      Top = 60
      Width = 127
      Height = 21
      TabOrder = 6
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtAlanCariExit
      OnKeyDown = txtAlanCariKeyDown
      OnKeyPress = txtAracKeyPress
    end
    object Button7: TButton
      Left = 226
      Top = 60
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
      OnClick = Button7Click
    end
    object txtAlanPers: TEdit
      Left = 97
      Top = 84
      Width = 127
      Height = 21
      TabOrder = 8
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtAlanPersExit
      OnKeyDown = txtAlanPersKeyDown
      OnKeyPress = txtAracKeyPress
    end
    object Button8: TButton
      Left = 226
      Top = 84
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
      OnClick = Button8Click
    end
    object TxtMazotcu: TEdit
      Left = 97
      Top = 108
      Width = 127
      Height = 21
      TabOrder = 10
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = TxtMazotcuExit
      OnKeyDown = TxtMazotcuKeyDown
      OnKeyPress = txtAracKeyPress
    end
    object Button9: TButton
      Left = 226
      Top = 108
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      OnClick = Button9Click
    end
    object CheckBox1: TCheckBox
      Left = 392
      Top = 56
      Width = 105
      Height = 17
      Caption = 'Al'#305#351' Faturas'#305' Al'#305'nd'#305
      State = cbGrayed
      TabOrder = 12
    end
  end
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 247
    Width = 748
    Height = 187
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
  end
  object pnlRAPKOD: TPanel
    Left = 0
    Top = 0
    Width = 748
    Height = 44
    Align = alTop
    Enabled = False
    TabOrder = 0
    Visible = False
    object Label8: TLabel
      Left = 17
      Top = 3
      Width = 64
      Height = 13
      Caption = #304#351'lem Merkezi'
    end
    object Label9: TLabel
      Left = 123
      Top = 3
      Width = 29
      Height = 13
      Caption = 'KOD1'
    end
    object Label10: TLabel
      Left = 228
      Top = 3
      Width = 29
      Height = 13
      Caption = 'KOD2'
    end
    object Label11: TLabel
      Left = 335
      Top = 3
      Width = 29
      Height = 13
      Caption = 'KOD3'
    end
    object Label12: TLabel
      Left = 442
      Top = 3
      Width = 29
      Height = 13
      Caption = 'KOD4'
    end
    object txtISLEMMERKEZI: TEdit
      Left = 16
      Top = 17
      Width = 79
      Height = 21
      TabOrder = 0
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtISLEMMERKEZIExit
      OnKeyPress = txtAracKeyPress
    end
    object txtKOD1: TEdit
      Left = 121
      Top = 17
      Width = 79
      Height = 21
      TabOrder = 2
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD1Exit
      OnKeyPress = txtAracKeyPress
    end
    object txtKOD2: TEdit
      Left = 227
      Top = 17
      Width = 79
      Height = 21
      TabOrder = 4
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD2Exit
      OnKeyPress = txtAracKeyPress
    end
    object txtKOD3: TEdit
      Left = 333
      Top = 17
      Width = 79
      Height = 21
      TabOrder = 6
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD3Exit
      OnKeyPress = txtAracKeyPress
    end
    object txtKOD4: TEdit
      Left = 440
      Top = 17
      Width = 79
      Height = 21
      TabOrder = 8
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD4Exit
      OnKeyPress = txtAracKeyPress
    end
    object Button1: TButton
      Left = 96
      Top = 17
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
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 201
      Top = 17
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
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 307
      Top = 17
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
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 413
      Top = 17
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
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 519
      Top = 17
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
      OnClick = Button5Click
    end
    object chkRAPKOD: TCheckBox
      Left = 649
      Top = 19
      Width = 15
      Height = 17
      TabOrder = 10
      OnEnter = chkRAPKODEnter
      OnExit = chkRAPKODExit
    end
  end
  object dts_Liste: TIB_DataSource
    Dataset = qryMazot
    Left = 211
    Top = 304
  end
  object qryMazot: TIB_Query
    ColumnAttributes.Strings = (
      'SECIM=BOOLEAN=1,0'
      'ALIS_FATURASI_ALINDI=BOOLEAN=1,0')
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    FieldsDisplayLabel.Strings = (
      'FIS_NO=Fi'#351' No'
      'KASA_KOD=Kasa Kodu'
      'TARIH=Tarih'
      'DOV_BAZ_TAR=D'#246'viz Baz Tar'
      'ACIKLAMA=A'#231#305'klama'
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
      'SATICI_ADI=Sat'#305'c'#305' Kodu'
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
      'BEKLEME_FAT_VPB=Tutar Vpb'
      'SEFER_NOTLARI=Sefer Notlar'#305
      'SEFER_ALIS_FAT_ALINDI=Al'#305#351' Faturas'#305' Al'#305'nd'#305
      'SEFER_SATIS_FAT_KESILDI=Sat'#305#351' Faturas'#305' Kesildi'
      'SEFER_ID=Sefer No'
      'MASRAF_MERK=Masraf Merkezi'
      'KOD1=Kod1'
      'KOD2=Kod2'
      'KOD3=Kod3'
      'KOD4=Kod4'
      'MAZOT_FIS_ID=S'#305'ra No'
      'SAAT=Saat'
      'VEREN_PERSONEL_KOD=Veren Personel'
      'ALAN_PERSONEL_KOD=Alan Personel'
      'ALAN_CARI_KOD=Alan Cari Kodu'
      'MAZOTCU_CARI_KOD=Mazot'#231'u Cari Kod'
      'KM=Km'
      'LITRE=Litre'
      'LITRE_FIYAT=Litre Fiyat'#305
      'DOVKOD=D'#246'viz Kodu'
      'DOVKUR=D'#246'viz Kuru'
      'TUTAR=Tutar'
      'TUTAR_VPB=Tutar Vpb'
      'VEREN_PERSONEL_ADI=Veren Personel Ad'#305
      'ALAN_PERSONEL_ADI=Alan Personel Ad'#305
      'MAZOTCU_CARI_ADI=Mazot'#231'u Cari Ad'#305
      'ALAN_CARI_ADI=Alan Cari Ad'#305
      'ALIS_URUN_HAR_ID=Al'#305#351' Faturas'#305' Hareket No'
      'SECIM=Se'#231'im'
      'ALIS_FATURASI_ALINDI=Al'#305#351' Faturas'#305' Al'#305'nd'#305)
    FieldsDisplayWidth.Strings = (
      'MAZOT_FIS_ID=48'
      'ARAC_PLAKA=97'
      'ALIS_FATURASI_ALINDI=91'
      'FIS_NO=56'
      'SEFER_ID=54')
    FieldsIndex.Strings = (
      'SECIM'
      'MAZOT_FIS_ID'
      'MAZOT_FIS_SID'
      'ARAC_PLAKA'
      'MAZOTCU_CARI_ADI'
      'ALAN_PERSONEL_ADI'
      'SEFER_ID'
      'ALIS_FATURASI_ALINDI'
      'FIS_NO'
      'TARIH'
      'SAAT'
      'ARAC_KOD'
      'VEREN_PERSONEL_KOD'
      'VEREN_PERSONEL_ADI'
      'ALAN_PERSONEL_KOD'
      'ALAN_CARI_KOD'
      'ALAN_CARI_ADI'
      'MAZOTCU_CARI_KOD'
      'KM'
      'LITRE'
      'LITRE_FIYAT'
      'DOVKOD'
      'DOV_BAZ_TAR'
      'DOVKUR'
      'TUTAR'
      'TUTAR_VPB'
      'ACIKLAMA'
      'MASRAF_MERK'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4'
      'ALIS_URUN_HAR_ID')
    FieldsVisible.Strings = (
      'KASAHAR_ID=FALSE'
      'KASAHAR_SID=FALSE'
      'BELGE_TUR=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE'
      'MAZOT_FIS_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT MAZOT_FIS_ID'
      '     , MAZOT_FIS_SID'
      '     , ARAC_KOD'
      
        '     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=MAZOT_FISI.ARA' +
        'C_KOD) AS ARAC_PLAKA'
      '     , FIS_NO'
      '     , TARIH'
      '     , SAAT'
      '     , VEREN_PERSONEL_KOD'
      
        '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_K' +
        'OD=MAZOT_FISI.VEREN_PERSONEL_KOD) AS VEREN_PERSONEL_ADI    '
      '     , ALAN_PERSONEL_KOD'
      
        '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_K' +
        'OD=MAZOT_FISI.ALAN_PERSONEL_KOD) AS ALAN_PERSONEL_ADI    '
      '     , ALAN_CARI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE MAZOT_FISI.ALAN_CARI_KOD=C' +
        'ARI.CARI_KOD) AS ALAN_CARI_ADI    '
      '     , MAZOTCU_CARI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE MAZOT_FISI.MAZOTCU_CARI_KO' +
        'D=CARI.CARI_KOD) AS MAZOTCU_CARI_ADI    '
      '     , KM'
      '     , LITRE'
      '     , LITRE_FIYAT'
      '     , DOVKOD'
      '     , DOV_BAZ_TAR'
      '     , DOVKUR'
      '     , TUTAR'
      '     , TUTAR_VPB'
      '     , ACIKLAMA'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , SEFER_ID'
      '     , ALIS_URUN_HAR_ID'
      '     , SECIM'
      '     , ALIS_FATURASI_ALINDI'
      'FROM MAZOT_FISI'
      
        'WHERE MAZOT_FIS_ID=:PRM_MAZOT_FIS_ID AND MAZOT_FIS_SID=:PRM_MAZO' +
        'T_FIS_SID')
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
      'MAZOT_FISI.MAZOT_FIS_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItems.Strings = (
      'Se'#231'im=SECIM;SECIM DESC'
      'S'#305'ra No=MAZOT_FIS_ID;MAZOT_FIS_ID DESC'
      'Ara'#231' Plaka=ARAC_PLAKA;ARAC_PLAKA DESC'
      'Sefer No=SEFER_ID;SEFER_ID DESC'
      
        'Al'#305#351' Faturas'#305' Al'#305'nd'#305'=ALIS_FATURASI_ALINDI;ALIS_FATURASI_ALINDI D' +
        'ESC'
      'Fi'#351' No=FIS_NO;FIS_NO DESC'
      'Tarih=TARIH;TARIH DESC'
      'Ara'#231' Kodu=ARAC_KOD;ARAC_KOD DESC'
      'Veren Personel=VEREN_PERSONEL_KOD;VEREN_PERSONEL_KOD DESC'
      'Alan Personel=ALAN_PERSONEL_KOD;ALAN_PERSONEL_KOD DESC'
      'Alan Cari Kodu=ALAN_CARI_KOD;ALAN_CARI_KOD DESC'
      'Mazot'#231'u Cari Kod=MAZOTCU_CARI_KOD;MAZOTCU_CARI_KOD DESC'
      'Litre=LITRE;LITRE DESC'
      'Litre Fiyat'#305'=LITRE_FIYAT;LITRE_FIYAT DESC'
      'Tutar=TUTAR;TUTAR DESC'
      'Tutar Vpb=TUTAR_VPB;TUTAR_VPB DESC'
      'A'#231#305'klama=ACIKLAMA;ACIKLAMA DESC')
    OrderingLinks.Strings = (
      'SECIM=ITEM=1'
      'MAZOT_FIS_ID=ITEM=2'
      'ARAC_PLAKA=ITEM=3'
      'SEFER_ID=ITEM=4'
      'ALIS_FATURASI_ALINDI=ITEM=5'
      'FIS_NO=ITEM=6'
      'TARIH=ITEM=7'
      'ARAC_KOD=ITEM=8'
      'VEREN_PERSONEL_KOD=ITEM=9'
      'ALAN_PERSONEL_KOD=ITEM=10'
      'ALAN_CARI_KOD=ITEM=11'
      'MAZOTCU_CARI_KOD=ITEM=12'
      'LITRE=ITEM=13'
      'LITRE_FIYAT=ITEM=14'
      'TUTAR=ITEM=15'
      'TUTAR_VPB=ITEM=16'
      'ACIKLAMA=ITEM=17')
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 152
    Top = 304
    ParamValues = (
      'PRM_MAZOT_FIS_ID=0')
  end
end
