object frmYuk_Fis_SDLG: TfrmYuk_Fis_SDLG
  Left = 46
  Top = 156
  Caption = 'Y'#252'kleme Fi'#351'i Listesi'
  ClientHeight = 453
  ClientWidth = 852
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 414
    Width = 852
    Height = 39
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      852
      39)
    object btnIPTAL: TBitBtn
      Left = 688
      Top = 8
      Width = 85
      Height = 25
      Anchors = [akLeft, akBottom]
      Cancel = True
      Caption = #304'&ptal'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnIPTALClick
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
    object btnTAMAM: TBitBtn
      Left = 772
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '&Tamam'
      TabOrder = 1
      OnClick = btnTAMAMClick
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
    object btnRapor: TButton
      Left = 6
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Rapor Olu'#351'tur'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 257
    Width = 852
    Height = 157
    CustomGlyphsSupplied = []
    DataSource = dts_Komisyon
    Align = alClient
    OnDblClick = btnTAMAMClick
    BorderStyle = bsNone
    TabOrder = 1
    RowSelect = True
    Ctl3DShallow = True
  end
  object pnlRAPKOD: TPanel
    Left = 0
    Top = 0
    Width = 852
    Height = 49
    Align = alTop
    TabOrder = 2
    object Label2: TLabel
      Left = 10
      Top = 7
      Width = 64
      Height = 13
      Caption = #304#351'lem Merkezi'
    end
    object Label3: TLabel
      Left = 152
      Top = 7
      Width = 29
      Height = 13
      Caption = 'KOD1'
    end
    object Label7: TLabel
      Left = 291
      Top = 7
      Width = 29
      Height = 13
      Caption = 'KOD2'
    end
    object Label8: TLabel
      Left = 432
      Top = 7
      Width = 29
      Height = 13
      Caption = 'KOD3'
    end
    object Label9: TLabel
      Left = 570
      Top = 7
      Width = 29
      Height = 13
      Caption = 'KOD4'
    end
    object txtISLEMMERKEZI: TEdit
      Left = 9
      Top = 20
      Width = 79
      Height = 21
      TabOrder = 0
    end
    object txtKOD1: TEdit
      Left = 150
      Top = 20
      Width = 79
      Height = 21
      TabOrder = 2
    end
    object txtKOD2: TEdit
      Left = 288
      Top = 19
      Width = 79
      Height = 21
      TabOrder = 4
    end
    object txtKOD3: TEdit
      Left = 430
      Top = 20
      Width = 79
      Height = 21
      TabOrder = 6
    end
    object txtKOD4: TEdit
      Left = 568
      Top = 20
      Width = 79
      Height = 21
      TabOrder = 8
    end
    object Button1: TButton
      Left = 90
      Top = 20
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
    end
    object Button2: TButton
      Left = 231
      Top = 20
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
    end
    object Button3: TButton
      Left = 371
      Top = 20
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
    end
    object Button4: TButton
      Left = 511
      Top = 20
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
    end
    object Button5: TButton
      Left = 650
      Top = 20
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
    end
    object chkRAPKOD: TCheckBox
      Left = 677
      Top = 22
      Width = 15
      Height = 17
      TabOrder = 10
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 49
    Width = 852
    Height = 208
    Align = alTop
    TabOrder = 3
    object Label20: TLabel
      Left = 362
      Top = 71
      Width = 50
      Height = 13
      Caption = 'Ara'#231' Kodu'
    end
    object LblPlaka: TLabel
      Left = 610
      Top = 71
      Width = 52
      Height = 13
      Caption = 'Ara'#231' Plaka'
    end
    object Label6: TLabel
      Left = 362
      Top = 95
      Width = 53
      Height = 13
      Caption = #350#246'f'#246'r Kodu'
    end
    object lblSofor_Adi: TLabel
      Left = 610
      Top = 95
      Width = 78
      Height = 13
      Caption = #350#246'f'#246'r Ad'#305' Soyad'#305
    end
    object Label10: TLabel
      Left = 360
      Top = 128
      Width = 93
      Height = 13
      Caption = 'G'#246'nderen Firma Ad'#305
    end
    object Label11: TLabel
      Left = 360
      Top = 152
      Width = 52
      Height = 13
      Caption = 'Ara'#231' Plaka'
    end
    object Label12: TLabel
      Left = 360
      Top = 176
      Width = 78
      Height = 13
      Caption = 'S'#246'f'#246'r Ad'#305' Soyad'#305
    end
    object Label14: TLabel
      Left = 618
      Top = 179
      Width = 62
      Height = 13
      Caption = 'Komisyon No'
    end
    object btn_Ara: TButton
      Left = 757
      Top = 14
      Width = 77
      Height = 39
      Caption = '&Ara'
      TabOrder = 2
      OnClick = btn_AraClick
    end
    object GroupBox2: TGroupBox
      Left = 10
      Top = 9
      Width = 247
      Height = 45
      Caption = #304#351'lem Tarihi'
      TabOrder = 1
      object Label4: TLabel
        Left = 112
        Top = 18
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object dtpIslemTar: TDateTimePicker
        Left = 7
        Top = 15
        Width = 101
        Height = 21
        Date = 37554.733220983800000000
        Time = 37554.733220983800000000
        ShowCheckbox = True
        Checked = False
        TabOrder = 0
      end
      object dtpIslemTar2: TDateTimePicker
        Left = 137
        Top = 14
        Width = 100
        Height = 21
        Date = 37554.733416122690000000
        Time = 37554.733416122690000000
        ShowCheckbox = True
        Checked = False
        TabOrder = 1
      end
    end
    object GroupBox3: TGroupBox
      Left = 6
      Top = 57
      Width = 339
      Height = 45
      Caption = #220'creti'
      TabOrder = 0
      object Label1: TLabel
        Left = 129
        Top = 17
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object Tutar1: TIB_Currency
        Left = 6
        Top = 14
        Width = 121
        Height = 21
        TabOrder = 0
        AlwaysShowButton = True
      end
      object Tutar2: TIB_Currency
        Left = 152
        Top = 14
        Width = 121
        Height = 21
        TabOrder = 1
        AlwaysShowButton = True
      end
      object chkUcret: TCheckBox
        Left = 304
        Top = 14
        Width = 19
        Height = 17
        TabOrder = 2
      end
    end
    object GroupBox1: TGroupBox
      Left = 6
      Top = 105
      Width = 339
      Height = 45
      Caption = 'Komisyon '#220'creti'
      TabOrder = 3
      object Label5: TLabel
        Left = 129
        Top = 17
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object IB_Currency1: TIB_Currency
        Left = 6
        Top = 14
        Width = 121
        Height = 21
        TabOrder = 0
        AlwaysShowButton = True
      end
      object IB_Currency2: TIB_Currency
        Left = 152
        Top = 14
        Width = 121
        Height = 21
        TabOrder = 1
        AlwaysShowButton = True
      end
      object chkKomisyon: TCheckBox
        Left = 304
        Top = 14
        Width = 19
        Height = 17
        TabOrder = 2
      end
    end
    object GroupBox4: TGroupBox
      Left = 267
      Top = 9
      Width = 460
      Height = 45
      TabOrder = 4
      object lbl_CARIKOD: TLabel
        Left = 96
        Top = 15
        Width = 81
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbl_CARI: TLabel
        Left = 179
        Top = 15
        Width = 253
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object btnCARI: TButton
        Left = 4
        Top = 10
        Width = 87
        Height = 29
        Caption = '&Cari Listesi'
        TabOrder = 0
        OnClick = btnCARIClick
      end
      object chkCARI: TCheckBox
        Left = 427
        Top = 14
        Width = 14
        Height = 17
        TabOrder = 1
      end
    end
    object txtArac: TEdit
      Left = 457
      Top = 68
      Width = 127
      Height = 21
      TabOrder = 5
      OnExit = txtAracExit
      OnKeyPress = txtAracKeyPress
    end
    object Button6: TButton
      Left = 586
      Top = 68
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
      OnClick = Button6Click
    end
    object txtSofor_Kod: TEdit
      Left = 457
      Top = 92
      Width = 127
      Height = 21
      TabOrder = 7
      OnExit = txtSofor_KodExit
      OnKeyPress = txtAracKeyPress
    end
    object Button7: TButton
      Left = 586
      Top = 92
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
      OnClick = Button7Click
    end
    object txtGon_Fir: TEdit
      Left = 457
      Top = 124
      Width = 127
      Height = 21
      TabOrder = 9
      OnKeyPress = txtAracKeyPress
      OnKeyUp = txtGon_FirKeyUp
    end
    object txtArac_Plaka: TEdit
      Left = 457
      Top = 148
      Width = 127
      Height = 21
      TabOrder = 10
      OnKeyPress = txtAracKeyPress
      OnKeyUp = txtGon_FirKeyUp
    end
    object txtSofor_Ad_Soy: TEdit
      Left = 457
      Top = 172
      Width = 127
      Height = 21
      TabOrder = 11
      OnKeyPress = txtAracKeyPress
      OnKeyUp = txtGon_FirKeyUp
    end
    object Button8: TButton
      Left = 760
      Top = 44
      Width = 75
      Height = 21
      Caption = 'Bilgilerini Al'
      TabOrder = 12
      Visible = False
    end
    object Button9: TButton
      Left = 768
      Top = 60
      Width = 75
      Height = 21
      Caption = 'Bilgilerini Al'
      TabOrder = 13
      Visible = False
    end
    object Button10: TButton
      Left = 768
      Top = 60
      Width = 75
      Height = 21
      Caption = 'Bilgilerini Al'
      TabOrder = 14
      Visible = False
    end
    object GroupBox5: TGroupBox
      Left = 6
      Top = 153
      Width = 339
      Height = 45
      Caption = 'M'#252#351'teri Komisyonu'
      TabOrder = 15
      object Label13: TLabel
        Left = 129
        Top = 17
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object IB_Currency3: TIB_Currency
        Left = 6
        Top = 14
        Width = 121
        Height = 21
        TabOrder = 0
        AlwaysShowButton = True
      end
      object IB_Currency4: TIB_Currency
        Left = 152
        Top = 14
        Width = 121
        Height = 21
        TabOrder = 1
        AlwaysShowButton = True
      end
      object chkMusKomisyon: TCheckBox
        Left = 304
        Top = 14
        Width = 19
        Height = 17
        TabOrder = 2
      end
    end
    object chkAKl: TCheckBox
      Left = 619
      Top = 118
      Width = 126
      Height = 17
      Caption = 'Ara'#231' Kara Liste'
      TabOrder = 16
    end
    object chkSkl: TCheckBox
      Left = 619
      Top = 142
      Width = 126
      Height = 17
      Caption = 'S'#246'f'#246'r Kara Liste'
      TabOrder = 17
    end
    object txtKom_Id: TIB_Currency
      Left = 688
      Top = 174
      Width = 41
      Height = 21
      TabOrder = 18
      AlwaysShowButton = True
      DisplayFormat = '#'
    end
  end
  object dts_Komisyon: TIB_DataSource
    AutoInsert = False
    Dataset = qry_Komisyon
    Left = 470
    Top = 244
  end
  object qry_Komisyon: TIB_Query
    ColumnAttributes.Strings = (
      'SOFOR_KL=BOOLEAN=1,0'
      'ARAC_KL=BOOLEAN=1,0')
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    FieldsDisplayFormat.Strings = (
      'TEL_2=0(###)#######'
      'FAX=0(###)#######'
      'TEL_1=0(###)#######'
      'GON_FIR_TEL=0(###)#######'
      'SOFOR_TEL=0(###)#######'
      'GON_FIR_TEL1=0(###)#######'
      'SOFOR_TEL1=0(###)#######'
      'ARAC_SAHIBI_TEL1=0(###)#######'
      'ARAC_SAHIBI_TEL=0(###)#######')
    FieldsDisplayLabel.Strings = (
      'DEPO_KOD= Depo Kodu'
      'ADI=Ad'#305
      'ADRESI_1= Adres(1)'
      'ADRESI_2=Adres(2)'
      'SEHIR='#350'ehir'
      'ILCE='#304'l'#231'e'
      'POSTAKOD= Posta Kodu'
      'TEL_1=Telefon(1)'
      'TEL_2=Telefon(2)'
      'FAX=Fax'
      'ID=Fi'#351' No'
      'GONDEREN_FIRMA=G'#246'nderen Firma Ad'#305
      'GON_FIR_ADRES1=G'#246'n. Fir. Adres1'
      'GON_FIR_ADRES2=G'#246'n. Fir. Adres1'
      'GON_FIR_TEL=G'#246'n. Fir. Telefon1'
      'GIDECEGI_YER=Gidece'#287'i Yer'
      'YUK_CINSI=Y'#252'k'#252'n Cinsi'
      'YUK_KILO=Kilosu'
      'YUK_OLCU_BIR='#214'l'#231#252' Birimi'
      'TOPLAM_UCRET='#220'creti'
      'KOMISYON_UCRET=Komisyon '#220'creti'
      'SOFOR_ADI_SOY='#350#246'f'#246'r Ad'#305' - Soyad'#305
      'ARAC_PLAKA=Ara'#231' Plakas'#305
      'SOFOR_ADRESI=S'#246'f'#246'r Adresi'
      'SOFOR_TEL=S'#246'f'#246'r Telefon1'
      'SOFOR_EHLIYET_NO=Ehliyet No'
      'SOFOR_VERGI_DA_NO=Vergi Dairesi No'
      'ARAC_MARKA_MODEL=Ara'#231' Marka Model'
      'ARAC_SAHIBI=Ara'#231' Sahibi'
      'ARAC_SAHIBI_ADRESI=Ara'#231' Sahibi Adresi'
      'ARAC_SAHIBI_TEL=Ara'#231' Sahibi Telefon1'
      'ARAC_RUHSAT_NO=Ara'#231' Ruhsat No'
      'ACIKLAMA=A'#231#305'klamalar'
      'TARIH=Tarihi'
      'KULLANICI='#304#351'lemi Yapan'
      'FIS_NO='#214'z. Fi'#351' No'
      'KDV_DAHIL=Kdv Dahil mi?'
      'YUK_OLCU_TIP='#214'l'#231#252' Tipi'
      'CARI_KOD=Cari Kodu'
      'CARI_ADI=Cari Ad'#305
      'SEVK_ADRES_KOD=Sevk Adresi'
      'SOFOR_VERGI_DA=Vergi Dairesi'
      'ARAC_SAHIBI_TEL1=Ara'#231' Sahibi Telefon2'
      'SOFOR_TEL1=S'#246'f'#246'r Telefon2'
      'GON_FIR_TEL1=G'#246'n. Fir. Telefon2'
      'DORSE_PLAKA=Dorse Plaka'
      'SOFOR_KL='#350#246'f'#246'r Kara Liste'
      'ARAC_KL=Ara'#231' Kara Liste'
      'MUSTERI_KOM=M'#252#351'teri Komisyonu'
      'MASRAF_MERK=Masraf Merkezi'
      'KOD1=Kod1'
      'KOD2=Kod2'
      'KOD3=Kod3'
      'KOD4=Kod4'
      'KASA_KOD=Kasa Kodu'
      'KASA_AD=Kasa Ad'#305
      'ARAC_KOD=Ara'#231' Kodu'
      'ARAC_PLAKA_CO=Ara'#231' Plaka Koddan'
      'SOFOR_KOD='#350#246'f'#246'r Kodu'
      'SOFOR_ADI_CO='#350#246'f'#246'r Ad'#305' Koddan'
      'ARAC_MARKA=Ara'#231' Marka'
      'ARAC_MODEL=Ara'#231' Model'
      'SOFOR_ADRESI1='#350#246'f'#246'r Adres 2'
      'ARAC_SAHIBI_ADRESI1=Ara'#231' Sahibi Adres2'
      'RESIM=Resim')
    FieldsGridLabel.Strings = (
      'ARAC_SAHIBI_TEL=0(###)#######')
    FieldsDisplayWidth.Strings = (
      'ARAC_PLAKA=117'
      'ID=48'
      'SOFOR_ADI_SOY=149'
      'GONDEREN_FIRMA=153'
      'TOPLAM_UCRET=85'
      'KOMISYON_UCRET=91'
      'MUSTERI_KOM=99'
      'SOFOR_KL=86'
      'ARAC_KL=81')
    FieldsEditMask.Strings = (
      'TEL_2=0(###)#######'
      'FAX=0(###)#######'
      'TEL_1=0(###)#######'
      'GON_FIR_TEL=0(###)#######'
      'SOFOR_TEL=0(###)#######'
      'GON_FIR_TEL1=0(###)#######'
      'SOFOR_TEL1=0(###)#######'
      'ARAC_SAHIBI_TEL1=0(###)#######')
    FieldsIndex.Strings = (
      'ID'
      'SID'
      'ARAC_PLAKA'
      'SOFOR_ADI_SOY'
      'GONDEREN_FIRMA'
      'TOPLAM_UCRET'
      'KOMISYON_UCRET'
      'MUSTERI_KOM'
      'SOFOR_KL'
      'ARAC_KL'
      'GON_FIR_ADRES1'
      'GON_FIR_ADRES2'
      'GON_FIR_TEL'
      'GIDECEGI_YER'
      'YUK_CINSI'
      'YUK_KILO'
      'YUK_OLCU_BIR'
      'SOFOR_ADRESI'
      'SOFOR_TEL'
      'SOFOR_EHLIYET_NO'
      'SOFOR_VERGI_DA'
      'SOFOR_VERGI_DA_NO'
      'ARAC_SAHIBI'
      'ARAC_SAHIBI_ADRESI'
      'ARAC_SAHIBI_TEL'
      'ARAC_RUHSAT_NO'
      'ACIKLAMA'
      'TARIH'
      'KULLANICI'
      'FIS_NO'
      'KDV_DAHIL'
      'YUK_OLCU_TIP'
      'CARI_KOD'
      'CARI_ADI'
      'SEVK_ADRES_KOD'
      'MASRAF_MERK'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4'
      'GON_FIR_TEL1'
      'SOFOR_TEL1'
      'ARAC_SAHIBI_TEL1'
      'KASA_KOD'
      'KASA_AD'
      'ARAC_KOD'
      'ARAC_PLAKA_CO'
      'SOFOR_KOD'
      'SOFOR_ADI_CO'
      'ARAC_MARKA'
      'ARAC_MODEL'
      'SOFOR_ADRESI1'
      'ARAC_SAHIBI_ADRESI1'
      'RESIM'
      'DORSE_PLAKA')
    FieldsVisible.Strings = (
      'DEPO_ID=FALSE'
      'DEPO_SID=FALSE'
      'SID=FALSE'
      'KULLANICI=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT ID'
      '     , SID'
      '     , GONDEREN_FIRMA'
      '     , GON_FIR_ADRES1'
      '     , GON_FIR_ADRES2'
      '     , GON_FIR_TEL'
      '     , GIDECEGI_YER'
      '     , YUK_CINSI'
      '     , YUK_KILO'
      '     , YUK_OLCU_BIR'
      '     , TOPLAM_UCRET'
      '     , KOMISYON_UCRET'
      '     , SOFOR_ADI_SOY'
      '     , ARAC_PLAKA'
      '     , SOFOR_ADRESI'
      '     , SOFOR_TEL'
      '     , SOFOR_EHLIYET_NO'
      '     , SOFOR_VERGI_DA'
      '     , SOFOR_VERGI_DA_NO'
      '     , ARAC_SAHIBI'
      '     , ARAC_SAHIBI_ADRESI'
      '     , ARAC_SAHIBI_TEL'
      '     , ARAC_RUHSAT_NO'
      '     , ACIKLAMA'
      '     , TARIH'
      '     , KULLANICI'
      '     , FIS_NO'
      '     , KDV_DAHIL'
      '     , YUK_OLCU_TIP'
      '     , CARI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=KOMISYON.CAR' +
        'I_KOD) AS CARI_ADI'
      '     ,SEVK_ADRES_KOD'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , GON_FIR_TEL1'
      '     , SOFOR_TEL1'
      '     , ARAC_SAHIBI_TEL1'
      '     , KASA_KOD'
      
        '     , (SELECT ACIKLAMA FROM KASA WHERE KOMISYON.KASA_KOD = KASA' +
        '.KASA_KOD) AS KASA_AD'
      '     , ARAC_KOD'
      
        '     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=KOMISYON.ARAC_' +
        'KOD) AS ARAC_PLAKA_CO'
      '     , SOFOR_KOD'
      
        '     ,(SELECT ADI_SOYADI FROM SOFOR WHERE SOFOR.SOFOR_KOD=KOMISY' +
        'ON.SOFOR_KOD) AS SOFOR_ADI_CO'
      '     , ARAC_MARKA'
      '     , ARAC_MODEL'
      '     , SOFOR_ADRESI1'
      '     , ARAC_SAHIBI_ADRESI1'
      '     , RESIM'
      '     , DORSE_PLAKA'
      '     , SOFOR_KL'
      '     , ARAC_KL'
      '     , MUSTERI_KOM'
      'FROM KOMISYON'
      'WHERE ID=:PRM_ID')
    ColorScheme = False
    KeyLinks.Strings = (
      'KOMISYON.ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItemNo = 2
    OrderingItems.Strings = (
      'G'#246'nderen Firma Ad'#305'=GONDEREN_FIRMA;GONDEREN_FIRMA DESC'
      'G'#246'n. Fir. Adres1=GON_FIR_ADRES1;GON_FIR_ADRES1 DESC'
      'G'#246'n. Fir. Adres1=GON_FIR_ADRES2;GON_FIR_ADRES2 DESC'
      'Gidece'#287'i Yer=GIDECEGI_YER;GIDECEGI_YER DESC'
      'Y'#252'k'#252'n Cinsi=YUK_CINSI;YUK_CINSI DESC'
      'Kilosu=YUK_KILO;YUK_KILO DESC'
      #214'l'#231#252' Birimi=YUK_OLCU_BIR;YUK_OLCU_BIR DESC'
      #220'creti=TOPLAM_UCRET;TOPLAM_UCRET DESC'
      'Komisyon '#220'creti=KOMISYON_UCRET;KOMISYON_UCRET DESC'
      #350#246'f'#246'r Ad'#305' - Soyad'#305'=SOFOR_ADI_SOY;SOFOR_ADI_SOY DESC'
      'Ara'#231' Plakas'#305'=ARAC_PLAKA;ARAC_PLAKA DESC'
      'Vergi Dairesi=SOFOR_VERGI_DA;SOFOR_VERGI_DA DESC'
      'Ara'#231' Sahibi=ARAC_SAHIBI;ARAC_SAHIBI DESC'
      'Tarihi=TARIH;TARIH DESC'
      #304#351'lemi Yapan=KULLANICI;KULLANICI DESC'
      #214'z. Fi'#351' No=FIS_NO;FIS_NO DESC'
      'Kdv Dahil mi?=KDV_DAHIL;KDV_DAHIL DESC'
      #214'l'#231#252' Tipi=YUK_OLCU_TIP;YUK_OLCU_TIP DESC'
      'Cari Kodu=CARI_KOD;CARI_KOD DESC'
      'Sevk Adresi=SEVK_ADRES_KOD;SEVK_ADRES_KOD DESC'
      'Fi'#351' No=ID;ID DESC')
    OrderingLinks.Strings = (
      'GONDEREN_FIRMA=ITEM=1'
      'GON_FIR_ADRES1=ITEM=2'
      'GON_FIR_ADRES2=ITEM=3'
      'GIDECEGI_YER=ITEM=4'
      'YUK_CINSI=ITEM=5'
      'YUK_KILO=ITEM=6'
      'YUK_OLCU_BIR=ITEM=7'
      'TOPLAM_UCRET=ITEM=8'
      'KOMISYON_UCRET=ITEM=9'
      'SOFOR_ADI_SOY=ITEM=10'
      'ARAC_PLAKA=ITEM=11'
      'SOFOR_VERGI_DA=ITEM=12'
      'ARAC_SAHIBI=ITEM=13'
      'TARIH=ITEM=14'
      'KULLANICI=ITEM=15'
      'FIS_NO=ITEM=16'
      'KDV_DAHIL=ITEM=17'
      'YUK_OLCU_TIP=ITEM=18'
      'CARI_KOD=ITEM=19'
      'SEVK_ADRES_KOD=ITEM=20'
      'ID=ITEM=21')
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 388
    Top = 238
    ParamValues = (
      'PRM_ID=0')
  end
end
