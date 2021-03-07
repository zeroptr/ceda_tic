object frmAracMasrafSDGL: TfrmAracMasrafSDGL
  Left = 148
  Top = 154
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Ara'#231' Masraf Arama'
  ClientHeight = 385
  ClientWidth = 695
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
    Top = 355
    Width = 695
    Height = 30
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      695
      30)
    object cmdCancel: TBitBtn
      Left = 530
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
      Left = 620
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
  end
  object Panel1: TPanel
    Left = 0
    Top = 44
    Width = 695
    Height = 101
    Align = alTop
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 42
      Width = 55
      Height = 13
      Caption = 'Tarih Aral'#305#287#305
    end
    object Label5: TLabel
      Left = 191
      Top = 42
      Width = 21
      Height = 13
      Caption = '> - <'
    end
    object Label1: TLabel
      Left = 376
      Top = 73
      Width = 30
      Height = 13
      Caption = 'Fi'#351' No'
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 690
      Height = 33
      TabOrder = 0
      object lblKASA_AD: TLabel
        Left = 190
        Top = 11
        Width = 233
        Height = 17
        AutoSize = False
        Color = clMoneyGreen
        ParentColor = False
      end
      object lblKASA_KOD: TLabel
        Left = 98
        Top = 11
        Width = 88
        Height = 17
        AutoSize = False
        Color = clMoneyGreen
        ParentColor = False
      end
      object btnCARI: TButton
        Left = 4
        Top = 9
        Width = 87
        Height = 21
        Caption = '&Ara'#231' Listesi'
        TabOrder = 0
        OnClick = btnCARIClick
      end
    end
    object dtpTanzimTar1: TDateTimePicker
      Left = 68
      Top = 39
      Width = 119
      Height = 21
      Date = 37554.393445972200000000
      Time = 37554.393445972200000000
      ShowCheckbox = True
      Checked = False
      TabOrder = 1
      OnEnter = dtpTanzimTar1Enter
      OnExit = dtpTanzimTar1Exit
    end
    object dtpTanzimTar2: TDateTimePicker
      Left = 215
      Top = 39
      Width = 128
      Height = 21
      Date = 0.393445972200425000
      Time = 0.393445972200425000
      ShowCheckbox = True
      Checked = False
      TabOrder = 2
      OnEnter = dtpTanzimTar1Enter
      OnExit = dtpTanzimTar1Exit
    end
    object txtFisNo: TEdit
      Left = 409
      Top = 68
      Width = 88
      Height = 21
      TabOrder = 4
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtFisNoExit
    end
    object btn_Ara: TButton
      Left = 611
      Top = 67
      Width = 78
      Height = 23
      Caption = '&Ara'
      TabOrder = 6
      OnClick = btn_AraClick
    end
    object GroupBox2: TGroupBox
      Left = 2
      Top = 59
      Width = 367
      Height = 34
      TabOrder = 3
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
      Left = 499
      Top = 68
      Width = 109
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      OnEnter = cboISLEMEnter
      OnExit = cboISLEMExit
    end
  end
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 145
    Width = 695
    Height = 210
    CustomGlyphsSupplied = []
    DataSource = dts_Liste
    Align = alClient
    OnDblClick = btnTamamClick
    BorderStyle = bsNone
    ReadOnly = True
    TabOrder = 2
    OnKeyPress = IB_Grid1KeyPress
    RowSelect = True
    Ctl3DShallow = True
  end
  object pnlRAPKOD: TPanel
    Left = 0
    Top = 0
    Width = 695
    Height = 44
    Align = alTop
    TabOrder = 0
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
    end
    object txtKOD1: TEdit
      Left = 121
      Top = 17
      Width = 79
      Height = 21
      TabOrder = 2
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD1Exit
    end
    object txtKOD2: TEdit
      Left = 227
      Top = 17
      Width = 79
      Height = 21
      TabOrder = 4
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD2Exit
    end
    object txtKOD3: TEdit
      Left = 333
      Top = 17
      Width = 79
      Height = 21
      TabOrder = 6
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD3Exit
    end
    object txtKOD4: TEdit
      Left = 440
      Top = 17
      Width = 79
      Height = 21
      TabOrder = 8
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD4Exit
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
    Dataset = qry_Kasa_Liste
    Left = 179
    Top = 168
  end
  object qry_Kasa_Liste: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    FieldsDisplayLabel.Strings = (
      'KASA_KOD=Kasa'
      'KASA_AD=Kasa Ad'
      'TARIH=Tarih'
      'FIILI_TAR=Tarih'
      'DOV_BAZ_TAR=D'#246'viz Baz Tarihi'
      'TIP=Tip'
      'ACIKLAMA=A'#231#305'klama'
      'DOVKOD=D. Kod.'
      'DOVKUR=D'#246'viz Kuru'
      'TUTAR=Tutar'
      'KASADEGER=Kasa Degeri'
      'TUTAR_VPB=Tutar VBP'
      'KARSI_KOD=Kod'
      'MC=MC'
      'KASAHAR_ID=FIS NO'
      'ARAC_KOD=Ara'#231' Kodu'
      'ARAC_PLAKA=Ara'#231' Plaka'
      'BA=Borc/Alacak'
      'BELGE_TUR=Belge T'#252'r'#252
      'BELGE_ID=Belge Id'
      'MASRAF_MERK=Masraf Merk'
      'KOD1=Kod1'
      'KOD2=Kod2'
      'KOD3=Kod3'
      'KOD4=Kod4')
    FieldsDisplayWidth.Strings = (
      'KARSI_KOD=90'
      'ACIKLAMA=96'
      'DOVKOD=37'
      'DOVKUR=61'
      'TUTAR=88'
      'FIS_NO=43'
      'TIP=25'
      'KASADEGER=108'
      'TARIH=63'
      'BA=65')
    FieldsIndex.Strings = (
      'ARAC_KOD'
      'ARAC_PLAKA'
      'TARIH'
      'DOV_BAZ_TAR'
      'ACIKLAMA'
      'DOVKOD'
      'DOVKUR'
      'TUTAR'
      'TUTAR_VPB'
      'ARACHAR_ID'
      'ARACHAR_SID'
      'BA'
      'BELGE_TUR'
      'BELGE_ID'
      'BELGE_SID'
      'SIRA_NO'
      'MASRAF_MERK'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4')
    FieldsVisible.Strings = (
      'KASAHAR_ID=TRUE'
      'KASAHAR_SID=FALSE'
      'TARIH=TRUE'
      'KASA_KOD=FALSE'
      'KASA_AD=FALSE'
      'FIILI_TAR=FALSE'
      'DOV_BAZ_TAR=FALSE'
      'TUTAR_VPB=FALSE'
      'FIS_NO=TRUE'
      'PLASIYER_KOD=FALSE'
      'PLASIYER_AD=FALSE'
      'PROJE_KOD=FALSE'
      'PROJE_ADD=FALSE'
      'ISLEM_TIP=FALSE'
      'KASA_DOVKOD=FALSE'
      'TIP=TRUE'
      'BELGE_TUR=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE'
      'DOVKOD=TRUE'
      'DOVKUR=TRUE'
      'TUTAR=TRUE'
      'KASADEGER=TRUE'
      'ACIKLAMA=TRUE'
      'ARACHAR_ID=FALSE'
      'ARACHAR_SID=FALSE'
      'SIRA_NO=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT ARACHAR_ID'
      '     , ARACHAR_SID'
      '     , ARAC_KOD'
      
        '     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=ARACHAR.ARAC_K' +
        'OD) AS ARAC_PLAKA'
      '     , TARIH'
      '     , BA'
      '     , DOVKOD'
      '     , DOVKUR'
      '     , TUTAR'
      '     , TUTAR_VPB'
      '     , ACIKLAMA'
      '     , BELGE_TUR'
      '     , BELGE_ID'
      '     , BELGE_SID'
      '     , SIRA_NO'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , DOV_BAZ_TAR'
      'FROM ARACHAR'
      '')
    AutoPostDelete = False
    ColorScheme = False
    DefaultValues.Strings = (
      'MC=C')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItemNo = 1
    PreparedEdits = False
    PreparedInserts = False
    RequestLive = True
    SearchedDeletes = False
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 105
    Top = 168
  end
end
