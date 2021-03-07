object frmOnarim_SDLG: TfrmOnarim_SDLG
  Left = 100
  Top = 134
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Onar'#305'm Fi'#351'i Listesi'
  ClientHeight = 533
  ClientWidth = 791
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 494
    Width = 791
    Height = 39
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      791
      39)
    object btnIPTAL: TBitBtn
      Left = 627
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
      Left = 711
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
    object btn_Fast: TButton
      Left = 6
      Top = 8
      Width = 97
      Height = 25
      Caption = 'Rapor Olu'#351'tur'
      TabOrder = 2
      OnClick = btnRaporClick
    end
    object CheckBox3: TCheckBox
      Left = 111
      Top = 13
      Width = 97
      Height = 17
      Caption = 'Detayl'#305' Rapor'
      TabOrder = 3
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 49
    Width = 791
    Height = 136
    Align = alTop
    TabOrder = 1
    object Label5: TLabel
      Left = 10
      Top = 55
      Width = 50
      Height = 13
      Caption = 'Ara'#231' Kodu'
    end
    object LblPlaka: TLabel
      Left = 234
      Top = 55
      Width = 63
      Height = 13
      Caption = 'Ara'#231' Plaka'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btn_Ara: TButton
      Left = 709
      Top = 46
      Width = 77
      Height = 39
      Caption = '&Ara'
      TabOrder = 4
      OnClick = btn_AraClick
    end
    object GroupBox1: TGroupBox
      Left = 3
      Top = 1
      Width = 460
      Height = 39
      TabOrder = 0
      object lbl_CARIKOD: TLabel
        Left = 96
        Top = 15
        Width = 97
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl_CARI: TLabel
        Left = 200
        Top = 15
        Width = 241
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnCARI: TButton
        Left = 4
        Top = 12
        Width = 87
        Height = 21
        Caption = '&Cari Listesi'
        TabOrder = 0
        OnClick = btnCariClick
      end
      object chkCARI: TCheckBox
        Left = 443
        Top = 14
        Width = 14
        Height = 17
        TabOrder = 1
        OnClick = chkCariClick
        OnEnter = chkRAPKODEnter
        OnExit = chkRAPKODExit
      end
    end
    object GroupBox2: TGroupBox
      Left = 458
      Top = 41
      Width = 247
      Height = 45
      Caption = 'Giri'#351' Tarihi'
      TabOrder = 3
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
        OnEnter = dtpIslemTarEnter
        OnExit = dtpIslemTarExit
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
        OnEnter = dtpIslemTarEnter
        OnExit = dtpIslemTarExit
      end
    end
    object GroupBox3: TGroupBox
      Left = 726
      Top = 89
      Width = 280
      Height = 45
      Caption = 'Tutar'
      TabOrder = 2
      Visible = False
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
        OnEnter = Tutar1Enter
        OnExit = Tutar1Exit
        AlwaysShowButton = True
      end
      object Tutar2: TIB_Currency
        Left = 152
        Top = 14
        Width = 121
        Height = 21
        TabOrder = 1
        OnEnter = Tutar1Enter
        OnExit = Tutar1Exit
        AlwaysShowButton = True
      end
    end
    object GroupBox4: TGroupBox
      Left = 466
      Top = 1
      Width = 321
      Height = 38
      TabOrder = 1
      object Label10: TLabel
        Left = 8
        Top = 16
        Width = 30
        Height = 13
        Caption = 'Fi'#351' No'
      end
      object Fat_No: TEdit
        Left = 64
        Top = 12
        Width = 80
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = Fat_NoExit
      end
      object cmbSube: TComboBox
        Left = 204
        Top = 12
        Width = 109
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnEnter = cmbTIPSECEnter
        OnExit = cmbTIPSECExit
      end
    end
    object cb_Yazdirildi: TCheckBox
      Left = 8
      Top = 96
      Width = 65
      Height = 17
      Caption = 'Yazd'#305'r'#305'ld'#305
      State = cbGrayed
      TabOrder = 5
    end
    object txtArac: TEdit
      Left = 81
      Top = 52
      Width = 127
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtAracExit
    end
    object Button6: TButton
      Left = 210
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
      TabOrder = 7
      OnClick = Button6Click
    end
    object GroupBox5: TGroupBox
      Left = 458
      Top = 89
      Width = 247
      Height = 45
      Caption = 'Teslim Tarihi'
      TabOrder = 8
      object Label6: TLabel
        Left = 112
        Top = 18
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object dtpIslemTart: TDateTimePicker
        Left = 7
        Top = 15
        Width = 101
        Height = 21
        Date = 37554.733220983800000000
        Time = 37554.733220983800000000
        ShowCheckbox = True
        Checked = False
        TabOrder = 0
        OnEnter = dtpIslemTarEnter
        OnExit = dtpIslemTarExit
      end
      object dtpIslemTart2: TDateTimePicker
        Left = 137
        Top = 14
        Width = 100
        Height = 21
        Date = 37554.733416122690000000
        Time = 37554.733416122690000000
        ShowCheckbox = True
        Checked = False
        TabOrder = 1
        OnEnter = dtpIslemTarEnter
        OnExit = dtpIslemTarExit
      end
    end
    object cb_Iptal: TCheckBox
      Left = 160
      Top = 96
      Width = 81
      Height = 17
      Caption = #304'ptal Edilen'
      State = cbGrayed
      TabOrder = 9
    end
    object cb_Fatura: TCheckBox
      Left = 312
      Top = 96
      Width = 97
      Height = 17
      Caption = 'Faturas'#305' Kesilen'
      State = cbGrayed
      TabOrder = 10
    end
  end
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 185
    Width = 791
    Height = 159
    CustomGlyphsSupplied = []
    DataSource = dtsFAT_IRS
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 2
    OnKeyPress = IB_Grid1KeyPress
    RowSelect = True
    Ctl3DShallow = True
    OnCellDblClick = IB_Grid1CellDblClick
  end
  object pnlRAPKOD: TPanel
    Left = 0
    Top = 0
    Width = 791
    Height = 49
    Align = alTop
    TabOrder = 0
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
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtISLEMMERKEZIExit
      OnKeyPress = txtKOD4KeyPress
    end
    object txtKOD1: TEdit
      Left = 150
      Top = 20
      Width = 79
      Height = 21
      TabOrder = 2
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD1Exit
      OnKeyPress = txtKOD4KeyPress
    end
    object txtKOD2: TEdit
      Left = 288
      Top = 19
      Width = 79
      Height = 21
      TabOrder = 4
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD2Exit
      OnKeyPress = txtKOD4KeyPress
    end
    object txtKOD3: TEdit
      Left = 430
      Top = 20
      Width = 79
      Height = 21
      TabOrder = 6
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD3Exit
      OnKeyPress = txtKOD4KeyPress
    end
    object txtKOD4: TEdit
      Left = 568
      Top = 20
      Width = 79
      Height = 21
      TabOrder = 8
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD4Exit
      OnKeyPress = txtKOD4KeyPress
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
      OnClick = Button1Click
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
      OnClick = Button2Click
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
      OnClick = Button3Click
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
      OnClick = Button4Click
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
      OnClick = Button5Click
    end
    object chkRAPKOD: TCheckBox
      Left = 765
      Top = 22
      Width = 15
      Height = 17
      TabOrder = 10
      OnEnter = chkRAPKODEnter
      OnExit = chkRAPKODExit
    end
  end
  object IB_Grid2: TIB_Grid
    Left = 0
    Top = 344
    Width = 791
    Height = 150
    CustomGlyphsSupplied = []
    DataSource = dtsURUNHAR
    Align = alBottom
    BorderStyle = bsNone
    TabOrder = 4
    OnKeyPress = IB_Grid1KeyPress
    RowSelect = True
    Ctl3DShallow = True
    OnCellDblClick = IB_Grid1CellDblClick
  end
  object qryFAT_IRS: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    FieldsDisplayLabel.Strings = (
      'CARI_KOD=Cari Kod'
      'CARI_AD=Cari Ad'
      'FATURA_KOD=Fatura Kod'
      'FATSERI=Seri'
      'FATURA_NO=Fatura No'
      'TARIH=Tarih'
      'GENELTOP=Genel Toplam'
      'VADE_TARIH=Vad. Tarihi'
      'VADE_GUN=Vad. G'#252'n'
      'ACIKLAMA=A'#231#305'klama'
      'FATURA_ID=FIS NO'
      'FAT_IRS_ID=Fi'#351' No'
      'FAT_IRS_SERI=Seri No'
      'BELGE_NO=Belge No'
      'GENEL_TOP=Genel Toplam'
      'ARAC_KODU=Ara'#231' Kodu'
      'ARAC_PLAKA=Ara'#231' Plaka'
      'ONARIM_ID=Fi'#351' No'
      'GIRIS_TARIH=Giri'#351' Tarihi'
      'GIRIS_KM=Giri'#351' Km'
      'ONCEKI_KM='#214'nceki Km'
      'CARI_ADI=Cari Ad'#305
      'GELIS_NEDENI=Geli'#351' Nedeni'
      'ODEME_SEKLI='#214'deme '#350'ekli'
      'YAKIT_SEVIYESI=Yak'#305't Seviyesi'
      'GARANTI_ISLEMI=Garanti '#304#351'lemi'
      'EXSPERTIZ_ISLEMI=Expertiz '#304#351'lemi'
      'SOK_PAR_IADE=S'#246'k'#252'len Par'#231'a '#304'ade'
      'TESLIM_EDEN=Teslim Eden'
      'ALACAK_OLAN=Alacak Olan'
      'TELEFON=Telefon'
      'SIGORTA_KOD=Sigorta Kod'
      'TESLIM_TAR=Telim Tarihi'
      'TESLIM_SAAT=Teslim Saati'
      'TAHMINI_PARCA_TUTAR=Tahmini Par'#231'a tutar'
      'TAHMINI_ISCILIK_TUTAR=Tahmini '#304#351#231'ilk Tutar'
      'GIRIS_SAAT=Giri'#351' Sati'
      'ONARIM_ISTEKLERI=Onar'#305'm '#304'stekleri'
      'MUSTERI_SIKAYETI=M'#252#351'teri '#350'ikayeti'
      'SERVIS_NOTU=Servis Notu'
      'YAZILDI=Yaz'#305'ld'#305
      'BRUT_TOP=B'#252'r'#252't Toplam'
      'NET_TOP=Net Toplam'
      'KDV_TOP=Kdv Toplam'#305
      'DEPO_KOD=Depo Kkod'
      'SAAT=Saat'
      'KALEM_ISKONTO_TOPLAM_VPB=K'
      'ODEMETAR='#214'deme Tarihi'
      'PROJE_KOD=Proje Kod'
      'PROJE_AD=Proje Ad'#305
      'MASRAF_MERK=Masraf Merkezi'
      'KOD1=Kod1'
      'KOD2=kod2'
      'KOD3=Kod3'
      'KOD4=Kod4'
      'SEVK_ADRES_KOD=Sev Adres Kod')
    FieldsDisplayWidth.Strings = (
      'GENELTOP=132'
      'FATURA_NO=53'
      'TARIH=62'
      'FATSERI=46'
      'ACIKLAMA=231'
      'VADE_TARIH=62'
      'CARI_KOD=116'
      'CARI_AD=148'
      'FATURA_KOD=100'
      'VADE_GUN=25'
      'FAT_IRS_ID=61'
      'FAT_IRS_SERI=60'
      'BELGE_NO=76')
    FieldsIndex.Strings = (
      'ONARIM_ID'
      'GIRIS_KM'
      'ARAC_KODU'
      'ARAC_PLAKA'
      'CARI_KOD'
      'CARI_ADI'
      'ACIKLAMA'
      'GENEL_TOP'
      'ONARIM_SID'
      'GELIS_NEDENI'
      'ONCEKI_KM'
      'ODEME_SEKLI'
      'YAKIT_SEVIYESI'
      'GARANTI_ISLEMI'
      'EXSPERTIZ_ISLEMI'
      'SOK_PAR_IADE'
      'TESLIM_EDEN'
      'ALACAK_OLAN'
      'TELEFON'
      'SIGORTA_KOD'
      'TESLIM_TAR'
      'TESLIM_SAAT'
      'TAHMINI_PARCA_TUTAR'
      'TAHMINI_ISCILIK_TUTAR'
      'GIRIS_TARIH'
      'GIRIS_SAAT'
      'ONARIM_ISTEKLERI'
      'MUSTERI_SIKAYETI'
      'SERVIS_NOTU'
      'YAZILDI'
      'BRUT_TOP'
      'NET_TOP'
      'KDV_TOP'
      'DEPO_KOD'
      'SAAT'
      'KALEM_ISKONTO_TOPLAM_VPB'
      'ISKONTO_TIP'
      'ISKONTO_ORAN'
      'ISKONTO_TUTAR_VPB'
      'ISKONTO_TOPLAM_VPB'
      'KDV1'
      'KDV2'
      'KDV3'
      'KDV4'
      'KDV5'
      'OTV'
      'VADE_GUN'
      'VADE_TARIH'
      'KDV1_ORAN'
      'KDV2_ORAN'
      'KDV3_ORAN'
      'KDV4_ORAN'
      'KDV5_ORAN'
      'ODEMETAR'
      'PROJE_KOD'
      'PROJE_AD'
      'MASRAF_MERK'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4'
      'SECIM'
      'KAPANDI'
      'SEVK_ADRES_KOD')
    FieldsVisible.Strings = (
      'FATURA_ID=TRUE'
      'FATURA_SID=FALSE'
      'CARI_ID=FALSE'
      'CARI_SID=FALSE'
      'FAT_IRS_SEP=FALSE'
      'FAT_IRS_SID=FALSE'
      'ONARIM_SID=FALSE'
      'KALEM_ISKONTO_TOPLAM_VPB=FALSE'
      'ISKONTO_TIP=FALSE'
      'ISKONTO_ORAN=FALSE'
      'ISKONTO_TUTAR_VPB=FALSE'
      'ISKONTO_TOPLAM_VPB=FALSE'
      'KDV1=FALSE'
      'KDV2=FALSE'
      'KDV3=FALSE'
      'KDV4=FALSE'
      'KDV5=FALSE'
      'OTV=FALSE'
      'VADE_GUN=FALSE'
      'VADE_TARIH=FALSE'
      'KDV1_ORAN=FALSE'
      'KDV2_ORAN=FALSE'
      'KDV3_ORAN=FALSE'
      'KDV4_ORAN=FALSE'
      'KDV5_ORAN=FALSE'
      'SECIM=FALSE'
      'KAPANDI=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT ONARIM_ID'
      '     , ONARIM_SID'
      '     , ARAC_KODU'
      
        '     ,(SELECT PLAKA FROM SRV_ARAC WHERE SRV_ARAC_ONARIM.ARAC_KOD' +
        'U=SRV_ARAC.ARAC_KOD) AS ARAC_PLAKA'
      '     , GELIS_NEDENI'
      '     , GIRIS_KM'
      '     , ONCEKI_KM'
      '     , ODEME_SEKLI'
      '     , YAKIT_SEVIYESI'
      '     , GARANTI_ISLEMI'
      '     , EXSPERTIZ_ISLEMI'
      '     , SOK_PAR_IADE'
      '     , TESLIM_EDEN'
      '     , ALACAK_OLAN'
      '     , TELEFON'
      '     , SIGORTA_KOD'
      '     , TESLIM_TAR'
      '     , TESLIM_SAAT'
      '     , TAHMINI_PARCA_TUTAR'
      '     , TAHMINI_ISCILIK_TUTAR'
      '     , GIRIS_TARIH'
      '     , GIRIS_SAAT'
      '     , ONARIM_ISTEKLERI'
      '     , MUSTERI_SIKAYETI'
      '     , SERVIS_NOTU'
      '     , YAZILDI'
      '     , ACIKLAMA'
      '     , BRUT_TOP'
      '     , NET_TOP'
      '     , GENEL_TOP'
      '     , KDV_TOP'
      '     , DEPO_KOD'
      '     , SAAT'
      '     , KALEM_ISKONTO_TOPLAM_VPB'
      '     , ISKONTO_TIP'
      '     , ISKONTO_ORAN'
      '     , ISKONTO_TUTAR_VPB'
      '     , ISKONTO_TOPLAM_VPB'
      '     , KDV1'
      '     , KDV2'
      '     , KDV3'
      '     , KDV4'
      '     , KDV5'
      '     , OTV'
      '     , VADE_GUN'
      '     , VADE_TARIH'
      '     , KDV1_ORAN'
      '     , KDV2_ORAN'
      '     , KDV3_ORAN'
      '     , KDV4_ORAN'
      '     , KDV5_ORAN'
      '     , ODEMETAR'
      '     , PROJE_KOD'
      
        '     , (Select PROJE.PROJE_AD From PROJE Where PROJE.PROJE_KOD=S' +
        'RV_ARAC_ONARIM.PROJE_KOD) As PROJE_AD'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , SECIM'
      '     , KAPANDI'
      '     , SEVK_ADRES_KOD'
      '     , CARI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SRV_ARAC_ONA' +
        'RIM.CARI_KOD) AS CARI_ADI'
      'FROM SRV_ARAC_ONARIM'
      ''
      '')
    ColorScheme = False
    KeyLinks.Strings = (
      'SRV_ARAC_ONARIM.ONARIM_ID'
      'SRV_ARAC_ONARIM.ONARIM_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItemNo = 1
    OrderingItems.Strings = (
      'Cari Kod=CARI_KOD;CARI_KOD DESC'
      'Giri'#351' Tarihi=GIRIS_TARIH;GIRIS_TARIH DESC'
      'Ara'#231' Kodu=ARAC_KODU;ARAC_KODU DESC')
    OrderingLinks.Strings = (
      'CARI_KOD=ITEM=1'
      'GIRIS_TARIH=ITEM=2'
      'ARAC_KODU=ITEM=3')
    AfterScroll = qryFAT_IRSAfterScroll
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 219
    Top = 240
  end
  object dtsFAT_IRS: TIB_DataSource
    Dataset = qryFAT_IRS
    Left = 148
    Top = 240
  end
  object frxReport1: TfrxReport
    Version = '4.3'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39136.775302905100000000
    ReportOptions.LastChange = 39178.403249953720000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnBeforePrint = frxReport1BeforePrint
    Left = 400
    Top = 265
    Datasets = <
      item
        DataSet = frxIBODts_On_Fis_Lis_Det
        DataSetName = 'frxIBODts_On_Fis_Lis_Det'
      end>
    Variables = <>
    Style = <
      item
        Name = 'Title'
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Header'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Group header'
        Color = 16053492
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Data'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
      end
      item
        Name = 'Group footer'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Header line'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftBottom]
        Frame.Width = 2.000000000000000000
      end>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object ReportTitle1: TfrxReportTitle
        Height = 132.283550000000000000
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 132.283550000000000000
        end
        object Memo_Sirket_adi: TfrxMemoView
          Left = 18.897650000000000000
          Top = 22.677180000000000000
          Width = 521.575140000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            #197#158'irket Ad'#196#177)
          ParentFont = False
        end
        object Memo_Rapor_Adi: TfrxMemoView
          Left = 374.173470000000000000
          Top = 49.133889999999990000
          Width = 196.299320000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Detayl'#196#177' Onar'#196#177'm Fi'#197#376'i Listesi')
          ParentFont = False
        end
        object Memo_Bit_Tar: TfrxMemoView
          Left = 975.118740000000000000
          Top = 41.574830000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd.mm.yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            'Bit Tar')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 869.291900000000000000
          Top = 41.574830000000000000
          Width = 96.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Yay'#196#177'n Tarihi:')
          ParentFont = False
          Style = 'Header'
        end
        object Memo5: TfrxMemoView
          Left = 869.291900000000000000
          Top = 64.252010000000000000
          Width = 96.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Revizyon Tarihi')
          ParentFont = False
          Style = 'Header'
        end
        object Memo6: TfrxMemoView
          Left = 869.291900000000000000
          Top = 86.929190000000000000
          Width = 96.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Revizyon No:')
          ParentFont = False
          Style = 'Header'
        end
        object Memo8: TfrxMemoView
          Left = 869.291900000000000000
          Top = 18.897650000000000000
          Width = 96.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'D'#195#182'k'#195#188'man No:')
          ParentFont = False
          Style = 'Header'
        end
        object Memo_Batar: TfrxMemoView
          Left = 17.385900000000000000
          Top = 105.102350000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd.mm.yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            'Bas Tar')
          ParentFont = False
        end
        object Memo26: TfrxMemoView
          Left = 16.000000000000000000
          Top = 79.102350000000000000
          Width = 134.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Rapor Tarihi Aral'#196#177#196#376#196#177)
          ParentFont = False
          Style = 'Header'
        end
        object Memo_Bitar: TfrxMemoView
          Left = 122.000000000000000000
          Top = 105.102350000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          AutoWidth = True
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd.mm.yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            'Bit Tar')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        Height = 22.677180000000000000
        Top = 343.008040000000000000
        Width = 1084.725110000000000000
        DataSet = frxIBODts_On_Fis_Lis_Det
        DataSetName = 'frxIBODts_On_Fis_Lis_Det'
        RowCount = 0
        object Shape4: TfrxShapeView
          Align = baClient
          Width = 1084.725110000000000000
          Height = 22.677180000000000000
        end
        object Memo3: TfrxMemoView
          Left = 5.779530000000000000
          Top = 1.968459999999987000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DataField = 'URUN_KOD'
          DataSet = frxIBODts_On_Fis_Lis_Det
          DataSetName = 'frxIBODts_On_Fis_Lis_Det'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_On_Fis_Lis_Det."URUN_KOD"]')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          Left = 126.724490000000000000
          Top = 1.968459999999987000
          Width = 298.582870000000000000
          Height = 18.897650000000000000
          DataField = 'ACIKLAMA_DETAY'
          DataSet = frxIBODts_On_Fis_Lis_Det
          DataSetName = 'frxIBODts_On_Fis_Lis_Det'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_On_Fis_Lis_Det."ACIKLAMA_DETAY"]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          Left = 432.866420000000000000
          Top = 1.968459999999987000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'MIKTAR'
          DataSet = frxIBODts_On_Fis_Lis_Det
          DataSetName = 'frxIBODts_On_Fis_Lis_Det'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_On_Fis_Lis_Det."MIKTAR"]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 519.795610000000000000
          Top = 1.968459999999987000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DataField = 'BIRIM_FIY_VPB'
          DataSet = frxIBODts_On_Fis_Lis_Det
          DataSetName = 'frxIBODts_On_Fis_Lis_Det'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_On_Fis_Lis_Det."BIRIM_FIY_VPB"]')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Left = 640.740570000000000000
          Top = 1.968459999999987000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DataField = 'TUTAR_VPB'
          DataSet = frxIBODts_On_Fis_Lis_Det
          DataSetName = 'frxIBODts_On_Fis_Lis_Det'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[frxIBODts_On_Fis_Lis_Det."TUTAR_VPB"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 429.086890000000000000
          Top = 0.188930000000021600
          Height = 23.456710000000000000
          Frame.Typ = [ftLeft]
        end
        object Line2: TfrxLineView
          Left = 516.016080000000000000
          Top = 0.188930000000021600
          Height = 23.456710000000000000
          Frame.Typ = [ftLeft]
        end
        object Line11: TfrxLineView
          Left = 636.961040000000000000
          Top = 0.188930000000021600
          Height = 23.456710000000000000
          Frame.Typ = [ftLeft]
        end
        object Line13: TfrxLineView
          Left = 123.000000000000000000
          Top = 0.606060000000007600
          Height = 23.456710000000000000
          Frame.Typ = [ftLeft]
        end
        object Line26: TfrxLineView
          Left = 758.000000000000000000
          Top = 0.991960000000000000
          Height = 23.456710000000000000
          Frame.Typ = [ftLeft]
        end
      end
      object PageFooter1: TfrxPageFooter
        Height = 18.897650000000000000
        Top = 495.677490000000000000
        Width = 1084.725110000000000000
        object SysMemo3: TfrxSysMemoView
          Align = baCenter
          Left = 495.118430000000100000
          Top = -0.000000000000022510
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[PAGE#] / [TOTALPAGES#]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        Height = 31.519790000000000000
        Top = 421.157700000000000000
        Width = 1084.725110000000000000
        object Shape6: TfrxShapeView
          Top = -0.000000000000022926
          Width = 1085.000000000000000000
          Height = 32.000000000000000000
        end
        object SysMemo1: TfrxSysMemoView
          Left = 139.842610000000000000
          Top = 7.559059999999965000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[LINE#]')
          ParentFont = False
        end
        object Memo35: TfrxMemoView
          Left = 7.559060000000000000
          Top = 7.559059999999965000
          Width = 129.000000000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Toplam Sat'#196#177'r Say'#196#177's'#196#177)
          ParentFont = False
          Style = 'Header'
        end
        object Memo14: TfrxMemoView
          Left = 963.630490000000000000
          Top = 6.559059999999965000
          Width = 117.661410000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            '[SUM(<frxIBODts_On_Fis_Lis_Det."GENEL_TOP">,MasterData1)]')
          ParentFont = False
        end
        object Line12: TfrxLineView
          Left = 959.000000000000000000
          Top = -0.000000000000022926
          Height = 32.000000000000000000
          Frame.Typ = [ftLeft]
        end
      end
      object GroupHeader2: TfrxGroupHeader
        Height = 91.015770000000000000
        Top = 188.000000000000000000
        Width = 1084.725110000000000000
        Condition = '<frxIBODts_On_Fis_Lis_Det."ONARIM_ID">'
        object Shape5: TfrxShapeView
          Top = 68.000000000000000000
          Width = 1085.000000000000000000
          Height = 23.000000000000000000
        end
        object Shape2: TfrxShapeView
          Top = 10.000000000000000000
          Width = 1084.725110000000000000
          Height = 22.677180000000000000
        end
        object Memo31: TfrxMemoView
          Left = 107.417440000000000000
          Top = 12.000000000000000000
          Width = 88.047310000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Tarih')
          ParentFont = False
          Style = 'Header'
        end
        object Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Top = 12.000000000000000000
          Width = 94.220470000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Fi'#197#376' No')
          ParentFont = False
          Style = 'Header'
        end
        object Memo24: TfrxMemoView
          Left = 468.181510000000000000
          Top = 12.000000000000000000
          Width = 127.984230000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Cari Kod')
          ParentFont = False
          Style = 'Header'
        end
        object Memo25: TfrxMemoView
          Left = 606.228820000000000000
          Top = 12.000000000000000000
          Width = 171.661410000000000000
          Height = 18.897650000000000000
          DataSet = frmRaporSkAracHareketleriRaporu.frxIBODataset1
          DataSetName = 'frxIBODataset1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Cari Ad')
          ParentFont = False
          Style = 'Header'
        end
        object Memo17: TfrxMemoView
          Left = 785.583180000000000000
          Top = 12.000000000000000000
          Width = 168.984230000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'A'#195#167#196#177'klama')
          ParentFont = False
          Style = 'Header'
        end
        object Memo21: TfrxMemoView
          Left = 963.630490000000000000
          Top = 12.000000000000000000
          Width = 107.661410000000000000
          Height = 18.897650000000000000
          DataSet = frmRaporSkAracHareketleriRaporu.frxIBODataset1
          DataSetName = 'frxIBODataset1'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Genel Toplam')
          ParentFont = False
          Style = 'Header'
        end
        object Line3: TfrxLineView
          Left = 959.000000000000000000
          Top = 10.141619999999990000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          Left = 783.000000000000000000
          Top = 10.141619999999990000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line7: TfrxLineView
          Left = 600.000000000000000000
          Top = 11.141619999999990000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line9: TfrxLineView
          Left = 463.000000000000000000
          Top = 11.141619999999990000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line16: TfrxLineView
          Left = 339.000000000000000000
          Top = 11.141619999999990000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line18: TfrxLineView
          Left = 199.000000000000000000
          Top = 10.141619999999990000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line19: TfrxLineView
          Left = 102.000000000000000000
          Top = 10.141619999999990000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Shape3: TfrxShapeView
          Top = 33.000000000000000000
          Width = 1084.725110000000000000
          Height = 22.677180000000000000
        end
        object Memo7: TfrxMemoView
          Left = 3.779530000000000000
          Top = 35.000000000000000000
          Width = 94.220470000000000000
          Height = 18.897650000000000000
          DataSet = frmFAT_IRS_SDLG.frxIBODts_FaturaList
          DataSetName = 'frxIBODts_FaturaList'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[(<frxIBODts_On_Fis_Lis_Det."ONARIM_ID">)]')
          ParentFont = False
          Style = 'Data'
        end
        object Memo18: TfrxMemoView
          Left = 107.417440000000000000
          Top = 35.000000000000000000
          Width = 88.047310000000000000
          Height = 18.897650000000000000
          DataSet = frmFAT_IRS_SDLG.frxIBODts_FaturaList
          DataSetName = 'frxIBODts_FaturaList'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = 'dd.mm.yyyy'
          DisplayFormat.Kind = fkDateTime
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[(<frxIBODts_On_Fis_Lis_Det."GIRIS_TARIH">)]')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          Left = 468.181510000000000000
          Top = 35.000000000000000000
          Width = 127.984230000000000000
          Height = 18.897650000000000000
          DataSet = frmFAT_IRS_SDLG.frxIBODts_FaturaList
          DataSetName = 'frxIBODts_FaturaList'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[(<frxIBODts_On_Fis_Lis_Det."CARI_KOD">)]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 606.228820000000000000
          Top = 35.000000000000000000
          Width = 171.661410000000000000
          Height = 18.897650000000000000
          DataSet = frmFAT_IRS_SDLG.frxIBODts_FaturaList
          DataSetName = 'frxIBODts_FaturaList'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[(<frxIBODts_On_Fis_Lis_Det."CARI_ADI">)]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 786.583180000000000000
          Top = 35.000000000000000000
          Width = 167.984230000000000000
          Height = 18.897650000000000000
          DataSet = frmFAT_IRS_SDLG.frxIBODts_FaturaList
          DataSetName = 'frxIBODts_FaturaList'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[(<frxIBODts_On_Fis_Lis_Det."ACIKLAMA">)]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 963.630490000000000000
          Top = 35.000000000000000000
          Width = 104.661410000000000000
          Height = 18.897650000000000000
          DataSet = frmFAT_IRS_SDLG.frxIBODts_FaturaList
          DataSetName = 'frxIBODts_FaturaList'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            '[(<frxIBODts_On_Fis_Lis_Det."GENEL_TOP">)]')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Left = 959.000000000000000000
          Top = 33.991960000000010000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line10: TfrxLineView
          Left = 463.000000000000000000
          Top = 33.991960000000010000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line17: TfrxLineView
          Left = 339.000000000000000000
          Top = 34.991960000000010000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line20: TfrxLineView
          Left = 102.000000000000000000
          Top = 33.991960000000010000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line21: TfrxLineView
          Left = 199.000000000000000000
          Top = 33.991960000000010000
          Height = 22.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line6: TfrxLineView
          Left = 783.000000000000000000
          Top = 33.000000000000000000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          Left = 600.000000000000000000
          Top = 33.000000000000000000
          Height = 24.000000000000000000
          Frame.Typ = [ftLeft]
        end
        object Memo27: TfrxMemoView
          Left = 5.779530000000000000
          Top = 69.559059999999990000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Par'#195#167'a '#196#176#197#376#195#167'ilik kod')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 126.724490000000000000
          Top = 69.559059999999990000
          Width = 298.582870000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'A'#195#167#196#177'klama')
          ParentFont = False
        end
        object Memo29: TfrxMemoView
          Left = 432.866420000000000000
          Top = 69.559059999999990000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            'Miktar/S'#195#188're')
          ParentFont = False
        end
        object Memo30: TfrxMemoView
          Left = 519.795610000000000000
          Top = 69.559059999999990000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            'Birim Fiyat'#196#177)
          ParentFont = False
        end
        object Memo32: TfrxMemoView
          Left = 640.740570000000000000
          Top = 69.559059999999990000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8 = (
            'Tutar')
          ParentFont = False
        end
        object Line15: TfrxLineView
          Left = 122.944960000000000000
          Top = 68.000000000000000000
          Height = 23.015770000000000000
          Frame.Typ = [ftLeft]
        end
        object Line22: TfrxLineView
          Left = 429.086890000000000000
          Top = 68.000000000000000000
          Height = 23.015770000000000000
          Frame.Typ = [ftLeft]
        end
        object Line23: TfrxLineView
          Left = 516.016080000000000000
          Top = 68.000000000000000000
          Height = 23.015770000000000000
          Frame.Typ = [ftLeft]
        end
        object Line24: TfrxLineView
          Left = 636.961040000000000000
          Top = 68.000000000000000000
          Height = 23.015770000000000000
          Frame.Typ = [ftLeft]
        end
        object Line25: TfrxLineView
          Left = 758.000000000000000000
          Top = 69.000000000000000000
          Height = 23.015770000000000000
          Frame.Typ = [ftLeft]
        end
        object Memo1: TfrxMemoView
          Left = 203.000000000000000000
          Top = 12.000000000000000000
          Width = 129.984230000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Ara'#195#167' Kodu')
          ParentFont = False
          Style = 'Header'
        end
        object Memo2: TfrxMemoView
          Left = 203.000000000000000000
          Top = 35.000000000000000000
          Width = 129.984230000000000000
          Height = 18.897650000000000000
          DataSet = frmFAT_IRS_SDLG.frxIBODts_FaturaList
          DataSetName = 'frxIBODts_FaturaList'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[(<frxIBODts_On_Fis_Lis_Det."ARAC_KODU">)]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 344.000000000000000000
          Top = 12.000000000000000000
          Width = 114.984230000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8 = (
            'Plaka')
          ParentFont = False
          Style = 'Header'
        end
        object Memo23: TfrxMemoView
          Left = 345.000000000000000000
          Top = 35.000000000000000000
          Width = 113.984230000000000000
          Height = 18.897650000000000000
          DataSet = frmFAT_IRS_SDLG.frxIBODts_FaturaList
          DataSetName = 'frxIBODts_FaturaList'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[(<frxIBODts_On_Fis_Lis_Det."ARAC_PLAKA">)]')
          ParentFont = False
        end
      end
    end
  end
  object frxIBODts_Onarim_Fis_Lis: TfrxIBODataset
    UserName = 'frxIBODts_Onarim_Fis_Lis'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ONARIM_ID=ONARIM_ID'
      'GIRIS_KM=GIRIS_KM'
      'ARAC_KODU=ARAC_KODU'
      'ARAC_PLAKA=ARAC_PLAKA'
      'CARI_KOD=CARI_KOD'
      'CARI_ADI=CARI_ADI'
      'ACIKLAMA=ACIKLAMA'
      'GENEL_TOP=GENEL_TOP'
      'ONARIM_SID=ONARIM_SID'
      'GELIS_NEDENI=GELIS_NEDENI'
      'ONCEKI_KM=ONCEKI_KM'
      'ODEME_SEKLI=ODEME_SEKLI'
      'YAKIT_SEVIYESI=YAKIT_SEVIYESI'
      'GARANTI_ISLEMI=GARANTI_ISLEMI'
      'EXSPERTIZ_ISLEMI=EXSPERTIZ_ISLEMI'
      'SOK_PAR_IADE=SOK_PAR_IADE'
      'TESLIM_EDEN=TESLIM_EDEN'
      'ALACAK_OLAN=ALACAK_OLAN'
      'TELEFON=TELEFON'
      'SIGORTA_KOD=SIGORTA_KOD'
      'TESLIM_TAR=TESLIM_TAR'
      'TESLIM_SAAT=TESLIM_SAAT'
      'TAHMINI_PARCA_TUTAR=TAHMINI_PARCA_TUTAR'
      'TAHMINI_ISCILIK_TUTAR=TAHMINI_ISCILIK_TUTAR'
      'GIRIS_TARIH=GIRIS_TARIH'
      'GIRIS_SAAT=GIRIS_SAAT'
      'ONARIM_ISTEKLERI=ONARIM_ISTEKLERI'
      'MUSTERI_SIKAYETI=MUSTERI_SIKAYETI'
      'SERVIS_NOTU=SERVIS_NOTU'
      'YAZILDI=YAZILDI'
      'BRUT_TOP=BRUT_TOP'
      'NET_TOP=NET_TOP'
      'KDV_TOP=KDV_TOP'
      'DEPO_KOD=DEPO_KOD'
      'SAAT=SAAT'
      'KALEM_ISKONTO_TOPLAM_VPB=KALEM_ISKONTO_TOPLAM_VPB'
      'ISKONTO_TIP=ISKONTO_TIP'
      'ISKONTO_ORAN=ISKONTO_ORAN'
      'ISKONTO_TUTAR_VPB=ISKONTO_TUTAR_VPB'
      'ISKONTO_TOPLAM_VPB=ISKONTO_TOPLAM_VPB'
      'KDV1=KDV1'
      'KDV2=KDV2'
      'KDV3=KDV3'
      'KDV4=KDV4'
      'KDV5=KDV5'
      'OTV=OTV'
      'VADE_GUN=VADE_GUN'
      'VADE_TARIH=VADE_TARIH'
      'KDV1_ORAN=KDV1_ORAN'
      'KDV2_ORAN=KDV2_ORAN'
      'KDV3_ORAN=KDV3_ORAN'
      'KDV4_ORAN=KDV4_ORAN'
      'KDV5_ORAN=KDV5_ORAN'
      'ODEMETAR=ODEMETAR'
      'PROJE_KOD=PROJE_KOD'
      'PROJE_AD=PROJE_AD'
      'MASRAF_MERK=MASRAF_MERK'
      'KOD1=KOD1'
      'KOD2=KOD2'
      'KOD3=KOD3'
      'KOD4=KOD4'
      'SECIM=SECIM'
      'KAPANDI=KAPANDI'
      'SEVK_ADRES_KOD=SEVK_ADRES_KOD')
    DataSet = qryFAT_IRS
    Left = 400
    Top = 209
  end
  object qryURUNHAR: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    FieldsDisplayFormat.Strings = (
      'MIKTAR=#,##.00'
      'TUTARDOV=#,##.00'
      'TUTARVPB=#,##.00'
      'DOVKUR=#,##.00'
      'ISKONTO_TUTAR=#,##.00'
      'ISKONTO_TUTAR_VPB=#,##.00'
      'BIRIMFIY=#,##.00'
      'KDV_TUTAR=#,##.00')
    FieldsDisplayLabel.Strings = (
      'ACIKLAMA=Ac'#305'klama'
      'URUN_KOD='#220'r'#252'n Kodu'
      'URUN_AD='#220'r'#252'n Ad'#305
      'OLCUBIRIM='#214'l'#231#252' Birimi'
      'MIKTAR=Miktar'
      'BIRIMFIY=Birim Fiyat'
      'DOVKOD=Para Birimi'
      'DOVKUR=D'#246'viz Kuru'
      'TUTARDOV=Tutar'
      'TUTARVPB=Tutar VPB'
      'TARIH=Tarih'
      'DEPO_KOD=Depo Kodu'
      'DEPO_AD=Depo Ad'#305
      'KDV=KDV'
      'ISKONTO_ORAN= '#304's. Oran'
      'ISKONTO_TUTAR='#304's.Tutar'
      'ISKONTO_TUTAR_VPB='#304'skonto Tutar VPB'
      'ISKONTO_TIP='#304'skonto Tip'
      'KDV_TUTAR=KDV Tutar'
      'BIRIM_FIY=Birim Fiyat'
      'TUTAR=Tutar'
      'TUTAR_VPB=Tutar VPB')
    FieldsDisplayWidth.Strings = (
      'URUN_KOD=83'
      'BIRIMFIY=86'
      'DOVKOD=55'
      'MIKTAR=45'
      'OLCUBIRIM=56'
      'TUTARDOV=92'
      'TUTARVPB=107'
      'ACIKLAMA=182'
      'KDV_TUTAR=71'
      'BIRIM_FIY=74'
      'TUTAR=114'
      'TUTAR_VPB=118')
    FieldsIndex.Strings = (
      'FATURA_ID'
      'FATURA_SID'
      'URUN_KOD'
      'ACIKLAMA'
      'BIRIM_FIY'
      'DOVKOD'
      'MIKTAR'
      'OLCUBIRIM'
      'URUN_AD'
      'DOVKUR'
      'TARIH'
      'DEPO_KOD'
      'DEPO_AD'
      'KDV'
      'ISKONTO_ORAN'
      'ISKONTO_TUTAR'
      'ISKONTO_TUTAR_VPB'
      'ISKONTO_TIP'
      'URUNHAR_ID'
      'URUNHAR_SID'
      'FIILI_TAR'
      'DOV_BAZ_TAR'
      'TIP'
      'BELGE_TUR'
      'BELGE_ID'
      'BELGE_SID'
      'BELGE_SIRA_NO'
      'OLCUBIRIM_URN_OB'
      'MIKTAR_URN_OB'
      'TUTAR'
      'TUTAR_VPB'
      'URUN_DOVKOD'
      'TUTAR_URUN_DOVKOD'
      'BIRIM_FIY_VPB'
      'BIRIM_FIY_URN_DOVKOD'
      'IRSALIYE_ID'
      'IRSALIYE_SID'
      'MASRAF_MERK'
      'KDV_TUTAR'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4')
    FieldsVisible.Strings = (
      'FATURA_D_ID=FALSE'
      'FATURA_D_SID=FALSE'
      'FATURA_ID=FALSE'
      'FATURA_SID=FALSE'
      'URUN_AD=FALSE'
      'DOVKUR=FALSE'
      'TARIH=FALSE'
      'REF_BELGE_ID=FALSE'
      'REF_BELGE_TUR=FALSE'
      'DEPO_KOD=FALSE'
      'DEPO_AD=FALSE'
      'KDV=FALSE'
      'ISKONTO_ORAN=FALSE'
      'ISKONTO_TUTAR=FALSE'
      'ISKONTO_TUTAR_VPB=FALSE'
      'ISKONTO_TIP=FALSE'
      'SIRA_NO=FALSE'
      'KDV_TUTAR=FALSE'
      'KOD4=FALSE'
      'KOD3=FALSE'
      'KOD2=FALSE'
      'KOD1=FALSE'
      'MASRAF_MERK=FALSE'
      'IRSALIYE_SID=FALSE'
      'IRSALIYE_ID=FALSE'
      'BIRIM_FIY_URN_DOVKOD=FALSE'
      'BIRIM_FIY_VPB=FALSE'
      'BIRIM_FIY=TRUE'
      'TUTAR_URUN_DOVKOD=FALSE'
      'URUN_DOVKOD=FALSE'
      'MIKTAR_URN_OB=FALSE'
      'OLCUBIRIM_URN_OB=FALSE'
      'BELGE_SIRA_NO=FALSE'
      'BELGE_SID=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_TUR=FALSE'
      'TIP=FALSE'
      'DOV_BAZ_TAR=FALSE'
      'FIILI_TAR=FALSE'
      'URUNHAR_SID=FALSE'
      'URUNHAR_ID=FALSE'
      'BIRIM_FIY_URN_OB=FALSE'
      'SECIM=FALSE'
      'CIKIS_MIKTAR=FALSE'
      'FAT_IRS_SEP=FALSE'
      'AKTARILAN_MIKTAR=FALSE'
      'KAPANDI=FALSE'
      'FATURA_URUN_HAR_ID=FALSE'
      'ONARIM_ID=FALSE'
      'ONARIM_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT URUNHAR_ID'
      '     , URUNHAR_SID'
      '     , TARIH'
      '     , FIILI_TAR'
      '     , DOV_BAZ_TAR'
      '     , URUN_KOD'
      
        '     , (SELECT  URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD=SRV_A' +
        'RAC_ONARIM_D.URUN_KOD) AS URUN_AD'
      '     , ACIKLAMA'
      '     , TIP'
      '     , BELGE_TUR'
      '     , BELGE_ID'
      '     , BELGE_SID'
      '     , BELGE_SIRA_NO'
      '     , OLCUBIRIM'
      '     , OLCUBIRIM_URN_OB'
      '     , MIKTAR'
      '     , MIKTAR_URN_OB'
      '     , DOVKOD'
      '     , DOVKUR'
      '     , TUTAR'
      '     , TUTAR_VPB'
      '     , URUN_DOVKOD'
      '     , TUTAR_URUN_DOVKOD'
      '     , BIRIM_FIY'
      '     , BIRIM_FIY_VPB'
      '     , BIRIM_FIY_URN_DOVKOD'
      '     , ISKONTO_TIP'
      '     , ISKONTO_ORAN'
      '     , ISKONTO_TUTAR'
      '     , ISKONTO_TUTAR_VPB'
      '     , DEPO_KOD'
      
        '     , (SELECT DEPO.ADI FROM DEPO WHERE DEPO.DEPO_KOD = SRV_ARAC' +
        '_ONARIM_D.DEPO_KOD) AS DEPO_AD'
      '     , ONARIM_ID'
      '     , ONARIM_SID'
      '     , FATURA_ID'
      '     , FATURA_SID'
      '     , IRSALIYE_ID'
      '     , IRSALIYE_SID'
      '     , MASRAF_MERK'
      '     , KDV'
      '     , KDV_TUTAR'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , SECIM'
      '     , FAT_IRS_SEP'
      '     , AKTARILAN_MIKTAR'
      '     , KAPANDI'
      '     , FATURA_URUN_HAR_ID'
      'FROM SRV_ARAC_ONARIM_D'
      'WHERE ONARIM_ID=:PRM_ONARIM_ID And ONARIM_SID=:PRM_ONARIM_SID'
      'ORDER BY URUNHAR_ID;')
    ColorScheme = False
    DefaultValues.Strings = (
      'FATURA_ID=0'
      'BIRIM_FIY=0'
      'DOVKOD=YTL'
      'MIKTAR=0'
      'DOVKUR=0'
      'ISKONTO_TUTAR=0'
      'ISKONTO_TUTAR_VPB=0'
      'URUNHAR_ID=0'
      'BELGE_TUR=0'
      'BELGE_ID=0'
      'MIKTAR_URN_OB=0'
      'TUTAR=0'
      'TUTAR_VPB=0'
      'URUN_DOVKOD=YTL'
      'TUTAR_URUN_DOVKOD=0'
      'BIRIM_FIY_VPB=0'
      'BIRIM_FIY_URN_DOVKOD=0'
      'IRSALIYE_ID=0'
      'KDV_TUTAR=0'
      'ONARIM_ID=0')
    KeyLinks.Strings = (
      'SRV_ARAC_ONARIM_D.URUNHAR_ID'
      'SRV_ARAC_ONARIM_D.URUNHAR_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 286
    Top = 340
    ParamValues = (
      'PRM_ONARIM_ID=0')
  end
  object dtsURUNHAR: TIB_DataSource
    AutoInsert = False
    Dataset = qryURUNHAR
    Left = 292
    Top = 392
  end
  object IB_Query1: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT O.ONARIM_ID'
      '     , O.ONARIM_SID'
      '     , O.ARAC_KODU'
      
        '     ,(SELECT PLAKA FROM SRV_ARAC WHERE SRV_ARAC_ONARIM.ARAC_KOD' +
        'U=SRV_ARAC.ARAC_KOD) AS ARAC_PLAKA'
      '     , O.GELIS_NEDENI'
      '     , O.GIRIS_KM'
      '     , O.ONCEKI_KM'
      '     , O.ODEME_SEKLI'
      '     , O.YAKIT_SEVIYESI'
      '     , O.GARANTI_ISLEMI'
      '     , O.EXSPERTIZ_ISLEMI'
      '     , O.SOK_PAR_IADE'
      '     , O.TESLIM_EDEN'
      '     , O.ALACAK_OLAN'
      '     , O.TELEFON'
      '     , O.SIGORTA_KOD'
      '     , O.TESLIM_TAR'
      '     , O.TESLIM_SAAT'
      '     , O.TAHMINI_PARCA_TUTAR'
      '     , O.TAHMINI_ISCILIK_TUTAR'
      '     , O.GIRIS_TARIH'
      '     , O.GIRIS_SAAT'
      '     , O.ONARIM_ISTEKLERI'
      '     , O.MUSTERI_SIKAYETI'
      '     , O.SERVIS_NOTU'
      '     , O.YAZILDI'
      '     , O.ACIKLAMA'
      '     , O.BRUT_TOP'
      '     , O.NET_TOP'
      '     , O.GENEL_TOP'
      '     , O.KDV_TOP'
      '     , O.DEPO_KOD'
      '     , O.SAAT'
      '     , O.KALEM_ISKONTO_TOPLAM_VPB'
      '     , O.ISKONTO_TIP'
      '     , O.ISKONTO_ORAN'
      '     , O.ISKONTO_TUTAR_VPB'
      '     , O.ISKONTO_TOPLAM_VPB'
      '     , O.KDV1'
      '     , O.KDV2'
      '     , O.KDV3'
      '     , O.KDV4'
      '     , O.KDV5'
      '     , O.OTV'
      '     , O.VADE_GUN'
      '     , O.VADE_TARIH'
      '     , O.KDV1_ORAN'
      '     , O.KDV2_ORAN'
      '     , O.KDV3_ORAN'
      '     , O.KDV4_ORAN'
      '     , O.KDV5_ORAN'
      '     , O.ODEMETAR'
      '     , O.PROJE_KOD'
      
        '     , (Select PROJE.PROJE_AD From PROJE Where PROJE.PROJE_KOD=S' +
        'RV_ARAC_ONARIM.PROJE_KOD) As PROJE_AD'
      '     , O.MASRAF_MERK'
      '     , O.KOD1'
      '     , O.KOD2'
      '     , O.KOD3'
      '     , O.KOD4'
      '     , O.SECIM'
      '     , O.KAPANDI'
      '     , O.SEVK_ADRES_KOD'
      '     , O.CARI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SRV_ARAC_ONA' +
        'RIM.CARI_KOD) AS CARI_ADI'
      ''
      '     , OD.URUNHAR_ID'
      '     , OD.URUNHAR_SID'
      '     , OD.TARIH'
      '     , OD.FIILI_TAR'
      '     , OD.DOV_BAZ_TAR'
      '     , OD.URUN_KOD'
      
        '     , (SELECT  URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD=SRV_A' +
        'RAC_ONARIM_D.URUN_KOD) AS URUN_AD'
      '     , OD.ACIKLAMA ACIKLAMA_DETAY'
      '     , OD.TIP'
      '     , OD.BELGE_TUR'
      '     , OD.BELGE_ID'
      '     , OD.BELGE_SID'
      '     , OD.BELGE_SIRA_NO'
      '     , OD.OLCUBIRIM'
      '     , OD.OLCUBIRIM_URN_OB'
      '     , OD.MIKTAR'
      '     , OD.MIKTAR_URN_OB'
      '     , OD.DOVKOD'
      '     , OD.DOVKUR'
      '     , OD.TUTAR'
      '     , OD.TUTAR_VPB'
      '     , OD.URUN_DOVKOD'
      '     , OD.TUTAR_URUN_DOVKOD'
      '     , OD.BIRIM_FIY'
      '     , OD.BIRIM_FIY_VPB'
      '     , OD.BIRIM_FIY_URN_DOVKOD'
      '     , OD.ISKONTO_TIP'
      '     , OD.ISKONTO_ORAN'
      '     , OD.ISKONTO_TUTAR'
      '     , OD.ISKONTO_TUTAR_VPB'
      '     , OD.DEPO_KOD'
      
        '     , (SELECT DEPO.ADI FROM DEPO WHERE DEPO.DEPO_KOD = SRV_ARAC' +
        '_ONARIM_D.DEPO_KOD) AS DEPO_AD'
      '     , OD.ONARIM_ID'
      '     , OD.ONARIM_SID'
      '     , OD.FATURA_ID'
      '     , OD.FATURA_SID'
      '     , OD.IRSALIYE_ID'
      '     , OD.IRSALIYE_SID'
      '     , OD.MASRAF_MERK'
      '     , OD.KDV'
      '     , OD.KDV_TUTAR'
      '     , OD.KOD1'
      '     , OD.KOD2'
      '     , OD.KOD3'
      '     , OD.KOD4'
      '     , OD.SECIM'
      '     , OD.FAT_IRS_SEP'
      '     , OD.AKTARILAN_MIKTAR'
      '     , OD.KAPANDI'
      '     , OD.FATURA_URUN_HAR_ID'
      'FROM SRV_ARAC_ONARIM O'
      
        'INNER JOIN SRV_ARAC_ONARIM_D OD ON (O.ONARIM_ID=OD.ONARIM_ID And' +
        ' O.ONARIM_SID=OD.ONARIM_SID)'
      'WHERE O.ONARIM_ID>0 '
      ''
      '')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 516
    Top = 211
    ParamValues = (
      'PRM_ONARIM_ID=0')
  end
  object frxIBODts_On_Fis_Lis_Det: TfrxIBODataset
    UserName = 'frxIBODts_On_Fis_Lis_Det'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ONARIM_ID=ONARIM_ID'
      'ONARIM_SID=ONARIM_SID'
      'ARAC_KODU=ARAC_KODU'
      'ARAC_PLAKA=ARAC_PLAKA'
      'GELIS_NEDENI=GELIS_NEDENI'
      'GIRIS_KM=GIRIS_KM'
      'ONCEKI_KM=ONCEKI_KM'
      'ODEME_SEKLI=ODEME_SEKLI'
      'YAKIT_SEVIYESI=YAKIT_SEVIYESI'
      'GARANTI_ISLEMI=GARANTI_ISLEMI'
      'EXSPERTIZ_ISLEMI=EXSPERTIZ_ISLEMI'
      'SOK_PAR_IADE=SOK_PAR_IADE'
      'TESLIM_EDEN=TESLIM_EDEN'
      'ALACAK_OLAN=ALACAK_OLAN'
      'TELEFON=TELEFON'
      'SIGORTA_KOD=SIGORTA_KOD'
      'TESLIM_TAR=TESLIM_TAR'
      'TESLIM_SAAT=TESLIM_SAAT'
      'TAHMINI_PARCA_TUTAR=TAHMINI_PARCA_TUTAR'
      'TAHMINI_ISCILIK_TUTAR=TAHMINI_ISCILIK_TUTAR'
      'GIRIS_TARIH=GIRIS_TARIH'
      'GIRIS_SAAT=GIRIS_SAAT'
      'ONARIM_ISTEKLERI=ONARIM_ISTEKLERI'
      'MUSTERI_SIKAYETI=MUSTERI_SIKAYETI'
      'SERVIS_NOTU=SERVIS_NOTU'
      'YAZILDI=YAZILDI'
      'ACIKLAMA=ACIKLAMA'
      'BRUT_TOP=BRUT_TOP'
      'NET_TOP=NET_TOP'
      'GENEL_TOP=GENEL_TOP'
      'KDV_TOP=KDV_TOP'
      'DEPO_KOD=DEPO_KOD'
      'SAAT=SAAT'
      'KALEM_ISKONTO_TOPLAM_VPB=KALEM_ISKONTO_TOPLAM_VPB'
      'ISKONTO_TIP=ISKONTO_TIP'
      'ISKONTO_ORAN=ISKONTO_ORAN'
      'ISKONTO_TUTAR_VPB=ISKONTO_TUTAR_VPB'
      'ISKONTO_TOPLAM_VPB=ISKONTO_TOPLAM_VPB'
      'KDV1=KDV1'
      'KDV2=KDV2'
      'KDV3=KDV3'
      'KDV4=KDV4'
      'KDV5=KDV5'
      'OTV=OTV'
      'VADE_GUN=VADE_GUN'
      'VADE_TARIH=VADE_TARIH'
      'KDV1_ORAN=KDV1_ORAN'
      'KDV2_ORAN=KDV2_ORAN'
      'KDV3_ORAN=KDV3_ORAN'
      'KDV4_ORAN=KDV4_ORAN'
      'KDV5_ORAN=KDV5_ORAN'
      'ODEMETAR=ODEMETAR'
      'PROJE_KOD=PROJE_KOD'
      'PROJE_AD=PROJE_AD'
      'MASRAF_MERK=MASRAF_MERK'
      'KOD1=KOD1'
      'KOD2=KOD2'
      'KOD3=KOD3'
      'KOD4=KOD4'
      'SECIM=SECIM'
      'KAPANDI=KAPANDI'
      'SEVK_ADRES_KOD=SEVK_ADRES_KOD'
      'CARI_KOD=CARI_KOD'
      'CARI_ADI=CARI_ADI'
      'URUNHAR_ID=URUNHAR_ID'
      'URUNHAR_SID=URUNHAR_SID'
      'TARIH=TARIH'
      'FIILI_TAR=FIILI_TAR'
      'DOV_BAZ_TAR=DOV_BAZ_TAR'
      'URUN_KOD=URUN_KOD'
      'URUN_AD=URUN_AD'
      'ACIKLAMA_DETAY=ACIKLAMA_DETAY'
      'TIP=TIP'
      'BELGE_TUR=BELGE_TUR'
      'BELGE_ID=BELGE_ID'
      'BELGE_SID=BELGE_SID'
      'BELGE_SIRA_NO=BELGE_SIRA_NO'
      'OLCUBIRIM=OLCUBIRIM'
      'OLCUBIRIM_URN_OB=OLCUBIRIM_URN_OB'
      'MIKTAR=MIKTAR'
      'MIKTAR_URN_OB=MIKTAR_URN_OB'
      'DOVKOD=DOVKOD'
      'DOVKUR=DOVKUR'
      'TUTAR=TUTAR'
      'TUTAR_VPB=TUTAR_VPB'
      'URUN_DOVKOD=URUN_DOVKOD'
      'TUTAR_URUN_DOVKOD=TUTAR_URUN_DOVKOD'
      'BIRIM_FIY=BIRIM_FIY'
      'BIRIM_FIY_VPB=BIRIM_FIY_VPB'
      'BIRIM_FIY_URN_DOVKOD=BIRIM_FIY_URN_DOVKOD'
      'ISKONTO_TIP=ISKONTO_TIP'
      'ISKONTO_ORAN=ISKONTO_ORAN'
      'ISKONTO_TUTAR=ISKONTO_TUTAR'
      'ISKONTO_TUTAR_VPB=ISKONTO_TUTAR_VPB'
      'DEPO_KOD=DEPO_KOD'
      'DEPO_AD=DEPO_AD'
      'ONARIM_ID=ONARIM_ID'
      'ONARIM_SID=ONARIM_SID'
      'FATURA_ID=FATURA_ID'
      'FATURA_SID=FATURA_SID'
      'IRSALIYE_ID=IRSALIYE_ID'
      'IRSALIYE_SID=IRSALIYE_SID'
      'MASRAF_MERK=MASRAF_MERK'
      'KDV=KDV'
      'KDV_TUTAR=KDV_TUTAR'
      'KOD1=KOD1'
      'KOD2=KOD2'
      'KOD3=KOD3'
      'KOD4=KOD4'
      'SECIM=SECIM'
      'FAT_IRS_SEP=FAT_IRS_SEP'
      'AKTARILAN_MIKTAR=AKTARILAN_MIKTAR'
      'KAPANDI=KAPANDI'
      'FATURA_URUN_HAR_ID=FATURA_URUN_HAR_ID')
    DataSet = IB_Query1
    Left = 520
    Top = 265
  end
end
